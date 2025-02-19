part of 'get_all_notes_bloc.dart';

@immutable
abstract class GetAllNotesState {}

class GetAllNotesInitial extends GetAllNotesState {}

class FetchAllNotesLoadingState extends GetAllNotesState{}

class FetchAllNotesLoadedState extends GetAllNotesState{
  final List<Map<String, dynamic>> notes;
  FetchAllNotesLoadedState(this.notes);
}

class FetchAllNotesFaliureState extends GetAllNotesState{
  final String error;
  FetchAllNotesFaliureState(this.error);
}
