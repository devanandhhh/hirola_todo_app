import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hirola_app/core/colors.dart';
import 'package:hirola_app/presentation/screens/add_note_screen/add_note_screen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                            hintStyle: GoogleFonts.aBeeZee(color: kblack,
                                fontWeight: FontWeight.w400, fontSize: 18)),
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
                          onPressed: () {}, icon: Icon(Icons.grid_3x3,color: kblack,)),
                    ),
                  ),
                ],
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
