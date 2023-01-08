// ignore_for_file: missing_return

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../constants/appNames.dart';
import '../Model/adresse.dart';
import '../Model/product.dart';

class LocalDatabaseManager {
  static Database database;

static Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
     join(path,'ticket_database.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE panier(id INTEGER PRIMARY KEY AUTOINCREMENT, nom TEXT, lien TEXT, description TEXT, quantite TEXT, image TEXT)",
        );
        await database.execute(
          "CREATE TABLE adresse(id INTEGER PRIMARY KEY AUTOINCREMENT, pays TEXT, ville TEXT, quartier TEXT, adresse1 TEXT, adresse2 TEXT, idFromServer TEXT)",
        );
      },
      version: 1,
    );
  }


   Future<void> insertProduct(Product product) async {
   
  final Database db = await initializeDB();
    await db.insert(
      'panier',
      product.toMap(),
     // conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

   Future<List<Product>> getPanier() async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> maps = await db.query('panier');
    
    return  List.generate(
            maps.length,
            (i) {
              return Product(
                id: maps[i]['id'],
                nom: maps[i]['nom'],
                lien: maps[i]['lien'],
                description: maps[i]['description'],
                quantite: int.parse(maps[i]['quantite']),
                images: maps[i]['image'].toString(),
              );
            },
          );
  }

  static Future<void> updateProduct(Product product) async {
     final Database db = await initializeDB();
    await db.update(
      'panier',
      product.toMap(),
      where: "id = ?",
      whereArgs: [product.id],
    );
  }

  static Future<void> deleteProduct(int id) async {
     final Database db = await initializeDB();
    await db.delete(
      'panier',
      where: "id = ?",
      whereArgs: [id],
    );
  }

 Future<void> insertAdresse(Adresse adresse) async {
   final Database db = await initializeDB();
    await db.insert(
      'adresse',
      adresse.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

   Future<List<Adresse>> getAdresse() async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> maps = await db.query('adresse');
    return maps.isEmpty
        ? []
        : List.generate(
            maps.length,
            (i) {
              return Adresse(
                id: int.parse(maps[i]['id'].toString()),
                pays: maps[i]['pays'],
                ville: maps[i]['ville'],
                quartier: maps[i]['quartier'],
                adresse1: maps[i]['adresse1'],
                adresse2: maps[i]['adresse2'],
                idFromServer: maps[i]['idFromServer'],
              );
            },
          );
  }

   Future<void> updateAdresse(Adresse adresse) async {
     final Database db = await initializeDB();
    await db.update(
      'adresse',
      adresse.toMap(),
      where: "id = ?",
      whereArgs: [adresse.id],
    );
  }

   Future<void> deleteAdresse(int id) async {
     final Database db = await initializeDB();
    await db.delete(
      'adresse',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
