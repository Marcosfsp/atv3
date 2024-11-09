import 'package:app/model/Destino.dart';
import 'package:app/DatabaseHelper.dart';


class DestinoDAO {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> insert(Destino destino) async {
    final db = await _dbHelper.database;
    await db.insert('Destino', destino.toMap());
  }

  Future<List<Destino>> getAll() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('Destino');
    return List.generate(maps.length, (i) {
      return Destino.fromMap(maps[i]);
    });
  }

  Future<void> update(Destino destino) async {
    final db = await _dbHelper.database;
    await db.update(
      'Destino',
      destino.toMap(),
      where: 'id = ?',
      whereArgs: [destino.id],
    );
  }

  Future<void> delete(int id) async {
    final db = await _dbHelper.database;
    await db.delete(
      'Destino',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
