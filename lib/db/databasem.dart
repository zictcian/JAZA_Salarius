import 'dart:io';
import 'dart:async';
import 'package:finance/model/movement.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseM {
  static final DatabaseM instance = DatabaseM._instance();
  static Database _db;

  DatabaseM._instance();

  String movement = 'movement';
  String colId = 'id';
  String colType = 'type';
  String colConcept = 'concept';
  String colMount = 'mount';

  Future<Database> get db async{
    if(_db == null) {
      _db = await _initDb();
    }
    return _db;
  }

  Future<Database> _initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'salarius.db';
    final salariusDb = await openDatabase(path, version: 1, onCreate: _createDb);
    return salariusDb;
  }
  void _createDb(Database db, int version) async {
    await db.execute('CREATE TABLE $movement($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colType TEXT, $colConcept TEXT, $colMount TEXT)');
  }

  Future<List<Map<String, dynamic>>> getMovementMapList() async {
    Database db = await this.db;
    final List<Map<String, dynamic>> result = await db.query(movement);
    return result;
  }

  Future<List<Movement>> getMovementList() async {
    final List<Map<String, dynamic>> movementMapList = await getMovementMapList();
    final List<Movement> movementList = [];
    movementMapList.forEach((movementMap) { 
      movementList.add(Movement.fromMap(movementMap));
    });
    return movementList;
  }

  Future<int> insertMovement(Movement movementV) async {
    Database db = await this.db;
    final int result = await db.update(movement, movementV.toMap());
    return result;
  }
}