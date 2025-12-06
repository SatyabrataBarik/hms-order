import 'package:hms/db/schema/base_schema/type.dart';

const menuItemsTable = TableDef(
  name: 'menu_items',
  columns: [
    ColumnDef(name: 'item_id', type: ColumnType.integer, primaryKey: true),
    ColumnDef(name: 'item_name', type: ColumnType.text, notNull: true),
    ColumnDef(name: 'cat_id', type: ColumnType.integer, notNull: true),
    ColumnDef(name: 'menu_id', type: ColumnType.integer, notNull: true),
    ColumnDef(
      name: 'size',
      type: ColumnType.text,
    ),
    ColumnDef(
      name: 'price',
      type: ColumnType.text,
    ),
  ],
);
