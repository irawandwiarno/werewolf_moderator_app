// import 'dart:io';
// import '../../shared/shared.dart';
// import 'package:sqflite/sqflite.dart';
//
// Database? _database;
//
// class MangaDatabase {
//   Future<Database> get database async {
//     if (_database == null) {
//       _database = await _initDatabase();
//     }
//     return _database!;
//   }
//
//   Future<Database> _initDatabase() async {
//     final documentsDirectory = await getDatabasesPath();
//     final path = join(documentsDirectory, 'mangas.db');
//
//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: (Database db, int version) async => await db.execute(
//           "CREATE TABLE Mangas(id INTEGER PRIMARY KEY, title TEXT, chapter INTEGER, link TEXT, poster_link TEXT)"),
//     );
//   }
//
//   Future<bool> addManga(MangaModel manga) async {
//     try {
//       final existingManga = await getMangaById(manga.id);
//       if (existingManga != null) {
//         print('A manga with this ID already exists.');
//         return false;
//       }
//
//       var res = await _database!.insert(
//         'Mangas',
//         manga.toMap(),
//         conflictAlgorithm: ConflictAlgorithm.replace,
//       );
//       print('Add : $res; success');
//       return true;
//     } catch (e) {
//       print('Failed to insert manga: $e');
//       return false;
//     }
//   }
//
//   Future<List<MangaModel>> getAllMangas() async {
//     try {
//       final List<Map<String, dynamic>> maps = await _database!.query('Mangas');
//       return List.generate(maps.length, (i) => MangaModel.fromMap(maps[i]));
//     } catch (e) {
//       print('Failed to query mangas: $e');
//       return [];
//     }
//   }
//
//   Future<MangaModel?> getMangaById(int id) async {
//     try {
//       final List<Map<String, dynamic>> maps = await _database!.query(
//         'Mangas',
//         where: 'id =?',
//         whereArgs: [id],
//       );
//       if (maps.isEmpty) {
//         return null;
//       }
//       return MangaModel.fromMap(maps[0]);
//     } catch (e) {
//       print('Failed to get manga by ID: $e');
//       return null;
//     }
//   }
//
//   Future<bool> updateManga(MangaModel manga) async {
//     try {
//       var res = await _database!.update(
//         'Mangas',
//         manga.toMap(),
//         where: 'id =?',
//         whereArgs: [manga.id],
//       );
//       if (res > 0) {
//         print('Update : $res; success');
//         return true;
//       } else {
//         print('No manga found with ID: ${manga.id}');
//         return false;
//       }
//     } catch (e) {
//       print('Failed to update manga: $e');
//       return false;
//     }
//   }
//
//   Future<void> deleteManga(int id) async {
//     try {
//       var res = await _database!.delete(
//         'Mangas',
//         where: 'id =?',
//         whereArgs: [id],
//       );
//       if (res > 0) {
//         print('Delete : $res; success');
//       } else {
//         print('No manga found with ID: $id');
//       }
//     } catch (e) {
//       print('Failed to delete manga: $e');
//     }
//   }
// }
