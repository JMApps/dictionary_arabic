import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DefaultDictionaryService {
  static final DefaultDictionaryService _instance = DefaultDictionaryService.internal();

  factory DefaultDictionaryService() => _instance;

  DefaultDictionaryService.internal();

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initializeDatabase();
    return _db!;
  }

  Future<Database> initializeDatabase() async {
    const int dbVersion = 2;
    const String sfqDatabaseName = 'arabic_dictionary.db';
    final String databasePath = await getDatabasesPath();
    String path = join(databasePath, sfqDatabaseName);

    Database database = await openDatabase(path);

    if (await database.getVersion() < dbVersion) {
      await database.close();
      await deleteDatabase(path);
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (e) {
        throw Exception('Invalid create $sfqDatabaseName = $e');
      }

      ByteData data = await rootBundle.load(join('assets/databases', sfqDatabaseName));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);

      database = await openDatabase(path);
      await database.setVersion(dbVersion);
    }

    return database;
  }
}
