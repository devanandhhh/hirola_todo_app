
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'color_bloc_state.dart';

class ColorBlocCubit extends Cubit<String?> {
  ColorBlocCubit() : super(null);
  
   void selectColor(String color) {
    emit(color);
  }
  void resetColor() {
    emit(null);
  }
}
