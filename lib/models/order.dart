class Order {

  late int id;
  late int productId;
  late int userId;
  late int quantity;
  late String productName;
  late double price;
  late String orderTime;

  static const String tableName = 'orders';

  Order();

  /// Read Data From Database
  Order.fromMap(Map<String, dynamic> rowMap) {
    id = rowMap['id'];
    productId = rowMap['product_id'];
    userId = rowMap['user_id'];
    quantity = rowMap['quantity'];
    productName = rowMap['product_name'];
    price = rowMap['product_price'];
    orderTime = rowMap['order_time'];
  }

  /// Save Data on Database
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['product_id'] = productId;
    map['user_id'] = userId;
    map['quantity'] = quantity;
    map['order_time'] = orderTime;
    return map;
  }
}
