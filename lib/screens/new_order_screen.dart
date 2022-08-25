import 'package:doyoon/models/order.dart';
import 'package:doyoon/models/process_response.dart';
import 'package:doyoon/provider/orders_provider.dart';
import 'package:doyoon/provider/products_provider.dart';
import 'package:doyoon/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewOrderScreen extends StatefulWidget {
  final String name;
  final int userId;

  const NewOrderScreen({Key? key, required this.name, required this.userId})
      : super(key: key);

  @override
  State<NewOrderScreen> createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {
  late TextEditingController quantityController;
  int? selectedItem;
  late DateTime dateTime;
  @override
  void initState() {
    super.initState();
    // Provider.of<OrdersProvider>(context, listen: false).read();
    quantityController = TextEditingController();
  }

  @override
  void dispose() {
    quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('طلب جديد'),
      ),
      body: Consumer<OrdersProvider>(
        builder: (context, OrdersProvider value, child) {
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text(
                widget.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              DropdownButton<int>(
                isExpanded: true,
                hint: const Text('إختر طلب'),
                style: const TextStyle(color: Colors.black),
                items: Provider.of<ProductsProvider>(context)
                    .products
                    .map((product) {
                  return DropdownMenuItem<int>(
                    value: product.id,
                    child: Text(product.name),
                  );
                }).toList(),
                onChanged: (int? value) {
                  setState(() {
                    selectedItem = value;
                  });
                },
                icon: const Icon(Icons.keyboard_arrow_down_sharp),
                value: selectedItem,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                labelText: 'الكمية',
                textEditingController: quantityController,
                textInputType: TextInputType.number,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  await save();
                },
                child: const Text('حفظ'),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> save() async {
    dateTime = DateTime.now();
    ProcessResponse or =
        await Provider.of<OrdersProvider>(context, listen: false).create(order);
    if (or.success) {
      selectedItem = null;
      quantityController.clear();
    }
  }

  Order get order {
    Order o = Order();
    o.userId = widget.userId;
    o.productId = selectedItem!;
    o.quantity = int.parse(quantityController.text);
    o.orderTime = '${dateTime.hour}:${dateTime.minute} - ${dateTime.year}/${dateTime.month}/${dateTime.day}';
    return o;
  }
}
