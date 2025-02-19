import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hirola_app/core/colors.dart';
import 'package:hirola_app/data/database.dart';
import 'package:hirola_app/presentation/screens/add_note_screen/add_note_screen.dart';
import 'package:hirola_app/presentation/screens/view_screen/view_screen.dart';

import '../../bloc/get_all_notes/get_all_notes_bloc.dart';
import 'widgets/custom_list_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<GetAllNotesBloc>().add(FetchAllNotesEvent());

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 9.0, right: 9),
                      child: TextFormField(
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: kGrey300,
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
                                color: kblack,
                                fontWeight: FontWeight.w400,
                                fontSize: 18)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: kGrey300,
                          borderRadius: BorderRadius.circular(11)),
                      child: IconButton(
                          onPressed: () async {
                            final allnotes = await getAllNotes();
                            log("printing allnotes $allnotes");
                          },
                          icon: Icon(
                            Icons.grid_3x3,
                            color: kblack,
                          )),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: BlocBuilder<GetAllNotesBloc, GetAllNotesState>(
                  builder: (context, state) {
                    if (state is FetchAllNotesLoadingState) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is FetchAllNotesLoadedState) {
                      return state.notes.isEmpty
                          ? Center(child: Text("No notes found"))
                          // : StaggeredGrid.count(
                          //     crossAxisCount: 2,
                          //     mainAxisSpacing: 4.0,
                          //     crossAxisSpacing: 2.0,
                          //     children: [
                          //       StaggeredGridTile.count(
                          //         crossAxisCellCount: 1,
                          //         mainAxisCellCount: 2,
                          //         child: Container(
                          //           color: kRed400,
                          //         ),
                          //       ),
                          //       StaggeredGridTile.count(
                          //           crossAxisCellCount: 1,
                          //           mainAxisCellCount: 1,
                          //           child: Container(
                          //             color: kgreen400,
                          //           )),
                          //       StaggeredGridTile.count(
                          //           crossAxisCellCount: 1,
                          //           mainAxisCellCount: 2,
                          //           child: Container(
                          //             color: kgreen400,
                          //           )),
                          //     ],
                          //   );
                          : ListView.separated(
                              itemCount: state.notes.length,
                              itemBuilder: (context, index) {
                                final note = state.notes[index];

                                return InkWell(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (ctx) => ViewScreen())),
                                  child: CustomListTile(
                                    titlename: note['title'],
                                    contentHere: note['content'],
                                    imagePath: note['image'],
                                    color: note['color'],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) => Gap(10),
                            );
                    } else if (state is FetchAllNotesFaliureState) {
                      return Center(child: Text(state.error));
                    }
                    return Center(child: Text("No notes found"));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => AddNoteScreen()));
        },
        backgroundColor: kRed400,
        child: Icon(
          Icons.add,
          color: kWhite,
        ),
      ),
    );
  }
}

Color getColorFromString(String? colorName) {
  Map<String, Color> colorMap = {
    "grey": Colors.grey[300] ?? Colors.grey,
    "red": Colors.red[400] ?? Colors.red,
    "white": Colors.white,
    "black": Colors.black,
    "teal": Colors.teal[400] ?? Colors.teal,
    "green": Colors.green[400] ?? Colors.green,
    "yellow": Colors.yellow[400] ?? Colors.yellow,
    "orange": Colors.orange[400] ?? Colors.orange,
  };

  // Return the mapped color or default to white
  return colorMap[colorName?.toLowerCase() ?? "white"] ?? Colors.white;
}
