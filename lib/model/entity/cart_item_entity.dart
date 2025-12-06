class CartItemEntity {
  final int id;
  final String name;
  final double unitPriceInclTax;
  int qty;

  CartItemEntity({
    required this.id,
    required this.name,
    required this.unitPriceInclTax,
    this.qty = 1,
  });

  double get totalInclTax => unitPriceInclTax * qty;
  double get totalExclTax => (unitPriceInclTax / 1.125) * qty;
  double get taxAmount => totalInclTax - totalExclTax;
  factory CartItemEntity.fromMap(Map<String, dynamic> map) {
    return CartItemEntity(
      id: map['id'] as int,
      name: map['name'] as String,
      unitPriceInclTax: (map['unit_price_incl_tax'] as num).toDouble(),
      qty: map['qty'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'unit_price_incl_tax': unitPriceInclTax,
      'qty': qty,
    };
  }
}
