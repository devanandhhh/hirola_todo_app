class NoteModel {
  int? id;
  String title;
  String content;
  String image; // Changed to int
  String color;   // New field

  NoteModel({
    this.id,
    required this.title,
    required this.content,
    required this.image,
    required this.color,
  });

  
}
