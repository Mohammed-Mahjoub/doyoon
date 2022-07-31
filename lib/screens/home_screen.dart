import 'package:doyoon/data/person.dart';
import 'package:doyoon/screens/user_screen.dart';
import 'package:doyoon/widget/custom_list_tile.dart';
import 'package:doyoon/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController nameController;
  late TextEditingController quantityController;
  String? order;
  String? name;
  int? quantity;
  List<Person> toDayList = <Person>[
    Person(title: 'محمد محجوب', subTitle: 22),
    Person(title: 'نعيم مطر', subTitle: 10),
    Person(title: 'ابراهيم قويدر', subTitle: 5),
    Person(title: 'رمضان شامية', subTitle: 2),
  ];

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    quantityController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'العقيد',
          style: GoogleFonts.cairo(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    content: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'إضافة زبون',
                          style: GoogleFonts.cairo(
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
                        CustomTextField(
                          labelText: 'الكمية',
                          textEditingController: quantityController,
                          textInputType: TextInputType.number,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RadioListTile(
                              title: const Text('شاي'),
                              value: 'شاي',
                              groupValue: order,
                              onChanged: (value) {
                                setState(() {
                                  order = value.toString();
                                });
                              },
                            ),
                            RadioListTile(
                              title: const Text('قهوة'),
                              value: 'قهوة',
                              groupValue: order,
                              onChanged: (value) {
                                setState(() {
                                  order = value.toString();
                                });
                              },
                            ),
                            RadioListTile(
                              title: const Text('نسكافيه'),
                              value: 'نسكافيه',
                              groupValue: order,
                              onChanged: (value) {
                                setState(() {
                                  order = value.toString();
                                });
                              },
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              // TODO: read from database
                              nameController.text.isNotEmpty
                                  ? name = nameController.text
                                  : name = 'تجربة';
                              quantityController.text.isNotEmpty
                                  ? quantity =
                                      int.parse(quantityController.text)
                                  : quantity = 0;
                              toDayList.add(
                                  Person(title: name!, subTitle: quantity!));
                              Navigator.of(context).pop();
                            });
                          },
                          child: Text(
                            'حفظ',
                            style: GoogleFonts.cairo(),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
                nameController.clear();
                quantityController.clear();
              });
            },
            icon: const Icon(Icons.person_add_outlined),
          ),
          PopupMenuButton(
            itemBuilder: (context) => [],
            icon: const Icon(Icons.menu),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: toDayList.length,
        itemBuilder: (context, index) {
          return CustomListTile(
            title: toDayList[index].title,
            supTitle: toDayList[index].subTitle.toString(),
            leadingOnPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      UserScreen(title: toDayList[index].title),
                ),
              );
            },
            trailingOnPress: () {
              setState(() {
                toDayList[index].subTitle != 0
                    ? toDayList[index].subTitle--
                    : toDayList.removeAt(index);
              });
            },
          );
        },
      ),
    );
  }
}
