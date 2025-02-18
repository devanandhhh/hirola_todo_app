class NoteModel {
  int? id;
  String title;
  String content;
  int imageIndex; // Changed to int
  String color;   // New field

  NoteModel({
    this.id,
    required this.title,
    required this.content,
    required this.imageIndex,
    required this.color,
  });

  // Map<String, dynamic> toMap() {
  //   return {
  //     'id': id,
  //     'title': title,
  //     'content': content,
  //     'imageIndex': imageIndex, // Updated field
  //     'color': color, // New field
  //   };
  // }

  // factory NoteModel.fromMap(Map<String, dynamic> map) {
  //   return NoteModel(
  //     id: map['id'],
  //     title: map['title'],
  //     content: map['content'],
  //     imageIndex: map['imageIndex'], // Updated field
  //     color: map['color'], // New field
  //   );
  // }
}
