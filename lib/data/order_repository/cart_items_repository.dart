import 'package:hms/data/base_repository.dart';
import 'package:hms/model/entity/cart_item_entity.dart';

class CartItemRepository extends BaseRepository<CartItemEntity> {
  @override
  String get tableName => 'cart_items';

  @override
  CartItemEntity fromMap(Map<String, dynamic> map) {
    return CartItemEntity.fromMap(map);
  }

  @override
  Map<String, dynamic> toMap(model) {
    return model.toMap();
  }

}
