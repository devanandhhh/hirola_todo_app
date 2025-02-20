import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/colors.dart';

class CustomSaveButton extends StatelessWidget {
  const CustomSaveButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.height * .7,
      decoration: BoxDecoration(
        border: Border.all(),
          borderRadius: BorderRadius.circular(9),
          color: Colors.blue),
      child: Center(
        child: Text(
          "Save Note",
          style: GoogleFonts.aBeeZee(
              fontSize: 20,
              color: kWhite,
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}