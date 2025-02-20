

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    super.key,
    required this.controller,
    required this.title,
    required this.hinttext,
  });

  final TextEditingController controller;
  final String title;
  final String hinttext;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.aBeeZee(fontSize: 20, fontWeight: FontWeight.w400),
        ),
        TextFormField(
            controller: controller,
            style:
                GoogleFonts.aBeeZee(fontSize: 25, fontWeight: FontWeight.bold),
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
                hintText: hinttext,
                hintStyle: GoogleFonts.aBeeZee(
                    fontWeight: FontWeight.w400, fontSize: 20)),
            maxLines: null,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Field is Required";
              }
              return null;
            }),
        Gap(20),
      ],
    );
  }
}
