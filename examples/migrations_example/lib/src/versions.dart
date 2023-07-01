import 'package:drift/internal/versioned_schema.dart' as i0;
import 'package:drift/drift.dart' as i1;
import 'package:drift/drift.dart';

final class _S1 extends i0.VersionedSchema {
  _S1({required super.database}) : super(version: 1);
  @override
  late final List<i1.DatabaseSchemaEntity> entities = [
    users,
  ];
  late final Shape0 users = Shape0(
      source: i0.VersionedTable(
        entityName: 'users',
        withoutRowId: false,
        isStrict: false,
        tableConstraints: [],
        columns: [
          _column_0,
        ],
        attachedDatabase: database,
      ),
      alias: null);
}

class Shape0 extends i0.VersionedTable {
  Shape0({required super.source, required super.alias}) : super.aliased();
  i1.GeneratedColumn<int> get id =>
      columnsByName['id']! as i1.GeneratedColumn<int>;
}

i1.GeneratedColumn<int> _column_0(String aliasedName) =>
    i1.GeneratedColumn<int>('id', aliasedName, false,
        hasAutoIncrement: true,
        type: i1.DriftSqlType.int,
        defaultConstraints:
            i1.GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));

final class _S2 extends i0.VersionedSchema {
  _S2({required super.database}) : super(version: 2);
  @override
  late final List<i1.DatabaseSchemaEntity> entities = [
    users,
  ];
  late final Shape1 users = Shape1(
      source: i0.VersionedTable(
        entityName: 'users',
        withoutRowId: false,
        isStrict: false,
        tableConstraints: [],
        columns: [
          _column_0,
          _column_1,
        ],
        attachedDatabase: database,
      ),
      alias: null);
}

class Shape1 extends i0.VersionedTable {
  Shape1({required super.source, required super.alias}) : super.aliased();
  i1.GeneratedColumn<int> get id =>
      columnsByName['id']! as i1.GeneratedColumn<int>;
  i1.GeneratedColumn<String> get name =>
      columnsByName['name']! as i1.GeneratedColumn<String>;
}

i1.GeneratedColumn<String> _column_1(String aliasedName) =>
    i1.GeneratedColumn<String>('name', aliasedName, false,
        type: i1.DriftSqlType.string);

final class _S3 extends i0.VersionedSchema {
  _S3({required super.database}) : super(version: 3);
  @override
  late final List<i1.DatabaseSchemaEntity> entities = [
    users,
    groups,
  ];
  late final Shape1 users = Shape1(
      source: i0.VersionedTable(
        entityName: 'users',
        withoutRowId: false,
        isStrict: false,
        tableConstraints: [],
        columns: [
          _column_0,
          _column_1,
        ],
        attachedDatabase: database,
      ),
      alias: null);
  late final Shape2 groups = Shape2(
      source: i0.VersionedTable(
        entityName: 'groups',
        withoutRowId: false,
        isStrict: false,
        tableConstraints: [
          'PRIMARY KEY (id)',
        ],
        columns: [
          _column_2,
          _column_3,
          _column_4,
          _column_5,
        ],
        attachedDatabase: database,
      ),
      alias: null);
}

class Shape2 extends i0.VersionedTable {
  Shape2({required super.source, required super.alias}) : super.aliased();
  i1.GeneratedColumn<int> get id =>
      columnsByName['id']! as i1.GeneratedColumn<int>;
  i1.GeneratedColumn<String> get title =>
      columnsByName['title']! as i1.GeneratedColumn<String>;
  i1.GeneratedColumn<bool> get deleted =>
      columnsByName['deleted']! as i1.GeneratedColumn<bool>;
  i1.GeneratedColumn<int> get owner =>
      columnsByName['owner']! as i1.GeneratedColumn<int>;
}

i1.GeneratedColumn<int> _column_2(String aliasedName) =>
    i1.GeneratedColumn<int>('id', aliasedName, false,
        type: i1.DriftSqlType.int, $customConstraints: 'NOT NULL');
i1.GeneratedColumn<String> _column_3(String aliasedName) =>
    i1.GeneratedColumn<String>('title', aliasedName, false,
        type: i1.DriftSqlType.string, $customConstraints: 'NOT NULL');
i1.GeneratedColumn<bool> _column_4(String aliasedName) =>
    i1.GeneratedColumn<bool>('deleted', aliasedName, true,
        type: i1.DriftSqlType.bool,
        $customConstraints: 'DEFAULT FALSE',
        defaultValue: const CustomExpression<bool>('FALSE'));
