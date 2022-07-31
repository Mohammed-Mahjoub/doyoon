import 'package:doyoon/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomListTile extends StatefulWidget {
  String title;
  String supTitle;
  VoidCallback leadingOnPress;
  VoidCallback trailingOnPress;

  CustomListTile({
    Key? key,
    required this.title,
    required this.supTitle,
    required this.leadingOnPress,
    required this.trailingOnPress,
  }) : super(key: key);

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  late TextEditingController productController;
  late TextEditingController quantityController;

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
          leading: IconButton(
            onPressed: widget.leadingOnPress,
            icon: const Icon(Icons.more_vert_outlined),
          ),
          title: Text(
            widget.title,
            style: GoogleFonts.cairo(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          subtitle: Text(
            widget.supTitle,
            style: GoogleFonts.cairo(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
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
                              widget.title,
                              style: GoogleFonts.cairo(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            CustomTextField(
                              labelText: 'المنتج',
                              textEditingController: productController,
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
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                'حفظ',
                                style: GoogleFonts.cairo(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
                },
                icon: const Icon(Icons.add),
              ),
              IconButton(
                onPressed: widget.trailingOnPress,
                icon: const Icon(Icons.remove),
              ),
            ],
          ),
        ),
        const Divider(
          thickness: 2,
        ),
      ],
    );
  }
}
