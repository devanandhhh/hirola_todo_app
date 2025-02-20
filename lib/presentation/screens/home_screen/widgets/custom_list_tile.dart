import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/methods.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.color,
    required this.titlename,
    required this.contentHere,
    required this.imagePath,
  });

  final String color;
  final String titlename;
  final String contentHere;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
          color: getColorFromString(color),
          borderRadius: BorderRadius.circular(9)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * .6,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titlename,
                    //convertingString(titlename, 19),
                    maxLines: 1,
                    style: GoogleFonts.aBeeZee(
                        fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  Text(
                      titlename
                      //convertingString(contentHere,21)
                      ,
                      maxLines: 2,
                      style: GoogleFonts.aBeeZee(
                        fontSize: 18,
                      ))
                ],
              ),
            ),
          ),
          Image.asset(imagePath)
        ],
      ),
    );
  }
}

String convertingString(String text, int maxLength) {
  return text.length > maxLength ? '${text.substring(0, maxLength)}...' : text;
}
