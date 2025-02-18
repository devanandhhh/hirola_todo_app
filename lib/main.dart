import 'package:flutter/material.dart';
import 'package:hirola_app/presentation/bloc/theme_bloc/theme_bloc_cubit.dart';
import 'package:hirola_app/presentation/screens/home_screen/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // ✅ Import flutter_bloc

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeBlocCubit(),
        ),
        // BlocProvider(
        //   create: (context) => SubjectBloc(),
        // ),
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
