import 'package:flutter/material.dart';
import 'package:hirola_app/data/db/database.dart';
import 'package:hirola_app/presentation/bloc/get_all_notes/get_all_notes_bloc.dart';
import 'package:hirola_app/presentation/bloc/color_bloc/color_bloc_cubit.dart';
import 'package:hirola_app/presentation/bloc/search_note/search_note_cubit.dart';
import 'package:hirola_app/presentation/bloc/select_image/select_image_cubit.dart';
import 'package:hirola_app/presentation/bloc/theme_bloc/theme_bloc_cubit.dart';
import 'package:hirola_app/presentation/bloc/view_toggle/view_toggle_cubit.dart';
import 'package:hirola_app/presentation/screens/home_screen/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeBlocCubit()),
        BlocProvider(create: (context) => ColorBlocCubit()),
        BlocProvider(create: (context) => SelectImageCubit()),
        BlocProvider(create: (context) => GetAllNotesBloc()),
        BlocProvider(create: (context) => ViewToggleCubit()),
        BlocProvider(create: (context) => SearchNoteCubit()),
      ],
      child: BlocBuilder<ThemeBlocCubit, bool>(
        builder: (context, isDarkMode) {
          return MaterialApp(
              title: 'Hirola app',
              debugShowCheckedModeBanner: false,
              theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
              home: HomeScreen());
        },
      ),
    );
  }
}