i1.GeneratedColumn<int> _column_5(String aliasedName) =>
    i1.GeneratedColumn<int>('owner', aliasedName, false,
        type: i1.DriftSqlType.int,
        $customConstraints: 'NOT NULL REFERENCES users (id)');

final class _S4 extends i0.VersionedSchema {
  _S4({required super.database}) : super(version: 4);
  @override
  late final List<i1.DatabaseSchemaEntity> entities = [
    users,
    groups,
  ];
  late final Shape1 users = Shape1(
      source: i0.VersionedTable(
        entityName: 'users',
        withoutRowId: false,
        isStrict: false,
        tableConstraints: [],
        columns: [
          _column_0,
          _column_6,
        ],
        attachedDatabase: database,
      ),
      alias: null);
  late final Shape2 groups = Shape2(
      source: i0.VersionedTable(
        entityName: 'groups',
        withoutRowId: false,
        isStrict: false,
        tableConstraints: [
          'PRIMARY KEY (id)',
        ],
        columns: [
          _column_2,
          _column_3,
          _column_4,
          _column_5,
        ],
        attachedDatabase: database,
      ),
      alias: null);
}

i1.GeneratedColumn<String> _column_6(String aliasedName) =>
    i1.GeneratedColumn<String>('name', aliasedName, false,
        type: i1.DriftSqlType.string, defaultValue: const Constant('name'));

final class _S5 extends i0.VersionedSchema {
  _S5({required super.database}) : super(version: 5);
  @override
  late final List<i1.DatabaseSchemaEntity> entities = [
    users,
    groups,
    groupCount,
  ];
  late final Shape3 users = Shape3(
      source: i0.VersionedTable(
        entityName: 'users',
        withoutRowId: false,
        isStrict: false,
        tableConstraints: [],
        columns: [
          _column_0,
          _column_6,
          _column_7,
        ],
        attachedDatabase: database,
      ),
      alias: null);
  late final Shape2 groups = Shape2(
      source: i0.VersionedTable(
        entityName: 'groups',
        withoutRowId: false,
        isStrict: false,
        tableConstraints: [
          'PRIMARY KEY (id)',
        ],
        columns: [
          _column_2,
          _column_3,
          _column_4,
          _column_5,
        ],
        attachedDatabase: database,
      ),
      alias: null);
  late final Shape4 groupCount = Shape4(
      source: i0.VersionedView(
        entityName: 'group_count',
        createViewStmt:
            'CREATE VIEW group_count AS SELECT users.*, (SELECT COUNT(*) FROM "groups" WHERE owner = users.id) AS group_count FROM users',
        columns: [
          _column_8,
          _column_1,
          _column_9,
          _column_10,
        ],
        attachedDatabase: database,
      ),
      alias: null);
}

class Shape3 extends i0.VersionedTable {
  Shape3({required super.source, required super.alias}) : super.aliased();
  i1.GeneratedColumn<int> get id =>
      columnsByName['id']! as i1.GeneratedColumn<int>;
  i1.GeneratedColumn<String> get name =>
      columnsByName['name']! as i1.GeneratedColumn<String>;
  i1.GeneratedColumn<int> get nextUser =>
      columnsByName['next_user']! as i1.GeneratedColumn<int>;
}

i1.GeneratedColumn<int> _column_7(String aliasedName) =>
    i1.GeneratedColumn<int>('next_user', aliasedName, true,
        type: i1.DriftSqlType.int,
        defaultConstraints:
            i1.GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));

class Shape4 extends i0.VersionedView {
  Shape4({required super.source, required super.alias}) : super.aliased();
  i1.GeneratedColumn<int> get id =>
      columnsByName['id']! as i1.GeneratedColumn<int>;
  i1.GeneratedColumn<String> get name =>
      columnsByName['name']! as i1.GeneratedColumn<String>;
  i1.GeneratedColumn<int> get nextUser =>
      columnsByName['next_user']! as i1.GeneratedColumn<int>;
  i1.GeneratedColumn<int> get groupCount =>
      columnsByName['group_count']! as i1.GeneratedColumn<int>;
}

i1.GeneratedColumn<int> _column_8(String aliasedName) =>
    i1.GeneratedColumn<int>('id', aliasedName, false,
        type: i1.DriftSqlType.int);
