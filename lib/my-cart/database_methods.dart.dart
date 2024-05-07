class OrderModel {
  String? userId;
  int? total;
  bool? delivery;
  String? address;
  String? phoneNumber;
  String? comments;

  OrderModel({
    this.userId,
    this.total,
    this.delivery,
    this.address,
    this.phoneNumber,
    this.comments,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'total': total,
      'delivery': delivery,
      'address': address,
      'phoneNumber': phoneNumber,
      'comments': comments,
    };
  }
}