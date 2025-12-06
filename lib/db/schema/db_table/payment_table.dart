import 'package:hms/db/schema/base_schema/type.dart';

const paymentsTable = TableDef(
  name: 'payments',
  columns: [
    ColumnDef(
      name: 'id',
      type: ColumnType.integer,
      primaryKey: true,
      autoIncrement: true,
    ),
    ColumnDef(name: 'payment_date', type: ColumnType.text, notNull: true),
    ColumnDef(name: 'payment_id', type: ColumnType.integer, notNull: true),
    ColumnDef(name: 'order_id', type: ColumnType.integer, notNull: true),
    ColumnDef(name: 'amount_due', type: ColumnType.real, notNull: true),
    ColumnDef(name: 'tips', type: ColumnType.real, notNull: true),
    ColumnDef(name: 'discount', type: ColumnType.real, notNull: true),
    ColumnDef(name: 'total_paid', type: ColumnType.real, notNull: true),
    ColumnDef(name: 'payment_type', type: ColumnType.text, notNull: true),
    ColumnDef(name: 'payment_status', type: ColumnType.text, notNull: true),
  ],
  indexes: [
    IndexDef(
      name: 'idx_payments_order_id',
      table: 'payments',
      columns: ['order_id'],
    ),
  ],
);
