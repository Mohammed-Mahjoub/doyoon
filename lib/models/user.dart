class User{
  late int id;
  late String name;
  late double total;

  static const String tableName = 'users';

  User();

  /// Read Data From Database
  User.fromMap(Map<String,dynamic> rowMap){
    id = rowMap['id'];
    name = rowMap['name'];
    total = rowMap['total'];
  }
 /// Save Data on Database
  Map<String,dynamic> toMap(){
    Map<String,dynamic> map = <String,dynamic>{};
        map['name'] = name;
        map['total'] = total;
    return map;
  }

}