i1.GeneratedColumn<int> _column_9(String aliasedName) =>
    i1.GeneratedColumn<int>('next_user', aliasedName, true,
        type: i1.DriftSqlType.int);
i1.GeneratedColumn<int> _column_10(String aliasedName) =>
    i1.GeneratedColumn<int>('group_count', aliasedName, false,
        type: i1.DriftSqlType.int);

final class _S6 extends i0.VersionedSchema {
  _S6({required super.database}) : super(version: 6);
  @override
  late final List<i1.DatabaseSchemaEntity> entities = [
    users,
    groups,
    groupCount,
  ];
  late final Shape5 users = Shape5(
      source: i0.VersionedTable(
        entityName: 'users',
        withoutRowId: false,
        isStrict: false,
        tableConstraints: [],
        columns: [
          _column_0,
          _column_6,
          _column_11,
          _column_7,
        ],
        attachedDatabase: database,
      ),
      alias: null);
  late final Shape2 groups = Shape2(
      source: i0.VersionedTable(
        entityName: 'groups',
        withoutRowId: false,
        isStrict: false,
        tableConstraints: [
          'PRIMARY KEY (id)',
        ],
        columns: [
          _column_2,
          _column_3,
          _column_4,
          _column_5,
        ],
        attachedDatabase: database,
      ),
      alias: null);
  late final Shape6 groupCount = Shape6(
      source: i0.VersionedView(
        entityName: 'group_count',
        createViewStmt:
            'CREATE VIEW group_count AS SELECT users.*, (SELECT COUNT(*) FROM "groups" WHERE owner = users.id) AS group_count FROM users',
        columns: [
          _column_8,
          _column_1,
          _column_11,
          _column_9,
          _column_10,
        ],
        attachedDatabase: database,
      ),
      alias: null);
}

class Shape5 extends i0.VersionedTable {
  Shape5({required super.source, required super.alias}) : super.aliased();
  i1.GeneratedColumn<int> get id =>
      columnsByName['id']! as i1.GeneratedColumn<int>;
  i1.GeneratedColumn<String> get name =>
      columnsByName['name']! as i1.GeneratedColumn<String>;
  i1.GeneratedColumn<DateTime> get birthday =>
      columnsByName['birthday']! as i1.GeneratedColumn<DateTime>;
  i1.GeneratedColumn<int> get nextUser =>
      columnsByName['next_user']! as i1.GeneratedColumn<int>;
}

i1.GeneratedColumn<DateTime> _column_11(String aliasedName) =>
    i1.GeneratedColumn<DateTime>('birthday', aliasedName, true,
        type: i1.DriftSqlType.dateTime);

class Shape6 extends i0.VersionedView {
  Shape6({required super.source, required super.alias}) : super.aliased();
  i1.GeneratedColumn<int> get id =>
      columnsByName['id']! as i1.GeneratedColumn<int>;
  i1.GeneratedColumn<String> get name =>
      columnsByName['name']! as i1.GeneratedColumn<String>;
  i1.GeneratedColumn<DateTime> get birthday =>
      columnsByName['birthday']! as i1.GeneratedColumn<DateTime>;
  i1.GeneratedColumn<int> get nextUser =>
      columnsByName['next_user']! as i1.GeneratedColumn<int>;
  i1.GeneratedColumn<int> get groupCount =>
      columnsByName['group_count']! as i1.GeneratedColumn<int>;
}

final class _S7 extends i0.VersionedSchema {
  _S7({required super.database}) : super(version: 7);
  @override
  late final List<i1.DatabaseSchemaEntity> entities = [
    users,
    groups,
    groupCount,
    notes,
  ];
  late final Shape5 users = Shape5(
      source: i0.VersionedTable(
        entityName: 'users',
        withoutRowId: false,
        isStrict: false,
        tableConstraints: [],
        columns: [
          _column_0,
          _column_6,
          _column_11,
          _column_7,
        ],
        attachedDatabase: database,
      ),
      alias: null);
  late final Shape2 groups = Shape2(
      source: i0.VersionedTable(
        entityName: 'groups',
        withoutRowId: false,
        isStrict: false,
        tableConstraints: [
          'PRIMARY KEY (id)',
        ],
        columns: [
          _column_2,
          _column_3,
          _column_4,
          _column_5,
        ],
        attachedDatabase: database,
      ),
      alias: null);
  late final Shape6 groupCount = Shape6(
      source: i0.VersionedView(
        entityName: 'group_count',
        createViewStmt:
            'CREATE VIEW group_count AS SELECT users.*, (SELECT COUNT(*) FROM "groups" WHERE owner = users.id) AS group_count FROM users',
        columns: [
          _column_8,
          _column_1,
          _column_11,
          _column_9,
          _column_10,
        ],
        attachedDatabase: database,
      ),
      alias: null);
  late final Shape7 notes = Shape7(
      source: i0.VersionedVirtualTable(
        entityName: 'notes',
        moduleAndArgs:
            'fts5(title, content, search_terms, tokenize = "unicode61 tokenchars \'.\'")',
        columns: [
          _column_12,
          _column_13,
          _column_14,
        ],
        attachedDatabase: database,
      ),
      alias: null);
}

