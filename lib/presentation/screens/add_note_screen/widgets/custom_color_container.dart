import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hirola_app/presentation/bloc/color_bloc/color_bloc_cubit.dart';

import '../../../../core/colors.dart';

class CustomColorContainer extends StatelessWidget {
  const CustomColorContainer(
      {super.key, required this.colorName, required this.isSelected});

  final String colorName;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    double kheight = MediaQuery.of(context).size.height * 0.06;
    Color? getColor(String colorName) {
      switch (colorName) {
        case "teal":
          return kteal400;
        case "green":
          return kgreen400;
        case "red":
          return kRed400;
        case "grey":
          return kGrey300;
        case "yellow":
          return kYellow400;
        case "orange":
          return kOrange400;
        default:
          return Colors.grey;
      }
    }

    return InkWell(
      onTap: () {
        context.read<ColorBlocCubit>().selectColor(colorName);
      },
      child: Container(
        height: kheight,
        width: 50,
        decoration: BoxDecoration(
          color: getColor(colorName),
          borderRadius: BorderRadius.circular(10),
          border:
              isSelected ? Border.all(color: Colors.black38, width: 3) : null,
        ),
      ),
    );
  }
}
