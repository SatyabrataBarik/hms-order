import 'package:flutter/material.dart';
import 'package:hms/model/entity/order_details_entity.dart';

class OrderItemsSection extends StatelessWidget {
  final OrderWithDetails order;

  const OrderItemsSection({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    if (order.items.isEmpty) {
      return const Text('No items');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Items', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Row(
          children: const [
            Expanded(child: Text('Item')),
            SizedBox(width: 60, child: Text('Unit')),
            SizedBox(width: 40, child: Text('Qty')),
            SizedBox(width: 70, child: Text('Total')),
          ],
        ),
        const SizedBox(height: 4),
        ...order.items.map((line) {
          final name = line.itemName ?? 'Item ${line.itemId}';
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    line.size != null && line.size!.isNotEmpty
                        ? '$name (${line.size})'
                        : name,
                  ),
                ),
                SizedBox(
                  width: 60,
                  child: Text(line.unitPrice.toStringAsFixed(2)),
                ),
                SizedBox(width: 40, child: Text(line.qty.toString())),
                SizedBox(
                  width: 70,
                  child: Text(line.lineTotal.toStringAsFixed(2)),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}