
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'select_image_state.dart';

class SelectImageCubit extends Cubit<String?> {
  SelectImageCubit() : super(null);

  void selectImage(String imagepath) {
    emit(imagepath);
  }
  void resetImage() {
    emit(null);
  }
}
