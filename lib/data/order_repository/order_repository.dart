import 'package:hms/data/base_repository.dart';
import 'package:hms/model/entity/order_entity.dart';

class OrderRepository extends BaseRepository {
  @override
  String get tableName => 'orders';

  @override
  OrderEntity fromMap(Map<String, dynamic> map) {
    return OrderEntity.fromMap(map);
  }

  @override
  Map<String, dynamic> toMap(model) {
    if (model is! OrderEntity) {
      throw ArgumentError('OrderRepository.toMap: model must be OrderEntity');
    }
    return model.toMap();
  }

  Future<int> insertOrder(OrderEntity order) async {
    return insert(order);
  }

}
