import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hirola_app/core/colors.dart';
import 'package:hirola_app/presentation/bloc/color_bloc/color_bloc_cubit.dart';
import 'package:hirola_app/presentation/bloc/select_image/select_image_cubit.dart';
import 'package:hirola_app/presentation/screens/add_note_screen/widgets/custom_color_container.dart';

import '../../../data/database.dart';
import '../../../data/model/model.dart';
import '../../bloc/get_all_notes/get_all_notes_bloc.dart';
import '../widgets/rolling_switch.dart';

class AddNoteScreen extends StatelessWidget {
  AddNoteScreen({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppbar(context),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20.0, top: 59),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
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
                  BlocBuilder<ColorBlocCubit, String?>(
                    builder: (context, selectedColor) {
                      return Row(
                        children: [
                          CustomColorContainer(
                            colorName: "teal",
                            isSelected: selectedColor == "teal",
                          ),
                          Gap(10),
                          CustomColorContainer(
                            colorName: "red",
                            isSelected: selectedColor == "red",
                          ),
                          Gap(10),
                          CustomColorContainer(
                            colorName: "green",
                            isSelected: selectedColor == "green",
                          ),
                          Gap(10),
                          CustomColorContainer(
                            isSelected: selectedColor == "grey",
                            colorName: "grey",
                          ),
                          Gap(10),
                          CustomColorContainer(
                            isSelected: selectedColor == "yellow",
                            colorName: "yellow",
                          ),
                          Gap(10),
                          CustomColorContainer(
                            isSelected: selectedColor == "orange",
                            colorName: "orange",
                          ),
                        ],
                      );
                    },
                  ),
                  Gap(10),
                  Text(
                    "Select icon image",
                    style: GoogleFonts.aBeeZee(
                        fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                  Gap(10),
                  BlocBuilder<SelectImageCubit, String?>(
                    builder: (context, selectImage) {
                      return Row(
                        children: [
                          CustomImageBox(
                            assetImage: "assets/cartoon.png",
                            colorname: kteal400,
                            isSelected: selectImage == "assets/cartoon.png",
                          ),
                          Gap(10),
                          CustomImageBox(
                              assetImage: "assets/taskImageOne.webp",
                              colorname: kgreen400,
                              isSelected:
                                  selectImage == "assets/taskImageOne.webp"),
                          Gap(10),
                          CustomImageBox(
                              assetImage: "assets/exercise.png",
                              colorname: kRed400,
                              isSelected: selectImage == "assets/exercise.png")
                        ],
                      );
                    },
                  ),
                  Gap(50),
                  InkWell(
                    onTap: () async {
                      final formValid = formKey.currentState!.validate();
                      final selectedColor =
                          context.read<ColorBlocCubit>().state;
                      final selectedImage =
                          context.read<SelectImageCubit>().state;
                      if (formValid &&
                          selectedColor != null &&
                          selectedImage != null) {
                        final newNote = NoteModel(
                          title: titleController.text.trim(),
                          content: contentController.text.trim(),
                          image: selectedImage,
                          color: selectedColor,
                        );

                        try {
                          await addNote(newNote);
// ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Note saved successfully!"),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.green,
                            ),
                          );

                          titleController.clear();
                          contentController.clear();
                          // ignore: use_build_context_synchronously
                          context.read<ColorBlocCubit>().resetColor();
                          // ignore: use_build_context_synchronously
                          context.read<SelectImageCubit>().resetImage();
                          // ignore: use_build_context_synchronously
                              context.read<GetAllNotesBloc>().add(FetchAllNotesEvent());

// ignore: use_build_context_synchronously
                          Navigator.pop(context); 
                        } catch (e) {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Failed to save note: $e"),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: kRed400,
                            ),
                          );
                        }
                      } else if (selectedColor == null ||
                          selectedImage == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              selectedColor == null && selectedImage == null
                                  ? "Please select a color and an image"
                                  : selectedColor == null
                                      ? "Please select a color"
                                      : "Please select an image",
                            ),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: kRed400,
                          ),
                        );
                      }
                    },
                    child: Container(
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
                    ),
                  )
                ],
              ),
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
      actions: [
        SizedBox(height: 40, child: CustomLiteRollingSwitch()),
        Gap(10)
      ],
    );
  }
}

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
