import 'package:flutter/material.dart';
import 'package:hms/model/entity/order_details_entity.dart';
import 'package:hms/ui/page/cart/cart_page.dart';
import 'package:hms/ui/page/order/widgets/order_item_section.dart';
import 'package:hms/ui/page/order/widgets/order_payment_section.dart';
import 'package:hms/ui/page/order/widgets/order_summary_section.dart';
import 'package:hms/view_model/order_details_view_model.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<OrderDetailsViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => provider.refresh(),
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Navigator.pushNamed(context,'/cart' ),
          ),
        ],
      ),
      body: _buildBody(provider),
    );
  }

  Widget _buildBody(OrderDetailsViewModel provider) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.error != null) {
      return Center(child: Text('Error: ${provider.error}'));
    }

    final orders = provider.orders;
    if (orders.isEmpty) {
      return const Center(child: Text('No orders found'));
    }

    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return Card(
          margin: const EdgeInsets.all(8),
          child: ExpansionTile(
            title: Text('Order #${order.orderId}'),
            subtitle: Text('${order.orderDate} • Status: ${order.status}'),
            childrenPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            children: [
              OrderItemsSection(order: order),
              const SizedBox(height: 8),
              OrderPaymentsSection(order: order),
              const Divider(),
              OrderSummarySection(order: order),
            ],
          ),
        );
      },
    );
  }
}





