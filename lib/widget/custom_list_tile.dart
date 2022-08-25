import 'package:flutter/material.dart';

class CustomListTile extends StatefulWidget {
  String title;
  String supTitle;
  VoidCallback onTap;
  VoidCallback trailingOnPress;

  CustomListTile({
    Key? key,
    required this.title,
    required this.supTitle,
    required this.onTap,
    required this.trailingOnPress,
  }) : super(key: key);

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  late TextEditingController productController;
  late TextEditingController quantityController;
  int? selectedItem;

  @override
  void initState() {
    super.initState();
    productController = TextEditingController();
    quantityController = TextEditingController();
  }

  @override
  void dispose() {
    productController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          onTap: widget.onTap,
          leading: const Icon(Icons.person_outlined),
          title: Text(
            widget.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          subtitle: Text(
            widget.supTitle,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          trailing: IconButton(
            onPressed: widget.trailingOnPress,
            icon: const Icon(Icons.arrow_forward_ios),
          ),
        ),
        const Divider(
          thickness: 2,
        ),
      ],
    );
  }
}