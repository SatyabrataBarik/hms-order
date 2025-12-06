class DbViewDef {
  final String name;
  final String createSql;

  const DbViewDef({
    required this.name,
    required this.createSql,
  });

  String createViewSql() => createSql;
}
