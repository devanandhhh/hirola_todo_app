import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hirola_app/core/colors.dart';
import 'package:hirola_app/data/db/database.dart';
import 'package:hirola_app/data/model/model.dart';
import 'package:hirola_app/presentation/screens/add_note_screen/add_note_screen.dart';
import 'package:hirola_app/presentation/screens/widgets/custom_save_button.dart';

import '../../bloc/color_bloc/color_bloc_cubit.dart';
import '../../bloc/get_all_notes/get_all_notes_bloc.dart';
import '../../bloc/select_image/select_image_cubit.dart';
import '../add_note_screen/widgets/custom_textfield.dart';

// ignore: must_be_immutable
class ViewScreen extends StatelessWidget {
  ViewScreen({super.key, required this.note});

  final NoteModel note;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController =
        TextEditingController(text: note.title);
    final TextEditingController contentController =
        TextEditingController(text: note.content);
    return Scaffold(
      //backgroundColor: getColorFromString(note.color),
      appBar: buildAppbar(
        context,
        note.id,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextfield(
                    controller: titleController,
                    title: "Tile ",
                    hinttext: "Title here"),
                Gap(10),
                CustomTextfield(
                    controller: contentController,
                    title: "Content",
                    hinttext: "Content here"),
                Gap(10),
                //=========
                Text(
                  "Select Color",
                  style: GoogleFonts.aBeeZee(
                      fontSize: 20, fontWeight: FontWeight.w400),
                ),
                Gap(10),
                BlocBuilder<ColorBlocCubit, String?>(
                  builder: (context, selectedColor) {
                    return colorRow(selectedColor);
                  },
                ),
                Gap(10),

                //-------

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
                Gap(10),
                //
                InkWell(
                    onTap: () {
                      final formValid = formKey.currentState!.validate();
                      final selectedColor =
                          context.read<ColorBlocCubit>().state;
                      final selectedImage =
                          context.read<SelectImageCubit>().state;

                      if (formValid) {
                        final updatedNewNote = NoteModel(
                            id: note.id,
                            title: titleController.text,
                            content: contentController.text,
                            image: selectedImage ?? note.image,
                            color: selectedColor ?? note.color
                           
                            );
                        updateNote(updatedNewNote).then((_) {
                          // ignore: use_build_context_synchronously
                          context
                              .read<GetAllNotesBloc>()
                              .add(FetchAllNotesEvent());
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                        });
                      }
                    },
                    child: CustomSaveButton()),
                Gap(10)
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar buildAppbar(
    BuildContext context,
    int? id,
  ) {
    return AppBar(
      //backgroundColor: color,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new)),
      title: Text("Edit Notes",
          style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold)),
      actions: [
        IconButton(
            onPressed: () {
              //alert dialog
              customAlertDialog(context, id);
            },
            icon: Icon(Icons.delete))
      ],
    );
  }

  Future<dynamic> customAlertDialog(BuildContext context, int? id) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Delete Note"),
        content: Text("Are you sure you want to delete?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.blue),
            ),
          ),
          TextButton(
            onPressed: () {
              deleteNote(id!);
              context.read<GetAllNotesBloc>().add(FetchAllNotesEvent());
              Navigator.pop(context);
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Deleted Successfully"),
                behavior: SnackBarBehavior.floating,
                backgroundColor: kgreen400,
              ));
            },
            child: Text(
              "Ok",
              style: TextStyle(color: Colors.blue),
            ),
          )
        ],
      ),
    );
  }
}
