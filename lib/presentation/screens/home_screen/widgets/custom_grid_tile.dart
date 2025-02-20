import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/methods.dart';

class CustomGridTile extends StatelessWidget {
  final String title;
  final String content;
  final String? imagePath;
  final String? color;

  const CustomGridTile({
    super.key,
    required this.title,
    required this.content,
    this.imagePath,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: getColorFromString(color), // Convert int color to Flutter Color
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (imagePath != null && imagePath!.isNotEmpty) SizedBox(height: 8),
          Text(
            title,
            style:
                GoogleFonts.aBeeZee(fontWeight: FontWeight.bold, fontSize: 25),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4),
          Text(
            content,
            style:
                GoogleFonts.aBeeZee(fontWeight: FontWeight.bold, fontSize: 18),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imagePath!,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.image_not_supported),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
