
import 'package:flutter_application_1/models/type_elements.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CruddataBase {
  late final Database _database;
  Future<void> openDb() async {
    final databasepath = await getDatabasesPath();
    final path = join(databasepath, "Element.db");
    _database = await openDatabase(path, version: 1, onCreate: _CreateDb);
  }

 Future<void> _CreateDb(Database db, int version) async {
  await db.execute('''
CREATE TABLE type_element(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  nom TEXT NOT NULL,
  description TEXT NOT NULL
)
''');
}


  Future<int> insertElement(TypeElement TypeElement) async {
    await openDb();
    return await _database.insert('type_element', TypeElement.toMap());
  }

  Future<void> updateElement(TypeElement TypeElement) async {
    await openDb();
    await _database.update('type_element', TypeElement.toMap(),
        where: 'id = ?', whereArgs: [TypeElement.id]);
  }

  Future<void> deleteElement(int id) async {
    await openDb();
    await _database.delete('type_element', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<TypeElement>> getTypeElement() async {
    await openDb();

    final List<Map<String, dynamic>> maps =
        await _database.query('type_element');

    return List.generate(maps.length, (i) {
      return TypeElement(
          id: maps[i]['id'], nom: maps[i]['nom'], description: maps[i]['description']);
    });
  }

  Future<TypeElement?> getElementWithId(int id) async {
    await openDb();
    final List<Map<String, dynamic>> maps =
        await _database.query("type_element", where: "id = ?", whereArgs: [id]);
    if (maps.isNotEmpty) {
      return TypeElement(
          id: maps[0]['id'], nom: maps[0]['nom'], description: maps[0]['description']);
    } else {
      return null;
    }
  }
}