import 'package:hms/db/schema/base_schema/type.dart';

const ordersTable = TableDef(
  name: 'orders',
  columns: [
    ColumnDef(
      name: 'id',
      type: ColumnType.integer,
      primaryKey: true,
      autoIncrement: true,
    ),
    ColumnDef(name: 'order_date', type: ColumnType.text, notNull: true),
    ColumnDef(name: 'order_id', type: ColumnType.integer, notNull: true),
    ColumnDef(name: 'item_id', type: ColumnType.integer, notNull: true),
    ColumnDef(name: 'size', type: ColumnType.text),
    ColumnDef(name: 'price', type: ColumnType.real, notNull: true),
    ColumnDef(name: 'qty', type: ColumnType.integer, notNull: true),
    ColumnDef(name: 'order_status', type: ColumnType.text, notNull: true),
    ColumnDef(name: 'line_total', type: ColumnType.real, notNull: true),
  ],
  indexes: [
    IndexDef(
      name: 'idx_orders_order_id',
      table: 'orders',
      columns: ['order_id'],
    ),
    IndexDef(name: 'idx_orders_item_id', table: 'orders', columns: ['item_id']),
  ],
);
