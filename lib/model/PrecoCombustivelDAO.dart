import 'package:app/model/PrecoCombustivel.dart';
import 'package:app/DatabaseHelper.dart';
import 'package:sqflite/sqflite.dart';


class PrecoCombustivelDAO {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> insert(PrecoCombustivel preco) async {
    final db = await _dbHelper.database;
    await db.insert('PrecoCombustivel', preco.toMap());
  }

  Future<List<PrecoCombustivel>> getAll() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('PrecoCombustivel');
    return List.generate(maps.length, (i) {
      return PrecoCombustivel.fromMap(maps[i]);
    });
  }

  Future<void> update(PrecoCombustivel preco) async {
    final db = await _dbHelper.database;
    await db.update(
      'PrecoCombustivel',
      preco.toMap(),
      where: 'id = ?',
      whereArgs: [preco.id],
    );
  }

  Future<void> delete(int id) async {
    final db = await _dbHelper.database;
    await db.delete(
      'PrecoCombustivel',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
