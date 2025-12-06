class OrderEntity {
  final int? id;
  final String orderDate;
  final int orderId;    
  final int itemId;
  final String? size;
  final double price;
  final int qty;
  final String orderStatus;
  final double lineTotal;

  OrderEntity({
    this.id,
    required this.orderDate,
    required this.orderId,
    required this.itemId,
    this.size,
    required this.price,
    required this.qty,
    required this.orderStatus,
    required this.lineTotal,
  });

  factory OrderEntity.fromMap(Map<String, dynamic> map) {
    return OrderEntity(
      id: map['id'] as int?,
      orderDate: map['order_date'] as String,
      orderId: map['order_id'] as int,
      itemId: map['item_id'] as int,
      size: map['size'] as String?,
      price: (map['price'] as num).toDouble(),
      qty: map['qty'] as int,
      orderStatus: map['order_status'] as String,
      lineTotal: (map['line_total'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'order_date': orderDate,
      'order_id': orderId,
      'item_id': itemId,
      'size': size,
      'price': price,
      'qty': qty,
      'order_status': orderStatus,
      'line_total': lineTotal,
    };
  }
}
