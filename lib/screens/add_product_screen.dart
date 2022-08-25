import 'package:doyoon/models/process_response.dart';
import 'package:doyoon/models/product.dart';
import 'package:doyoon/provider/products_provider.dart';
import 'package:doyoon/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddProductsScreen extends StatefulWidget {
  const AddProductsScreen({Key? key}) : super(key: key);

  @override
  State<AddProductsScreen> createState() => _AddProductsScreenState();
}

class _AddProductsScreenState extends State<AddProductsScreen> {
  late TextEditingController nameController;
  late TextEditingController priceController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    priceController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إضافة منتج جديد'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/products_screen');
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          CustomTextField(
            labelText: 'الاسم',
            textEditingController: nameController,
            textInputType: TextInputType.text,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
            labelText: 'السعر',
            textEditingController: priceController,
            textInputType: TextInputType.number,
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                save();
              });
            },
            child: const Text('حفظ'),
          ),
        ],
      ),
    );
  }

  Future<void> save() async {
    ProcessResponse pr =
        await Provider.of<ProductsProvider>(context, listen: false)
            .create(product);
    if (pr.success) {
      nameController.clear();
      priceController.clear();
    }
  }

  Product get product {
    Product p = Product();
    p.name = nameController.text;
    p.price = double.parse(priceController.text);
    return p;
  }
}
