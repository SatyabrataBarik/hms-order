import 'package:hms/db/schema/base_schema/type.dart';

const menusTable = TableDef(
  name: 'menus',
  columns: [
    ColumnDef(name: 'menu_id', type: ColumnType.integer, primaryKey: true),
    ColumnDef(name: 'menu_name', type: ColumnType.text, notNull: true),
  ],
);
