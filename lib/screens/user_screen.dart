import 'package:doyoon/widget/custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserScreen extends StatefulWidget {
  String title;

  UserScreen({required this.title, Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        automaticallyImplyLeading: false,
        title: Text(
          widget.title,
          style: GoogleFonts.cairo(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        children: [
          CustomListTile(
            title: widget.title,
            supTitle: 'شاي 5-2-2022',
            leadingOnPress: () {},
            trailingOnPress: () {},
          ),
          CustomListTile(
            title: widget.title,
            supTitle: 'قهوة 5-2-2022',
            leadingOnPress: () {},
            trailingOnPress: () {},
          ),
        ],
      ),
    );
  }
}
