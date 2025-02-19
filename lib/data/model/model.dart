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

  // Map<String, dynamic> toMap() {
  //   return {
  //     'id': id,
  //     'title': title,
  //     'content': content,
  //     'image': image, // Updated field
  //     'color': color, // New field
  //   };
  // }

  // factory NoteModel.fromMap(Map<String, dynamic> map) {
  //   return NoteModel(
  //     id: map['id'],
  //     title: map['title'],
  //     content: map['content'],
  //     image: map['image'], // Updated field
  //     color: map['color'], // New field
  //   );
  // }
}
