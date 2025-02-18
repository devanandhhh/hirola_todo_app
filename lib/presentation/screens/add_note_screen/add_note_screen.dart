import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hirola_app/core/colors.dart';
import 'package:hirola_app/presentation/screens/add_note_screen/widgets/custom_color_container.dart';

import '../widgets/rolling_switch.dart';

class AddNoteScreen extends StatelessWidget {
  AddNoteScreen({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppbar(context),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20.0, top: 59),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextfield(
                  controller: titleController,
                  title: "Title",
                  hinttext: "Enter title here...",
                ),
                CustomTextfield(
                  controller: contentController,
                  title: "Content",
                  hinttext: "Enter content here..",
                ),
                Text(
                  "Select Color",
                  style: GoogleFonts.aBeeZee(
                      fontSize: 20, fontWeight: FontWeight.w400),
                ),
                Gap(10),
                Row(
                  children: [
                    CustomColorContainer(
                      colorName: kteal400,
                    ),
                    Gap(10),
                    CustomColorContainer(
                      colorName: kRed400,
                    ),
                    Gap(10),
                    CustomColorContainer(
                      colorName: kgreen400,
                    ),
                    Gap(10),
                    CustomColorContainer(
                      colorName: kGrey300,
                    ),
                    Gap(10),
                    CustomColorContainer(
                      colorName: kYellow400,
                    ),
                    Gap(10),
                    CustomColorContainer(
                      colorName: kOrange400,
                    ),
                  ],
                ),
                Gap(10),
                Text(
                  "Select icon image",
                  style: GoogleFonts.aBeeZee(
                      fontSize: 20, fontWeight: FontWeight.w400),
                ),
                Gap(10),
                Row(
                  children: [
                    CustomImageBox(
                      assetImage: "assets/cartoon.png",
                      colorname: kteal400,
                    ),
                    Gap(10),
                    CustomImageBox(
                      assetImage: "assets/taskImageOne.webp",
                      colorname: kgreen400,
                    ),
                    Gap(10),
                    CustomImageBox(
                      assetImage: "assets/exercise.png",
                      colorname: kRed400,
                    )
                  ],
                ),
                Gap(50),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.height * .7,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      color: kOrange400),
                  child: Center(
                    child: Text(
                      "Save Note",
                      style: GoogleFonts.aBeeZee(
                          fontSize: 20,
                          color: kWhite,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  AppBar buildAppbar(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new)),
      title: Text("Add Notes",
          style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold)),
          actions: [SizedBox(height: 40, child: CustomLiteRollingSwitch()),Gap(10)],
    );
  }
}

class CustomImageBox extends StatelessWidget {
  const CustomImageBox(
      {super.key, required this.assetImage, required this.colorname});
  final String assetImage;
  final Color? colorname;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
          color: colorname,
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(image: AssetImage(assetImage))),
    );
  }
}

// class CustomColorContainer extends StatelessWidget {
//   const CustomColorContainer({
//     super.key,
//     required this.kheight,
//   });

//   final double kheight;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: kheight,
//       width: 50,
//       decoration: BoxDecoration(
//           color: kteal400,
//           borderRadius: BorderRadius.circular(10)),
//     );
//   }
// }

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
          style: GoogleFonts.aBeeZee(fontSize: 25, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
              hintText: hinttext,
              hintStyle: GoogleFonts.aBeeZee(
                  fontWeight: FontWeight.w400, fontSize: 20)),
          maxLines: null,
        ),
        Gap(20),
      ],
    );
  }
}
