
import 'package:flutter/material.dart';


class CustomColorContainer extends StatelessWidget {
  const CustomColorContainer({
    super.key,
    required this.colorName,
  });

 final Color? colorName;

  @override
  Widget build(BuildContext context) {
        double kheight = MediaQuery.of(context).size.height * 0.06;

    return Container(
      height: kheight,
      width: 50,
      decoration: BoxDecoration(
          color: colorName,
          borderRadius: BorderRadius.circular(10)),
    );
  }
}