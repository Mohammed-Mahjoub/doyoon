import 'package:doyoon/models/order.dart';
import 'package:doyoon/provider/orders_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  final int userId;
  final String name;

  const OrdersScreen({Key? key, required this.userId, required this.name})
      : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    Provider.of<OrdersProvider>(context, listen: false).read(widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('طلبات: ${widget.name}'),
      ),
      body: Consumer<OrdersProvider>(
        builder: (context, OrdersProvider value, child) {
          if (value.orders.isNotEmpty) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: value.orders.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 6,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              children: [
                                const Icon(Icons.coffee),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        value.orders[index].productName,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                          'العدد: ${value.orders[index].quantity.toString()}',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300)),
                                      const SizedBox(width: 5),
                                      Text(
                                          value.orders[index].orderTime,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300)),
                                    ],
                                  ),
                                ),
                                Text(
                                    'المجموع : ${(value.orders[index].quantity * value.orders[index].price).toString()}'),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      value.delete(index);
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade500,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    ),
                  ),
                  height: 100,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        'المجموع الكلي: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(sum(value.orders).toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text('No Data'),
            );
          }
        },
      ),
    );
  }

  double sum(List<Order> o) {
    double sum = 0;
    for (int i = 0; i < o.length; i++) {
      sum += (o[i].price * o[i].quantity);
    }
    return sum;
  }
}
