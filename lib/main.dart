import 'package:flutter/material.dart';
import 'package:hms/core/locator.dart';
import 'package:hms/db/app_db.dart';
import 'package:hms/ui/page/cart/cart_page.dart';
import 'package:hms/ui/page/order/order_page.dart';
import 'package:hms/view_model/cart_view_model.dart';
import 'package:hms/view_model/order_details_view_model.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppDatabase.instance.database;
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => locator<OrderDetailsViewModel>()..loadOrders(),
        ),
        ChangeNotifierProvider(create: (_) => locator<CartViewModel>()),
      ],
      child: MaterialApp(
        title: 'HMS',
        theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
        home: OrdersPage(),
        routes: {"/cart": (context) => CartPage()},
      ),
    );
  }
}
