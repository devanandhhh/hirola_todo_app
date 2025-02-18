class NoteModel {
  int? id;
  String title;
  String content;
  String image; // Store file path or Base64 string

  NoteModel({
    this.id,
    required this.title,
    required this.content,
    required this.image,
  });

}

//   // Convert NoteModel to Map for database operations
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'title': title,
//       'content': content,
//       'image': image,
//     };
//   }

//   // Create NoteModel from Map (for retrieving from database)
//   factory NoteModel.fromMap(Map<String, dynamic> map) {
//     return NoteModel(
//       id: map['id'],
//       title: map['title'],
//       content: map['content'],
//       image: map['image'],
//     );
//   }
// }
