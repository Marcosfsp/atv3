import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:app/model/Carro.dart';
import 'package:app/model/Destino.dart';
import 'package:app/model/PrecoCombustivel.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'viagem.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE Carro (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            modelo TEXT,
            autonomia REAL
          )
        ''');
        await db.execute('''
          CREATE TABLE Destino (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT,
            distancia REAL
          )
        ''');
        await db.execute('''
          CREATE TABLE PrecoCombustivel (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            tipo TEXT,
            preco REAL,
            data TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertCarro(Carro carro) async {
    final db = await database;
    await db.insert('Carro', carro.toMap());
  }

  Future<void> insertDestino(Destino destino) async {
    final db = await database;
    await db.insert('Destino', destino.toMap());
  }

  Future<void> insertPreco(PrecoCombustivel preco) async {
    final db = await database;
    await db.insert('PrecoCombustivel', preco.toMap());
  }

  Future<List<Carro>> getCarros() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Carro');
    return List.generate(maps.length, (i) {
      return Carro(
        id: maps[i]['id'],
        modelo: maps[i]['modelo'],
        autonomia: maps[i]['autonomia'],
      );
    });
  }

  Future<List<Destino>> getDestinos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Destino');
    return List.generate(maps.length, (i) {
      return Destino(
        id: maps[i]['id'],
        nome: maps[i]['nome'],
        distancia: maps[i]['distancia'],
      );
    });
  }

  Future<List<PrecoCombustivel>> getPrecos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('PrecoCombustivel');
    return List.generate(maps.length, (i) {
      return PrecoCombustivel(
        id: maps[i]['id'],
        tipo: maps[i]['tipo'],
        preco: maps[i]['preco'],
        data: DateTime.parse(maps[i]['data']),
      );
    });
  }
}
