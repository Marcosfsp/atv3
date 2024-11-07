import 'package:app/model/Carro.dart';
import 'package:app/DatabaseHelper.dart';
import 'package:sqflite/sqflite.dart';



class CarroDAO {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> insert(Carro carro) async {
    final db = await _dbHelper.database;
    await db.insert('Carro', carro.toMap());
  }

  Future<List<Carro>> getAll() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('Carro');
    return List.generate(maps.length, (i) {
      return Carro.fromMap(maps[i]);
    });
  }

  Future<void> update(Carro carro) async {
    final db = await _dbHelper.database;
    await db.update(
      'Carro',
      carro.toMap(),
      where: 'id = ?',
      whereArgs: [carro.id],
    );
  }

  Future<void> delete(int id) async {
    final db = await _dbHelper.database;
    await db.delete(
      'Carro',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
