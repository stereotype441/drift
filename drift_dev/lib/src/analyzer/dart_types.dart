import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/type_provider.dart';
import 'package:analyzer/dart/element/type_system.dart';
import 'package:drift_dev/moor_generator.dart';
import 'package:drift_dev/src/analyzer/errors.dart';
import 'package:drift_dev/src/analyzer/runner/steps.dart';

import 'helper.dart';

class FoundDartClass {
  final ClassElement classElement;

  /// The instantiation of the [classElement], if the found type was a generic
  /// typedef.
  final List<DartType>? instantiation;

  FoundDartClass(this.classElement, this.instantiation);
}

ExistingRowClass? validateExistingClass(
    Iterable<MoorColumn> columns,
    FoundDartClass dartClass,
    String constructor,
    bool generateInsertable,
    Step step) {
  final errors = step.errors;
  final desiredClass = dartClass.classElement;
  ConstructorElement? ctor;

  if (dartClass.instantiation != null) {
    final instantiation = desiredClass.instantiate(
      typeArguments: dartClass.instantiation!,
      nullabilitySuffix: NullabilitySuffix.none,
    );

    // If we have an instantation, search the constructor on the type because it
    // will report the right parameter types if they're generic.
    ctor = instantiation.lookUpConstructor(constructor, desiredClass.library);
  } else {
    ctor = desiredClass.getNamedConstructor(constructor);
  }

  if (ctor == null) {
    final msg = constructor == ''
        ? 'The desired data class must have an unnamed constructor'
        : 'The desired data class does not have a constructor named '
            '$constructor';

    errors.report(ErrorInDartCode(affectedElement: desiredClass, message: msg));
    return null;
  }

  // Note: It's ok if not all columns are present in the custom row class, we
  // just won't load them in that case.
  // However, when we're supposed to generate an insertable, all columns must
  // appear as getters in the target class.
  final unmatchedColumnsByName = {
    for (final column in columns) column.dartGetterName: column
  };

  final columnsToParameter = <MoorColumn, ParameterElement>{};

  for (final parameter in ctor.parameters) {
    final column = unmatchedColumnsByName.remove(parameter.name);
    if (column != null) {
      columnsToParameter[column] = parameter;
      _checkParameterType(parameter, column, step);
    } else if (!parameter.isOptional) {
      errors.report(ErrorInDartCode(
        affectedElement: parameter,
        message: 'Unexpected parameter ${parameter.name} which has no matching '
            'column.',
      ));
    }
  }

  if (generateInsertable) {
    // Go through all columns, make sure that the class has getters for them.
    final missingGetters = <String>[];

    for (final column in columns) {
      final matchingField = dartClass.classElement
          .lookUpGetter(column.dartGetterName, dartClass.classElement.library);

      if (matchingField == null) {
        missingGetters.add(column.dartGetterName);
      }
    }

    if (missingGetters.isNotEmpty) {
      errors.report(ErrorInDartCode(
        affectedElement: dartClass.classElement,
        severity: Severity.criticalError,
        message:
            'This class used as a custom row class for which an insertable '
            'is generated. This means that it must define getters for all '
            'columns, but some are missing: ${missingGetters.join(', ')}',
      ));
    }
  }

  return ExistingRowClass(
      desiredClass, ctor, columnsToParameter, generateInsertable,
      typeInstantiation: dartClass.instantiation ?? const []);
}

