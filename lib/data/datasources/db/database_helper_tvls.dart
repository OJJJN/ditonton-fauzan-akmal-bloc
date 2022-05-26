import 'dart:async';

import 'package:ditonton/data/models/tvls/tvls_table.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelperTvls {
  static DatabaseHelperTvls? _databaseHelpertvls;
  DatabaseHelperTvls._instance() {
    _databaseHelpertvls = this;
  }

  factory DatabaseHelperTvls() => _databaseHelpertvls ?? DatabaseHelperTvls._instance();

  static Database? _databasetvls;

  Future<Database?> get databasetvls async {
    if (_databasetvls == null) {
      _databasetvls = await _initDb();
    }
    return _databasetvls;
  }

  static const String _tblWatchlisttvls = 'watchlisttv';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditontontvs.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblWatchlisttvls (
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
  }

  Future<int> insertWatchlistTv(TvlsTable tv) async {
    final db = await databasetvls;
    return await db!.insert(_tblWatchlisttvls, tv.toJson());
  }

  Future<int> removeWatchlistTv(TvlsTable tv) async {
    final db = await databasetvls;
    return await db!.delete(
      _tblWatchlisttvls,
      where: 'id = ?',
      whereArgs: [tv.id],
    );
  }

  Future<Map<String, dynamic>?> getTvById(int id) async {
    final db = await databasetvls;
    final results = await db!.query(
      _tblWatchlisttvls,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistTv() async {
    final db = await databasetvls;
    final List<Map<String, dynamic>> results = await db!.query(_tblWatchlisttvls);

    return results;
  }
}
