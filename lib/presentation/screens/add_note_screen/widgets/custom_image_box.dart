import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/select_image/select_image_cubit.dart';

class CustomImageBox extends StatelessWidget {
  const CustomImageBox(
      {super.key,
      required this.assetImage,
      required this.colorname,
      required this.isSelected});
  final String assetImage;
  final Color? colorname;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<SelectImageCubit>().selectImage(assetImage);
      },
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
            color: colorname,
            borderRadius: BorderRadius.circular(10),
            border:
                isSelected ? Border.all(color: Colors.black38, width: 3) : null,
            image: DecorationImage(
              image: AssetImage(assetImage),
            )),
      ),
    );
  }
}