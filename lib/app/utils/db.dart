// post_helper.dart
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  // 데이터베이스를 시작한다.
  Future _openDb() async {
    final databasePath = await getDatabasesPath();
    String path = join(databasePath, 'gnumap.db');

    final db = await openDatabase(
      path,
      version: 1,
      onConfigure: (Database db) => {},
      onCreate: _onCreate,
      onUpgrade: (Database db, int oldVersion, int newVersion) => {},
    );

    return db;
  }

  // 데이터베이스 테이블을 생성한다.
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE History (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL
      )
      
    ''');

    await db.execute('''
      CREATE TABLE Favorites (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        num INTEGER NOT NULL,
        name TEXT NOT NULL
      )
    ''');
  }

  // 모든 아이템들을 가져온다
  Future getHistoryItems() async {
    final db = await _openDb();

    List items = await db.query('History', columns: ['name']);
    return List.from(items.toList().reversed);
  }

  Future isEmpty(String num) async {
    final db = await _openDb();
    num = num.replaceAll("동", "");
    List items = await db.query('History',
        columns: ['name'], where: 'name = ?', whereArgs: [num]);

    return List.from(items.toList().reversed);
  }

  // 새로운 데이터를 추가한다.
  Future add(String item) async {
    final db = await _openDb();
    await db.insert(
      'History', // table name
      {
        'name': '$item',
      }, // new History row data
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // 데이터를 삭제한다.
  Future remove(String name) async {
    final db = await _openDb();
    await db.delete(
      'History', // table name
      where: 'name = ?',
      whereArgs: [name],
    );
  }
}

class FavoriteHelper {
  // 데이터베이스를 시작한다.
  Future _openDb() async {
    final databasePath = await getDatabasesPath();
    String path = join(databasePath, 'favorite.db');

    final db = await openDatabase(
      path,
      version: 1,
      onConfigure: (Database db) => {},
      onCreate: _onCreate,
      onUpgrade: (Database db, int oldVersion, int newVersion) => {},
    );

    return db;
  }

  // 데이터베이스 테이블을 생성한다.
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Favorites (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        num INTEGER NOT NULL,
        name TEXT NOT NULL
      )
    ''');
  }

  // 모든 아이템들을 가져온다
  Future getItems() async {
    final db = await _openDb();

    List items = await db.query('Favorites', columns: ['num', 'name']);
    return items.toList();
  }

  Future isEmpty(String num) async {
    final db = await _openDb();

    var parsenum;
    try {
      parsenum = int.parse(num);
    } catch (e) {
      parsenum = num;
    }

    if (parsenum is int) {
      print("이거 $num실행");
      List items = await db.query('Favorites',
          columns: ['num', 'name'], where: 'num = ?', whereArgs: [parsenum]);

      return items.toList();
    } else {
      print("$num 이거실헹");
      List items = await db.query('Favorites',
          columns: ['num', 'name'],
          where: 'name like ?',
          whereArgs: ['%$parsenum%']);

      return items.toList();
    }
  }

  // 새로운 데이터를 추가한다.
  Future add(String item, String itemid) async {
    final db = await _openDb();
    await db.insert(
      'Favorites', // table name
      {'name': '$item', 'num': '$itemid'}, // new Favorites row data
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // 변경된 데이터를 업데이트한다.
  Future update(item) async {
    final db = await _openDb();
    await db.update(
      'Favorites', // table name
      {
        'title': 'changed Favorites title ...',
        'name': 'changed Favorites content ...',
      }, // update Favorites row data
      where: 'id = ?',
      whereArgs: [item.id],
    );
    return item;
  }

  // 데이터를 삭제한다.
  Future remove(String name) async {
    final db = await _openDb();
    await db.delete(
      'Favorites', // table name
      where: 'name LIKE ? OR num = ?',
      whereArgs: ['%$name%', name],
    );
  }
}
