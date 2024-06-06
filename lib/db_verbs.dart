import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart' show rootBundle;

class VerbsDB {
  static final VerbsDB instance = VerbsDB._internal();
  static Database? _db;
  VerbsDB._internal();

  Future<Database> get database async {
    if (_db != null) {
      return _db!;
    }
    // TODO: DELETE BEFORE PUBLISH
    databaseFactory.deleteDatabase(join(await getDatabasesPath(), 'german_irregular_verbs'));
    _db = await _initDatabase();
    return _db!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'german_irregular_verbs');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, _) async {
    print("CREATE DATABASE");
    String data = await rootBundle.loadString("assets/verbs.json");
    final jsonResult = jsonDecode(data);
    print(jsonResult);
    // /data/user/0/com.example.german_irregular_verbs/app_flutter
    db.execute(
        'CREATE TABLE verbs('
            'id INTEGER PRIMARY KEY,'
            'infinitive TEXT,'
            'simplePast TEXT,'
            'pastParticiple TEXT,'
            'progress REAL,'
            'isActive INTEGER,'
            'translation_en TEXT,'
            'translation_ru TEXT'
        ')'
    );
    for (var verb in jsonResult['verbs']) {
      var verbToInsert = {
        'infinitive': verb['infinitive'],
        'simplePast': verb['simplePast'],
        'pastParticiple': verb['pastParticiple'],
        'translation_en': verb['i18n']['en'],
        'translation_ru': verb['i18n']['ru'],
        'isActive': 1,
        'progress': 0
      };
      int id = await db.insert('verbs', verbToInsert, conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  Future<List<Verb>> getAllVerbs() async {
    final db = await instance.database;
    final result = await db.query("verbs");
    return result.map((json) => Verb.fromJson(json)).toList();
  }

  Future<int> setVerbSelection(Verb verb, bool isSelected) async {
    final db = await instance.database;
    int update = await db.update(
        "verbs",
        { "isActive": isSelected ? 1 : 0 },
        where: "id = ${verb.id}"
    );
    return update;
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

class Verb {
  final int id;
  final String infinitive;
  final String simplePast;
  final String pastParticiple;
  final Map translations;
  final double progress;
  bool isActive;

  Verb({
    required this.id,
    required this.infinitive,
    required this.simplePast,
    required this.pastParticiple,
    required this.translations,
    required this.progress,
    required this.isActive
  });

  factory Verb.fromJson(Map<String, Object?> json) {
    String translationsDBPrefix = "translation_";
    Iterable<String> translationKeys = json.keys.where((key) => key.startsWith(translationsDBPrefix));

    Map<String, String?> translations = Map();
    for (var translationKey in translationKeys) {
      translations[translationKey.replaceFirst(translationsDBPrefix, "")] = json[translationKey] as String?;
    }

    return Verb(
      id: json["id"] as int,
      infinitive: json["infinitive"] as String,
      simplePast: json["simplePast"] as String,
      pastParticiple: json["pastParticiple"] as String,
      progress: json["progress"] as double,
      isActive: (json["isActive"] as int) == 1,
      translations: translations
    );
  }
}