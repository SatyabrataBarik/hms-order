 import 'package:hms/db/schema/base_schema/type.dart';

const categoriesTable = TableDef(
  name: 'categories',
  columns: [
    ColumnDef(
      name: 'cat_id',
      type: ColumnType.integer,
      primaryKey: true,
    ),
    ColumnDef(
      name: 'category_name',
      type: ColumnType.text,
      notNull: true,
    ),
    ColumnDef(
      name: 'menu_id',
      type: ColumnType.integer,
      notNull: true,
    ),
  ],
);