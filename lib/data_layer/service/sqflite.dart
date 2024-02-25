import 'package:gallery/data_layer/model/image_model.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteService {
  // Create a database
//set the database name
  static const String databaseName = "database.db";
  // set an instance of the database
  static Database? db;

//initialize the database
  static Future<Database> initizateDb() async {
    //get the database path
    final databasePath = await getDatabasesPath();
    //join the database path with the database name
    final path = join(databasePath, databaseName);
    //open the database
    return db ??
        await openDatabase(path, version: 1,
            //create the database
            onCreate: (Database db, int version) async {
          //create the tables in the database if the database is not created
          await createTables(db);
        });
  }

  // Create the tables
  static Future<void> createTables(Database database) async {
    //create the images table
    await database.execute(
        'CREATE TABLE Images (id INTEGER PRIMARY KEY AUTOINCREMENT, imagePath TEXT)');
  }

//insert an item into the database
  static Future<int> createItem(ImageModel image) async {
    //initialize the database
    final db = await SqliteService.initizateDb();
//insert the item into the database
    final id = await db.insert(
      'images',
      image.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

//get all the items from the database
  static Future<List<ImageModel>> getItems() async {
    final db = await SqliteService.initizateDb();
//get all the items from the database map them to the ImageModel and return the list
    final List<Map<String, Object?>> queryResult = await db.query('Images');
    return queryResult.map((e) => ImageModel.fromMap(e)).toList();
  }

//delete an item from the database
  static Future<int> deleteItem(int id) async {
    final db = await SqliteService.initizateDb();
//delete the item from the database with the id
    final idResult = await db.delete(
      'Images',
      where: 'id = ?',
      whereArgs: [id.toString()],
    );
    return idResult;
  }
}
