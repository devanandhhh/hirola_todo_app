import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/database.dart';

part 'get_all_notes_event.dart';
part 'get_all_notes_state.dart';

class GetAllNotesBloc extends Bloc<GetAllNotesEvent, GetAllNotesState> {
  GetAllNotesBloc() : super(GetAllNotesInitial()) {
    on<FetchAllNotesEvent>((event, emit) async {
      emit(FetchAllNotesLoadingState()); // Emit loading state

      try {
        final notes = await getAllNotes(); // Fetch all notes using your method
        emit(FetchAllNotesLoadedState(notes)); // Emit loaded state with data
      } catch (e) {
        emit(FetchAllNotesFaliureState("Failed to fetch notes")); // Emit failure state
      }
    });
  }
}
