import 'package:hms/db/schema/base_schema/type.dart';

const cartItemsTable = TableDef(
  name: 'cart_items',
  columns: [
    ColumnDef(
      name: 'id',
      type: ColumnType.integer,
      primaryKey: true,
      notNull: true,
    ),
    ColumnDef(
      name: 'name',
      type: ColumnType.text,
      notNull: true,
    ),
    ColumnDef(
      name: 'unit_price_incl_tax',
      type: ColumnType.real,
      notNull: true,
    ),
    ColumnDef(
      name: 'qty',
      type: ColumnType.integer,
      notNull: true,
    ),
  ],
  indexes: [
    IndexDef(
      name: 'idx_cart_items_id',
      table: 'cart_items',
      columns: ['id'],
    ),
  ],
);
