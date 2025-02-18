import 'package:hirola_app/db/model/model.dart';
import 'package:sqflite/sqflite.dart';

late Database _db;

// Initialize Database
Future<void> initializeDatabase() async {
  _db = await openDatabase(
    "notes.db",
    version: 1,
    onCreate: (Database db, int version) async {
      await db.execute(
        "CREATE TABLE notes ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "title TEXT, "
        "content TEXT, "
        "image TEXT"
        ");",
      );
    },
  );
}

// Add Note
Future<void> addNote(NoteModel note) async {
  await _db.insert(
    'notes',
    {
      'title': note.title,
      'content': note.content,
      'image': note.image, // Store as file path or Base64 string
    },
  );
}

// Fetch All Notes
Future<List<Map<String, dynamic>>> getAllNotes() async {
  return await _db.query('notes');
}

// Update Note
Future<void> updateNote(NoteModel updatedNote) async {
  await _db.update(
    'notes',
    {
      'title': updatedNote.title,
      'content': updatedNote.content,
      'image': updatedNote.image,
    },
    where: 'id = ?',
    whereArgs: [updatedNote.id],
  );
}

// Delete Note
Future<void> deleteNote(int id) async {
  await _db.delete('notes', where: 'id = ?', whereArgs: [id]);
}
