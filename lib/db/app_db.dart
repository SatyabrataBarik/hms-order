import 'package:hms/db/schema/app_schema.dart';
import 'package:hms/db/schema/app_view.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  AppDatabase._internal();
  static final AppDatabase instance = AppDatabase._internal();

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'restaurant.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {

    for (final table in appSchema) {
      await db.execute(table.createTableSql());
    }

    for (final table in appSchema) {
      for (final index in table.indexes) {
        await db.execute(index.toSql());
      }
    }

    for (final view in appViews) {
      await db.execute(view.createSql);
    }

    await _seedData(db);
  }

  Future<void> _seedData(Database db) async {
    await _seedDbData(db);
  }
}

Future<void> _seedDbData(Database db) async {
  await db.insert('menus', {'menu_id': 1, 'menu_name': 'Food'});
  await db.insert('menus', {'menu_id': 2, 'menu_name': 'Drinks'});

  await db.insert('categories', {
    'cat_id': 1,
    'category_name': 'Starters',
    'menu_id': 1,
  });

  await db.insert('menu_items', {
    'item_id': 1,
    'item_name': 'Item1',
    'cat_id': 1,
    'menu_id': 1,
    'size': 'Small, Large',
    'price': '1.50, 2.50',
  });
  await db.insert('menu_items', {
    'item_id': 2,
    'item_name': 'Item2',
    'cat_id': 1,
    'menu_id': 1,
    'size': '',
    'price': '2.50',
  });

  await db.insert('orders', {
    'order_date': '2025-10-01',
    'order_id': 10,
    'item_id': 2,
    'size': '',
    'price': 2.5,
    'qty': 1,
    'order_status': 'Completed',
    'line_total': 2.5,
  });
  await db.insert('orders', {
    'order_date': '2025-10-01',
    'order_id': 10,
    'item_id': 3,
    'size': '',
    'price': 1.5,
    'qty': 2,
    'order_status': 'Completed',
    'line_total': 3,
  });

  await db.insert('payments', {
    'payment_date': '2025-10-01',
    'payment_id': 123422,
    'order_id': 10,
    'amount_due': 9.25,
    'tips': 0.0,
    'discount': 0.0,
    'total_paid': 9.25,
    'payment_type': 'Card',
    'payment_status': 'Completed',
  });
}