class Shape7 extends i0.VersionedVirtualTable {
  Shape7({required super.source, required super.alias}) : super.aliased();
  i1.GeneratedColumn<String> get title =>
      columnsByName['title']! as i1.GeneratedColumn<String>;
  i1.GeneratedColumn<String> get content =>
      columnsByName['content']! as i1.GeneratedColumn<String>;
  i1.GeneratedColumn<String> get searchTerms =>
      columnsByName['search_terms']! as i1.GeneratedColumn<String>;
}

i1.GeneratedColumn<String> _column_12(String aliasedName) =>
    i1.GeneratedColumn<String>('title', aliasedName, false,
        type: i1.DriftSqlType.string, $customConstraints: '');
i1.GeneratedColumn<String> _column_13(String aliasedName) =>
    i1.GeneratedColumn<String>('content', aliasedName, false,
        type: i1.DriftSqlType.string, $customConstraints: '');
i1.GeneratedColumn<String> _column_14(String aliasedName) =>
    i1.GeneratedColumn<String>('search_terms', aliasedName, false,
        type: i1.DriftSqlType.string, $customConstraints: '');

final class _S8 extends i0.VersionedSchema {
  _S8({required super.database}) : super(version: 8);
  @override
  late final List<i1.DatabaseSchemaEntity> entities = [
    users,
    groups,
    groupCount,
    notes,
  ];
  late final Shape5 users = Shape5(
      source: i0.VersionedTable(
        entityName: 'users',
        withoutRowId: false,
        isStrict: false,
        tableConstraints: [
          'UNIQUE(name, birthday)',
        ],
        columns: [
          _column_0,
          _column_6,
          _column_11,
          _column_15,
        ],
        attachedDatabase: database,
      ),
      alias: null);
  late final Shape2 groups = Shape2(
      source: i0.VersionedTable(
        entityName: 'groups',
        withoutRowId: false,
        isStrict: false,
        tableConstraints: [
          'PRIMARY KEY (id)',
        ],
        columns: [
          _column_2,
          _column_3,
          _column_4,
          _column_5,
        ],
        attachedDatabase: database,
      ),
      alias: null);
  late final Shape6 groupCount = Shape6(
      source: i0.VersionedView(
        entityName: 'group_count',
        createViewStmt:
            'CREATE VIEW group_count AS SELECT users.*, (SELECT COUNT(*) FROM "groups" WHERE owner = users.id) AS group_count FROM users',
        columns: [
          _column_8,
          _column_1,
          _column_11,
          _column_9,
          _column_10,
        ],
        attachedDatabase: database,
      ),
      alias: null);
  late final Shape7 notes = Shape7(
      source: i0.VersionedVirtualTable(
        entityName: 'notes',
        moduleAndArgs:
            'fts5(title, content, search_terms, tokenize = "unicode61 tokenchars \'.\'")',
        columns: [
          _column_12,
          _column_13,
          _column_14,
        ],
        attachedDatabase: database,
      ),
      alias: null);
}

i1.GeneratedColumn<int> _column_15(String aliasedName) =>
    i1.GeneratedColumn<int>('next_user', aliasedName, true,
        type: i1.DriftSqlType.int,
        defaultConstraints:
            i1.GeneratedColumn.constraintIsAlways('REFERENCES "users" ("id")'));

