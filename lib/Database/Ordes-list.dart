class OrderModel {
  String? userId;
  int? total;
  bool? delivery;
  String? address;
  String? phoneNumber;
  String? comments;
  List<OrderItem>? items;

  OrderModel({
    this.userId,
    this.total,
    this.delivery,
    this.address,
    this.phoneNumber,
    this.comments,
    this.items,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'total': total,
      'delivery': delivery,
      'address': address,
      'phoneNumber': phoneNumber,
      'comments': comments,
      'items': items != null ? items!.map((item) => item.toMap()).toList() : null,
    };
  }
}
class OrderItem {
  String? name;
  int? quantity;
  int? total;

  OrderItem({
    this.name,
    this.quantity,
    this.total,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'quantity': quantity,
      'total': total,
    };
  }
}

