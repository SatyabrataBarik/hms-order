import 'package:hms/db/schema/base_schema/db_view.dart';

const orderDetailsView = DbViewDef(
  name: 'order_details_view',
  createSql: '''
    CREATE VIEW order_details_view AS
    SELECT
        o.order_id,
        o.order_date,
        o.order_status,
        o.item_id,
        mi.item_name,
        o.size,
        o.price,
        o.qty,
        o.line_total,
        (
            SELECT SUM(p.total_paid)
            FROM payments p
            WHERE p.order_id = o.order_id
        ) AS payment_total
    FROM orders o
    LEFT JOIN menu_items mi ON o.item_id = mi.item_id;
  ''',
);
