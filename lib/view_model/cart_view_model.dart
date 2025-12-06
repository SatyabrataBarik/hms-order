import 'package:flutter/foundation.dart';
import 'package:hms/data/order_repository/cart_items_repository.dart';
import 'package:hms/model/entity/cart_item_entity.dart';

class CartViewModel extends ChangeNotifier {
  final CartItemRepository _repo;

  CartViewModel({CartItemRepository? repo})
    : _repo = repo ?? CartItemRepository();

  final Map<int, CartItemEntity> _items = {};

  List<CartItemEntity> get items => _items.values.toList();
  double get totalInclTax =>
      _items.values.fold(0.0, (sum, i) => sum + i.totalInclTax);

  double get totalExclTax =>
      _items.values.fold(0.0, (sum, i) => sum + i.totalExclTax);

  double get totalTax => totalInclTax - totalExclTax;

  bool isLoading = false;

  Future<void> loadCart() async {
    isLoading = true;
    notifyListeners();

    final list = await _repo.getAll();
    _items
      ..clear()
      ..addEntries(list.map((e) => MapEntry(e.id, e)));

    isLoading = false;
    notifyListeners();
  }

  Future<void> add(CartItemEntity item) async {
    final existing = _items[item.id];

    if (existing != null) {
      item.qty += 1;
      _items[item.id] = existing;
      await _repo.update(item, item.id);
    } else {
      item.qty = 1;
      _items[item.id] = item;
      await _repo.insert(item);
    }

    notifyListeners();
  }

  Future<void> increase(int id) async {
    final item = _items[id];
    if (item == null) return;

    item.qty += 1;
    _items[id] = item;

    await _repo.update(item, id);
    notifyListeners();
  }

  Future<void> decrease(int id) async {
    final item = _items[id];
    if (item == null) return;

    if (item.qty > 1) {
      item.qty -= 1;
      _items[id] = item;
      await _repo.update(item, id);
    } else {
      _items.remove(id);
      await _repo.delete(id);
    }

    notifyListeners();
  }

  Future<void> clearCart() async {
    _items.clear();
    await _repo.deleteAll();
    notifyListeners();
  }
}
