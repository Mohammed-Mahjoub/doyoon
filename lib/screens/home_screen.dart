import 'package:doyoon/models/process_response.dart';
import 'package:doyoon/models/user.dart';
import 'package:doyoon/provider/orders_provider.dart';
import 'package:doyoon/provider/products_provider.dart';
import 'package:doyoon/provider/users_provider.dart';
import 'package:doyoon/screens/new_order_screen.dart';
import 'package:doyoon/screens/orders_screen.dart';
import 'package:doyoon/widget/custom_list_tile.dart';
import 'package:doyoon/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController nameController;
  String? name;

  @override
  void initState() {
    super.initState();
    Provider.of<UsersProvider>(context, listen: false).read();
    Provider.of<ProductsProvider>(context, listen: false).read();
    nameController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الزبائن'),
        actions: [
          IconButton(
              onPressed: () {
                nameController.clear();
                _showDialog(context);
              },
              icon: const Icon(Icons.person_add_alt_1_outlined))
        ],
      ),
      body: Consumer<UsersProvider>(
        builder: (context, UsersProvider value, child) {
          if (value.users.isNotEmpty) {
            return ListView.builder(
              itemCount: value.users.length,
              itemBuilder: (context, index) {
                return CustomListTile(
                  title: value.users[index].name,
                  supTitle: '---تفاصيل---',
                  onTap: () async {
                    await Provider.of<OrdersProvider>(context, listen: false)
                        .read(value.users[index].id);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrdersScreen(
                          userId: value.users[index].id,
                          name: value.users[index].name,
                        ),
                      ),
                    );
                  },
                  trailingOnPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewOrderScreen(
                              name: value.users[index].name,
                              userId: value.users[index].id),
                        ));
                  },
                );
              },
            );
          } else {
            return const Center(
              child: Text('لا يوجد بيانات'),
            );
          }
        },
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('images/logo.png'),
              ),
              accountName: Text(
                'العقيد',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              accountEmail: Text(
                'العقيد أبو رمضان',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/add_product_screen');
              },
              title: const Text(
                'إضافة منتج جديد',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showDialog(BuildContext context) async {
    showDialog(
        context: context,
        builder: (_) {
          return Consumer<ProductsProvider>(
              builder: (context, ProductsProvider value, child) {
            return ChangeNotifierProvider<UsersProvider>(
              create: (context) => UsersProvider(),
              child: StatefulBuilder(
                builder: (context, setState) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    content: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'إضافة زبون',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          CustomTextField(
                            labelText: 'الاسم',
                            textEditingController: nameController,
                            textInputType: TextInputType.text,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                nameController.text.isNotEmpty
                                    ? name = nameController.text
                                    : name = 'تجربة';
                                save();
                                Navigator.of(context).pop();
                              });
                            },
                            child: const Text('حفظ'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          });
        });
  }

  Future<void> save() async {
    ProcessResponse pr =
        await Provider.of<UsersProvider>(context, listen: false).create(user);
  }

  User get user {
    User u = User();
    u.name = nameController.text;
    u.total = 0;
    return u;
  }
}
