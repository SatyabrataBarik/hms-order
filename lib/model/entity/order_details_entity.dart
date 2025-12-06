class OrderItemDetail {
  final int itemId;
  final String? itemName;
  final String? size;
  final double unitPrice;
  final int qty;
  final double lineTotal;

  OrderItemDetail({
    required this.itemId,
    this.itemName,
    this.size,
    required this.unitPrice,
    required this.qty,
    required this.lineTotal,
  });
}

class OrderPaymentDetail {
  final String paymentType;
  final String paymentStatus;
  final double amountDue;
  final double totalPaid;
  final double tips;
  final double discount;

  OrderPaymentDetail({
    required this.paymentType,
    required this.paymentStatus,
    required this.amountDue,
    required this.totalPaid,
    required this.tips,
    required this.discount,
  });
}

class OrderWithDetails {
  final int orderId;
  final String orderDate;
  final String status;
  final List<OrderItemDetail> items;
  final List<OrderPaymentDetail> payments;

  OrderWithDetails({
    required this.orderId,
    required this.orderDate,
    required this.status,
    required this.items,
    required this.payments,
  });

  double get orderTotal =>
      items.fold(0.0, (sum, i) => sum + i.lineTotal);

  double get totalPaid =>
      payments.fold(0.0, (sum, p) => sum + p.totalPaid);

  double get balance => orderTotal - totalPaid;
}
