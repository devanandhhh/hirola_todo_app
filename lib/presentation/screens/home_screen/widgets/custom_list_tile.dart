
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hirola_app/presentation/screens/home_screen/home_screen.dart';

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
      height: MediaQuery.of(context).size.height * .15,
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
                    style: GoogleFonts.aBeeZee(
                        fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  Text(contentHere,
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
