// db/schema.dart

class ColumnType {
  static const text = 'TEXT';
  static const integer = 'INTEGER';
  static const real = 'REAL';
}

class ColumnDef {
  final String name;
  final String type;
  final bool primaryKey;
  final bool notNull;
  final bool autoIncrement;
  final bool unique;
  final String? defaultValue;

  const ColumnDef({
    required this.name,
    required this.type,
    this.primaryKey = false,
    this.notNull = false,
    this.autoIncrement = false,
    this.unique = false,
    this.defaultValue,
  });

  String toSql() {
    final buffer = StringBuffer();
    buffer.write(name);
    buffer.write(' ');
    buffer.write(type);

    if (primaryKey) buffer.write(' PRIMARY KEY');
    if (autoIncrement) buffer.write(' AUTOINCREMENT');
    if (notNull) buffer.write(' NOT NULL');
    if (unique) buffer.write(' UNIQUE');
    if (defaultValue != null) buffer.write(' DEFAULT $defaultValue');

    return buffer.toString();
  }
}

class IndexDef {
  final String name;
  final String table;
  final List<String> columns;
  final bool unique;

  const IndexDef({
    required this.name,
    required this.table,
    required this.columns,
    this.unique = false,
  });

  String toSql() {
    final cols = columns.join(', ');
    final uniqueStr = unique ? 'UNIQUE ' : '';
    return 'CREATE ${uniqueStr}INDEX IF NOT EXISTS $name ON $table($cols);';
  }
}

class TableDef {
  final String name;
  final List<ColumnDef> columns;
  final List<String> extraConstraints; // e.g. foreign keys, CHECK, etc.
  final List<IndexDef> indexes;

  const TableDef({
    required this.name,
    required this.columns,
    this.extraConstraints = const [],
    this.indexes = const [],
  });

  String createTableSql() {
    final buffer = StringBuffer();
    buffer.write('CREATE TABLE $name (\n  ');

    final columnSql = columns.map((c) => c.toSql()).join(',\n  ');
    final constraintSql = extraConstraints.isEmpty
        ? ''
        : ',\n  ${extraConstraints.join(',\n  ')}';

    buffer.write(columnSql);
    buffer.write(constraintSql);
    buffer.write('\n);');

    return buffer.toString();
  }
}
