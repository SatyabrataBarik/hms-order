import 'package:flutter/material.dart';
import 'package:hms/model/entity/cart_item_entity.dart';
import 'package:hms/view_model/cart_view_model.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final catalog = [
    CartItemEntity(id: 1, name: 'Item 1', unitPriceInclTax: 10),
    CartItemEntity(id: 2, name: 'Item 2', unitPriceInclTax: 7.5),
    CartItemEntity(id: 3, name: 'Item 3', unitPriceInclTax: 5),
    CartItemEntity(id: 4, name: 'Item 4', unitPriceInclTax: 2.5),
    CartItemEntity(id: 5, name: 'Item 5', unitPriceInclTax: 3),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: catalog.length, vsync: this);
    Future.microtask(() {
     if(mounted){
       context.read<CartViewModel>().loadCart();
     }
    },);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CartViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart (12.5% Tax)'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: catalog.map((e) => Tab(text: e.name)).toList(),
        ),
      ),
      body: Column(
        children: [
          // tabs area
          Expanded(
            flex: 1,
            child: TabBarView(
              controller: _tabController,
              children: catalog.map((item) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(item.name,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text(
                        '£${item.unitPriceInclTax.toStringAsFixed(2)} (Incl 12.5% Tax)',
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () =>
                            context.read<CartViewModel>().add(item),
                        child: const Text('Add to Cart'),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          const Divider(),
          // cart section
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Items',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 4),
                  if (vm.items.isEmpty)
                    const Text('No items in cart')
                  else
                    Expanded(
                      child: ListView(
                        children: [
                          Table(
                            columnWidths: const {
                              0: FlexColumnWidth(1),
                              1: FlexColumnWidth(1),
                              2: FlexColumnWidth(2),
                              3: FlexColumnWidth(1),
                            },
                            children: [
                              const TableRow(
                                children: [
                                  Center(
                                    child: Text('Item',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(4),
                                    child: Center(
                                      child: Text('Unit Price',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(4),
                                    child: Center(
                                      child: Text('Qty',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(4),
                                    child: Center(
                                      child: Text('Price',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ],
                              ),
                              ...vm.items.map((i) {
                                return TableRow(
                                  children: [
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(4),
                                        child: Text(i.name),
                                      ),
                                    ),
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(4),
                                        child: Text(
                                            '£${i.unitPriceInclTax.toStringAsFixed(2)}'),
                                      ),
                                    ),
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(4),
                                        child: Row(
                                          spacing: 5,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              child: const Icon(Icons.remove,
                                                  size: 16),
                                              onTap: () => context
                                                  .read<CartViewModel>()
                                                  .decrease(i.id),
                                            ),
                                            Text('${i.qty}'),
                                            InkWell(
                                              child: const Icon(Icons.add,
                                                  size: 16),
                                              onTap: () => context
                                                  .read<CartViewModel>()
                                                  .increase(i.id),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(4),
                                        child: Text(
                                            '£${i.totalInclTax.toStringAsFixed(2)}'),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total (Incl Tax):',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('£${vm.totalInclTax.toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Tax (12.5%):'),
                      Text('£${vm.totalTax.toStringAsFixed(2)}'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
