import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Database? _database;
List wholedatalist = [];
List SYSTEM = [];
List bill = [];
List detail_bill = [];
List customers = [];
List Type_datalist = [];
List Type_datalist2 = [];
List<Map<String, dynamic>> _wholeDataList = [];

class LocalDatabase {
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initializeDB();
    return _database!;
  }

  Future<void> createDatabase() async {
    await _initializeDB();
  }

  Future _initializeDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "Localdata2.db");
    return await openDatabase(
      path,
      version: 2,
      onCreate: _createDB,
    );
  }

  static const his_game = '''
  CREATE TABLE IF NOT EXISTS his_game(
  id_his INTEGER PRIMARY KEY AUTOINCREMENT,
  end_time_unix INTEGER NOT NULL ,
  play_scale INTEGER NOT NULL ,
  win_by INTEGER NOT NULL ,
  enemy TEXT NOT NULL ,
  data_table_all TEXT NOT NULL  ,
  Who1 TEXT NOT NULL ,
  Who2 TEXT NOT NULL ,
  Who_win TEXT NOT NULL ,
  winner_table TEXT NOT NULL ,
  end_turn INTEGER NOT NULL 

  );
  ''';

  Future<void> _createDB(Database db, int version) async {
    await db.execute(his_game);
  }

  Future<List<Map<String, dynamic>>> getAll_his() async {
    final db = await database;
    return await db.query('his_game');
  }

  Future<void> insert_his_game({
    required int end_time_unix,
    required int play_scale,
    required int win_by,
    required String enemy,
    required String data_table_all,
    required String Who1,
    required String Who2,
    required String Who_win,
    required String winner_table,
    required int end_turn,
  }) async {
    final db = await database;

    try {
      await db.insert(
        'his_game',
        {
          'end_time_unix': end_time_unix,
          'play_scale': play_scale,
          'win_by': win_by,
          'enemy': enemy,
          'data_table_all': data_table_all,
          'Who1': Who1,
          'Who2': Who2,
          'Who_win': Who_win,
          'winner_table': winner_table,
          'end_turn': end_turn,
        },
      );

      print("OK");
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> deleteAllHis() async {
    final db = await database;
    await db.delete(
      'his_game',
    );
  }
}
