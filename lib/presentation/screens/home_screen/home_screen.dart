import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hirola_app/core/colors.dart';
import 'package:hirola_app/data/model/model.dart';
import 'package:hirola_app/presentation/bloc/search_note/search_note_cubit.dart';
import 'package:hirola_app/presentation/bloc/view_toggle/view_toggle_cubit.dart';
import 'package:hirola_app/presentation/screens/add_note_screen/add_note_screen.dart';
import 'package:hirola_app/presentation/screens/home_screen/widgets/custom_grid_tile.dart';
import 'package:hirola_app/presentation/screens/home_screen/widgets/custom_searchfeld.dart';
import 'package:hirola_app/presentation/screens/view_screen/view_screen.dart';

import '../../bloc/get_all_notes/get_all_notes_bloc.dart';
import 'widgets/custom_list_tile.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  TextEditingController searchController = TextEditingController();
  
  Container toggleForListAndGrid() {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          color: kGrey300, borderRadius: BorderRadius.circular(11)),
      child: BlocBuilder<ViewToggleCubit, bool>(
        builder: (context, isGridview) {
          return IconButton(
              onPressed: () {
                context.read<ViewToggleCubit>().toggleView();
              },
              icon: Icon(
                !isGridview ? Icons.list : Icons.grid_view,
                color: kblack,
              ));
        },
      ),
    );
  }

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
                      child:
                          CustomSearchField(searchController: searchController),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: toggleForListAndGrid(),
                  ),
                ],
              ),
              Expanded(
                child: BlocBuilder<SearchNoteCubit, List<Map<String, dynamic>>>(
                  builder: (context, searchResults) {
                    if (searchResults.isNotEmpty) {
                      // Show Search Results
                      return buildNotesList(searchResults, context);
                    }
                    return BlocBuilder<GetAllNotesBloc, GetAllNotesState>(
                      builder: (context, state) {
                        if (state is FetchAllNotesLoadingState) {
                          return Center(child: CircularProgressIndicator());
                        } else if (state is FetchAllNotesLoadedState) {
                          return buildNotesList(state.notes, context);
                        } else if (state is FetchAllNotesFaliureState) {
                          return Center(child: Text(state.error));
                        }
                        return Center(child: Text("No notes found"));
                      },
                    );
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

  Widget buildNotesList(
      List<Map<String, dynamic>> notes, BuildContext context) {
    if (notes.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 110, child: Image.asset("assets/gostimg.png")),
          Text(
            "No notes found",
            style:
                GoogleFonts.aBeeZee(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ],
      );
    }

    return BlocBuilder<ViewToggleCubit, bool>(
      builder: (context, isGridView) {
        return isGridView
            ? GridView.builder(
                padding: EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 10,
                  childAspectRatio: .70,
                ),
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];
                  return InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => ViewScreen(
                          note: NoteModel(
                            title: note["title"],
                            content: note['content'],
                            image: note['image'],
                            color: note['color'],
                            id: note["id"],
                          ),
                        ),
                      ),
                    ),
                    child: CustomGridTile(
                      title: note['title'],
                      content: note['content'],
                      imagePath: note['image'],
                      color: note['color'],
                    ),
                  );
                },
              )
            : ListView.separated(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];
                  return InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => ViewScreen(
                          note: NoteModel(
                            title: note["title"],
                            content: note['content'],
                            image: note['image'],
                            color: note['color'],
                            id: note["id"],
                          ),
                        ),
                      ),
                    ),
                    child: CustomListTile(
                      titlename: note['title'],
                      contentHere: note['content'],
                      imagePath: note['image'],
                      color: note['color'],
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 10),
              );
      },
    );
  }
}
