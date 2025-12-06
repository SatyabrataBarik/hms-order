class OrderLine {
  final int itemId;
  final String? size;
  final double price;
  final int qty;
  final double lineTotal;
  final String? itemName;

  OrderLine({
    required this.itemId,
    this.size,
    required this.price,
    required this.qty,
    required this.lineTotal,
    this.itemName,
  });
}

class PaymentDetail {
  final String paymentType;
  final String paymentStatus;
  final double amountDue;
  final double totalPaid;
  final double tips;
  final double discount;

  PaymentDetail({
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
  final List<OrderLine> lines;
  final List<PaymentDetail> payments;

  double get orderTotal =>
      lines.fold(0.0, (sum, l) => sum + l.lineTotal);

  double get totalPaid =>
      payments.fold(0.0, (sum, p) => sum + p.totalPaid);

  double get balance => orderTotal - totalPaid;

  OrderWithDetails({
    required this.orderId,
    required this.orderDate,
    required this.status,
    required this.lines,
    required this.payments,
  });
}
