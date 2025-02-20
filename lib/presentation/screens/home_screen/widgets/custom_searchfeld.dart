
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/colors.dart';
import '../../../bloc/get_all_notes/get_all_notes_bloc.dart';
import '../../../bloc/search_note/search_note_cubit.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({
    super.key,
    required this.searchController,
  });

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: searchController,
      decoration: InputDecoration(
          filled: true,
          fillColor: kGrey300,
          suffixIcon: IconButton(
              onPressed: () {
                context.read<GetAllNotesBloc>().add(FetchAllNotesEvent());
                searchController.clear();
              },
              icon: Icon(Icons.close)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          hintText: "Search your notes",
          hintStyle: GoogleFonts.aBeeZee(
              color: kblack, fontWeight: FontWeight.w400, fontSize: 18)),
      onChanged: (value) {
        if (value.isEmpty) {
          context
              .read<GetAllNotesBloc>()
              .add(FetchAllNotesEvent()); // Show all notes
        } else {
          context.read<SearchNoteCubit>().search(value); // Trigger search
        }
      },
    );
  }
}
