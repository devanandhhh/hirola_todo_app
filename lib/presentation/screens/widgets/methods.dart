import 'package:flutter/material.dart';

Color getColorFromString(String? colorName) {
  Map<String, Color> colorMap = {
    "grey": Colors.grey[300] ?? Colors.grey,
    "red": Colors.red[400] ?? Colors.red,
    "white": Colors.white,
    "black": Colors.black,
    "teal": Colors.teal[400] ?? Colors.teal,
    "green": Colors.green[400] ?? Colors.green,
    "yellow": Colors.yellow[400] ?? Colors.yellow,
    "orange": Colors.orange[400] ?? Colors.orange,
  };

  // Return the mapped color or default to white
  return colorMap[colorName?.toLowerCase() ?? "white"] ?? Colors.white;
}
