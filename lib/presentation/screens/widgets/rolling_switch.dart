import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hirola_app/presentation/bloc/theme_bloc/theme_bloc_cubit.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

class CustomLiteRollingSwitch extends StatefulWidget {
  const CustomLiteRollingSwitch({super.key});

  @override
  State<CustomLiteRollingSwitch> createState() =>
      _CustomLiteRollingSwitchState();
}

class _CustomLiteRollingSwitchState extends State<CustomLiteRollingSwitch> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBlocCubit,bool>(
      builder: (context, isDarkMode) {
        return LiteRollingSwitch(
          width: 90,
          value: isDarkMode,
          textOn: 'ON',
          textOff: 'OFF',
          colorOn: Colors.grey,
          colorOff: const Color(0xFF292929),
          textOnColor: Colors.black,
          textOffColor: Colors.white,
          iconOn: Icons.done,
          iconOff: Icons.remove_circle_outline,
          textSize: 16.0,
          onChanged: (bool isDarkMode) {
            context.read<ThemeBlocCubit>().toggleTheme();
          },
          onTap: () {},
          onDoubleTap: () {},
          onSwipe: () {},
        );
      },
    );
  }
}
