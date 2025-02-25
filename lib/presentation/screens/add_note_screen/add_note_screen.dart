import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hirola_app/core/colors.dart';
import 'package:hirola_app/presentation/bloc/color_bloc/color_bloc_cubit.dart';
import 'package:hirola_app/presentation/bloc/select_image/select_image_cubit.dart';
import 'package:hirola_app/presentation/screens/add_note_screen/widgets/custom_color_container.dart';

import '../../../data/db/database.dart';
import '../../../data/model/model.dart';
import '../../bloc/get_all_notes/get_all_notes_bloc.dart';
import '../widgets/custom_save_button.dart';
import '../widgets/rolling_switch.dart';
import 'widgets/custom_image_box.dart';
import 'widgets/custom_textfield.dart';

class AddNoteScreen extends StatelessWidget {
  AddNoteScreen({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final formKey = GlobalKey<FormState>();

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
                    //color row for Selection
                    return colorRow(selectedColor);
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
                    return imageRow(selectImage);
                  },
                ),
                Gap(50),
                InkWell(
                  onTap: () async {
                    final formValid = formKey.currentState!.validate();
                    final selectedColor = context.read<ColorBlocCubit>().state;
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
                        context
                            .read<GetAllNotesBloc>()
                            .add(FetchAllNotesEvent());

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
                    } else if (selectedColor == null || selectedImage == null) {
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
                  child: CustomSaveButton(),
                ),
                Gap(10)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Row imageRow(String? selectImage) {
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
          isSelected: selectImage == "assets/taskImageOne.webp"),
      Gap(10),
      CustomImageBox(
          assetImage: "assets/exercise.png",
          colorname: kRed400,
          isSelected: selectImage == "assets/exercise.png")
    ],
  );
}

Row colorRow(String? selectedColor) {
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
}
