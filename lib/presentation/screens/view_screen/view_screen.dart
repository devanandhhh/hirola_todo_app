import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewScreen extends StatelessWidget {
  const ViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(context),
    );
  }

  AppBar buildAppbar(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new)),
      title: Text("Edit Notes",
          style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold)),
      actions: [],
    );
  }
}
