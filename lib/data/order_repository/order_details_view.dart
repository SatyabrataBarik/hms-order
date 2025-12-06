import 'package:hms/data/base_repository.dart';
import 'package:hms/model/entity/order_details_entity.dart';

class OrderDetailsViewRepository extends BaseRepository<Map<String, dynamic>> {
  @override
  String get tableName => 'order_details_view';

  @override
  Map<String, dynamic> fromMap(Map<String, dynamic> map) => map;

  @override
  Map<String, dynamic> toMap(Map<String, dynamic> model) => model;

  Future<List<OrderWithDetails>> fetchAllOrders() async {
    final rows = await getAll();

    final Map<int, List<Map<String, dynamic>>> grouped = {};

    for (final row in rows) {
      final orderId = row['order_id'] as int;
      grouped.putIfAbsent(orderId, () => []);
      grouped[orderId]!.add(row);
    }

    final List<OrderWithDetails> finalList = [];

    grouped.forEach((orderId, dataRows) {
      final first = dataRows.first;

      final String orderDate = first['order_date'] as String;
      final String status = first['order_status'] as String;

      final items = dataRows.map((row) {
        return OrderItemDetail(
          itemId: row['item_id'] as int,
          itemName: row['item_name'] as String?,
          size: row['size'] as String?,
          unitPrice: (row['price'] as num).toDouble(),
          qty: row['qty'] as int,
          lineTotal: (row['line_total'] as num).toDouble(),
        );
      }).toList();

      final double paymentTotal =
          (first['payment_total'] as num?)?.toDouble() ?? 0;

      final orderTotal =
      items.fold(0.0, (sum, i) => sum + i.lineTotal);

      final payments = [
        OrderPaymentDetail(
          paymentType: 'Mixed',
          paymentStatus: 'Completed',
          amountDue: orderTotal,
          totalPaid: paymentTotal,
          tips: 0,
          discount: 0,
        )
      ];

      finalList.add(
        OrderWithDetails(
          orderId: orderId,
          orderDate: orderDate,
          status: status,
          items: items,
          payments: payments,
        ),
      );
    });

    return finalList;
  }
}