UsedTypeConverter? readTypeConverter(
  LibraryElement library,
  Expression dartExpression,
  ColumnType columnType,
  bool columnIsNullable,
  void Function(String) reportError,
  HelperLibrary helper, {
  DriftDartType? resolvedDartType,
}) {
  final staticType = dartExpression.staticType;
  final asTypeConverter =
      staticType != null ? helper.asTypeConverter(staticType) : null;

  if (asTypeConverter == null) {
    reportError('Not a type converter');
    return null;
  }

  final dartType = asTypeConverter.typeArguments[0];
  final sqlType = asTypeConverter.typeArguments[1];

  final typeSystem = library.typeSystem;
  final dartTypeNullable = typeSystem.isNullable(dartType);
  final sqlTypeNullable = typeSystem.isNullable(sqlType);

  final appliesToJsonToo = helper.isJsonAwareTypeConverter(staticType, library);

  // Make the type converter support nulls by just mapping null to null if this
  // converter is otherwise non-nullable in both directions but applied on a
  // nullable column
  final skipForNull = !dartTypeNullable && !sqlTypeNullable && columnIsNullable;

  if (sqlTypeNullable != columnIsNullable) {
    if (!columnIsNullable) {
      reportError('This column is non-nullable in the database, but has a '
          'type converter with a nullable SQL type, meaning that it may '
          "potentially map to `null` which can't be stored in the database.");
    } else if (!skipForNull) {
      final alternative = appliesToJsonToo
          ? 'JsonTypeConverter.asNullable'
          : 'NullAwareTypeConverter.wrap';

      reportError('This column is nullable, but the type converter has a non-'
          "nullable SQL type, meaning that it won't be able to map `null` "
          'from the database to Dart.\n'
          'Try wrapping the converter in `$alternative`');
    }
  }

  _checkType(columnType, null, sqlType, library.typeProvider,
      library.typeSystem, reportError);

  return UsedTypeConverter(
    expression: dartExpression.toSource(),
    dartType: resolvedDartType ?? DriftDartType.of(dartType),
    sqlType: sqlType,
    dartTypeIsNullable: dartTypeNullable,
    sqlTypeIsNullable: sqlTypeNullable,
    alsoAppliesToJsonConversion: appliesToJsonToo,
    skipForNulls: skipForNull,
  );
}

void _checkParameterType(
    ParameterElement element, MoorColumn column, Step step) {
  final type = element.type;
  final library = element.library!;
  final typesystem = library.typeSystem;

  void error(String message) {
    step.errors.report(ErrorInDartCode(
      affectedElement: element,
      message: message,
    ));
  }

  final nullableDartType = column.typeConverter != null
      ? column.typeConverter!.mapsToNullableDart
      : column.nullableInDart;

  if (library.isNonNullableByDefault &&
      nullableDartType &&
      !typesystem.isNullable(type) &&
      element.isRequired) {
    error('Expected this parameter to be nullable');
    return;
  }

  _checkType(
    column.type,
    column.typeConverter,
    element.type,
    library.typeProvider,
    library.typeSystem,
    error,
  );
}

void _checkType(
  ColumnType columnType,
  UsedTypeConverter? typeConverter,
  DartType typeToCheck,
  TypeProvider typeProvider,
  TypeSystem typeSystem,
  void Function(String) error,
) {
  DriftDartType expectedDartType;
  if (typeConverter != null) {
    expectedDartType = typeConverter.dartType;
    if (typeConverter.skipForNulls) {
      typeToCheck = typeSystem.promoteToNonNull(typeToCheck);
    }
  } else {
    expectedDartType = DriftDartType.of(typeProvider.typeFor(columnType));
  }

  // BLOB columns should be stored in an Uint8List (or a supertype of that).
  // We don't get a Uint8List from the type provider unfortunately, but as it
  // cannot be extended we can just check for that manually.
  final isAllowedUint8List = typeConverter == null &&
      columnType == ColumnType.blob &&
      typeToCheck is InterfaceType &&
      typeToCheck.element.name == 'Uint8List' &&
      typeToCheck.element.library.name == 'dart.typed_data';

  if (!typeSystem.isAssignableTo(expectedDartType.type, typeToCheck) &&
      !isAllowedUint8List) {
    error('Parameter must accept '
        '${expectedDartType.getDisplayString(withNullability: true)}');
  }
}

extension on TypeProvider {
  DartType typeFor(ColumnType type) {
    switch (type) {
      case ColumnType.integer:
        return intType;
      case ColumnType.bigInt:
        return intElement.library.getType('BigInt')!.instantiate(
            typeArguments: const [], nullabilitySuffix: NullabilitySuffix.none);
      case ColumnType.text:
        return stringType;
      case ColumnType.boolean:
        return boolType;
      case ColumnType.datetime:
        return intElement.library.getType('DateTime')!.instantiate(
            typeArguments: const [], nullabilitySuffix: NullabilitySuffix.none);
      case ColumnType.blob:
        return listType(intType);
      case ColumnType.real:
        return doubleType;
    }
  }
}
