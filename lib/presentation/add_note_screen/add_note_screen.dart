import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class AddNoteScreen extends StatelessWidget {
  AddNoteScreen({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new)),
          title: Text("Add Notes",
              style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold)),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20.0, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Title",
                style: GoogleFonts.aBeeZee(
                    fontSize: 20, fontWeight: FontWeight.w400),
              ),
              TextFormField(
                controller: titleController,
                style: GoogleFonts.aBeeZee(
                    fontSize: 25, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                    hintText: "Enter title here...",
                    hintStyle: GoogleFonts.aBeeZee(
                        fontWeight: FontWeight.w400, fontSize: 20)),
              ),
              Gap(20),
              Text(
                "Content",
                style: GoogleFonts.aBeeZee(
                    fontSize: 20, fontWeight: FontWeight.w400),
              ),
              TextFormField(
                controller: contentController,
                style: GoogleFonts.aBeeZee(
                    fontSize: 22, fontWeight: FontWeight.bold),
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                    hintText: "Enter content here..",
                    hintStyle: GoogleFonts.aBeeZee(
                        fontWeight: FontWeight.w400, fontSize: 20)),
              )
            ],
          ),
        ));
  }
}