final class _S9 extends i0.VersionedSchema {
  _S9({required super.database}) : super(version: 9);
  @override
  late final List<i1.DatabaseSchemaEntity> entities = [
    users,
    groups,
    notes,
    groupCount,
  ];
  late final Shape5 users = Shape5(
      source: i0.VersionedTable(
        entityName: 'users',
        withoutRowId: false,
        isStrict: false,
        tableConstraints: [
          'UNIQUE(name, birthday)',
          'CHECK (LENGTH(name) < 10)',
        ],
        columns: [
          _column_0,
          _column_6,
          _column_11,
          _column_7,
        ],
        attachedDatabase: database,
      ),
      alias: null);
  late final Shape2 groups = Shape2(
      source: i0.VersionedTable(
        entityName: 'groups',
        withoutRowId: false,
        isStrict: false,
        tableConstraints: [
          'PRIMARY KEY(id)',
        ],
        columns: [
          _column_2,
          _column_3,
          _column_16,
          _column_17,
        ],
        attachedDatabase: database,
      ),
      alias: null);
  late final Shape7 notes = Shape7(
      source: i0.VersionedVirtualTable(
        entityName: 'notes',
        moduleAndArgs:
            'fts5(title, content, search_terms, tokenize = "unicode61 tokenchars \'.\'")',
        columns: [
          _column_12,
          _column_13,
          _column_14,
        ],
        attachedDatabase: database,
      ),
      alias: null);
  late final Shape6 groupCount = Shape6(
      source: i0.VersionedView(
        entityName: 'group_count',
        createViewStmt:
            'CREATE VIEW group_count AS SELECT\n    users.*,\n    (SELECT COUNT(*) FROM "groups" WHERE owner = users.id) AS group_count\n  FROM users;',
        columns: [
          _column_8,
          _column_1,
          _column_11,
          _column_9,
          _column_10,
        ],
        attachedDatabase: database,
      ),
      alias: null);
}

i1.GeneratedColumn<bool> _column_16(String aliasedName) =>
    i1.GeneratedColumn<bool>('deleted', aliasedName, true,
        type: i1.DriftSqlType.bool,
        $customConstraints: 'DEFAULT FALSE',
        defaultValue: const CustomExpression('FALSE'));
i1.GeneratedColumn<int> _column_17(String aliasedName) =>
    i1.GeneratedColumn<int>('owner', aliasedName, false,
        type: i1.DriftSqlType.int,
        $customConstraints: 'NOT NULL REFERENCES users(id)');
i1.OnUpgrade stepByStep({
  required Future<void> Function(i1.Migrator m, _S2 schema) from1To2,
  required Future<void> Function(i1.Migrator m, _S3 schema) from2To3,
  required Future<void> Function(i1.Migrator m, _S4 schema) from3To4,
  required Future<void> Function(i1.Migrator m, _S5 schema) from4To5,
  required Future<void> Function(i1.Migrator m, _S6 schema) from5To6,
  required Future<void> Function(i1.Migrator m, _S7 schema) from6To7,
  required Future<void> Function(i1.Migrator m, _S8 schema) from7To8,
  required Future<void> Function(i1.Migrator m, _S9 schema) from8To9,
}) {
  return i1.Migrator.stepByStepHelper(step: (currentVersion, database) async {
    switch (currentVersion) {
      case 1:
        final schema = _S2(database: database);
        final migrator = i1.Migrator(database, schema);
        await from1To2(migrator, schema);
        return 2;
      case 2:
        final schema = _S3(database: database);
        final migrator = i1.Migrator(database, schema);
        await from2To3(migrator, schema);
        return 3;
      case 3:
        final schema = _S4(database: database);
        final migrator = i1.Migrator(database, schema);
        await from3To4(migrator, schema);
        return 4;
      case 4:
        final schema = _S5(database: database);
        final migrator = i1.Migrator(database, schema);
        await from4To5(migrator, schema);
        return 5;
      case 5:
        final schema = _S6(database: database);
        final migrator = i1.Migrator(database, schema);
        await from5To6(migrator, schema);
        return 6;
      case 6:
        final schema = _S7(database: database);
        final migrator = i1.Migrator(database, schema);
        await from6To7(migrator, schema);
        return 7;
      case 7:
        final schema = _S8(database: database);
        final migrator = i1.Migrator(database, schema);
        await from7To8(migrator, schema);
        return 8;
      case 8:
        final schema = _S9(database: database);
        final migrator = i1.Migrator(database, schema);
        await from8To9(migrator, schema);
        return 9;
      default:
        throw ArgumentError.value('Unknown migration from $currentVersion');
    }
  });
}
