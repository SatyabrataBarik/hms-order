import 'package:flutter/foundation.dart';
import 'package:hms/data/order_repository/order_details_view.dart';
import 'package:hms/model/entity/order_details_entity.dart';

class OrderDetailsViewModel extends ChangeNotifier {
  final OrderDetailsViewRepository _repository;

  OrderDetailsViewModel(this._repository);

  bool _isLoading = false;
  String? _error;
  List<OrderWithDetails> _orders = [];

  bool get isLoading => _isLoading;
  String? get error => _error;
  List<OrderWithDetails> get orders => _orders;

  Future<void> loadOrders() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final data = await _repository.fetchAllOrders();
      _orders = data;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refresh() async {
    await loadOrders();
  }
}
