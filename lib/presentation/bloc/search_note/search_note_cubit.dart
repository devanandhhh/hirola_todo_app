import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/database.dart';

part 'search_note_state.dart';

class SearchNoteCubit extends Cubit<List<Map<String, dynamic>>> {
  SearchNoteCubit() : super([]);
  // Function to search notes
  void search(String query) async {
    final results = await searchNotes(query); // Fetch from database
    emit(results);
  }
}
