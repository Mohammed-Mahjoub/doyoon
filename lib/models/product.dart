class Product{
  late int id;
  late String name;
  late double price;

  static const String tableName = 'products';

  Product();


  /// Read Data From Database
  Product.fromMap(Map<String,dynamic> rowMap){
    id = rowMap['id'];
    name = rowMap['name'];
    price = rowMap['price'];
  }
  /// Save Data on Database
  Map<String,dynamic> toMap(){
    Map<String,dynamic> map = <String,dynamic>{};
    map['name'] = name;
    map['price'] = price;
    return map;
  }

}