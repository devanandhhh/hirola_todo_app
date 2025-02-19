import 'package:hirola_app/data/model/model.dart';
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
        "image TEXT, " // Changed image field to an integer
        "color TEXT"           // Added new color field
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
      'image': note.image, // Changed field name
      'color': note.color, // Added color field
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
      'image': updatedNote.image, // Updated field name
      'color': updatedNote.color, // Updated color field
    },
    where: 'id = ?',
    whereArgs: [updatedNote.id],
  );
}

// Delete Note
Future<void> deleteNote(int id) async {
  await _db.delete('notes', where: 'id = ?', whereArgs: [id]);
}
