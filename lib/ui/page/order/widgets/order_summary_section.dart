import 'package:flutter/material.dart';
import 'package:hms/model/entity/order_details_entity.dart';

class OrderSummarySection extends StatelessWidget {
  final OrderWithDetails order;

  const OrderSummarySection({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final total = order.orderTotal;
    final paid = order.totalPaid;
    final balance = order.balance;

    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text('Order Total: ${total.toStringAsFixed(2)}'),
          Text('Total Paid: ${paid.toStringAsFixed(2)}'),
          Text(
            'Balance: ${balance.toStringAsFixed(2)}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: balance.abs() > 0.01 ? Colors.red : Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
