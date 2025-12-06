import 'package:flutter/material.dart';
import 'package:hms/model/entity/order_details_entity.dart';

class OrderPaymentsSection extends StatelessWidget {
  final OrderWithDetails order;

  const OrderPaymentsSection({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    if (order.payments.isEmpty) {
      return const Text('No payments');
    }

    final p = order.payments.first; // aggregated from view

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Payments', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        ListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          title: Text('${p.paymentType} (${p.paymentStatus})'),
          subtitle: Text('Amount Due: ${p.amountDue.toStringAsFixed(2)}'),
          trailing: Text(
            p.totalPaid.toStringAsFixed(2),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}