import 'package:hms/db/app_db.dart';
import 'package:sqflite/sqflite.dart';

abstract class BaseRepository<T> {
  Database? _db;

  String get tableName;

  T fromMap(Map<String, dynamic> map);

  Map<String, dynamic> toMap(T model);

  Future<Database> get database async {
    _db ??= await AppDatabase.instance.database;
    return _db!;
  }

  Future<int> insert(T model) async {
    final db = await database;
    return await db.insert(
      tableName,
      toMap(model),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertAll(List<T> models) async {
    if (models.isEmpty) return;
    final db = await database;
    final batch = db.batch();
    for (final m in models) {
      batch.insert(
        tableName,
        toMap(m),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  Future<T?> getById(int id) async {
    final db = await database;
    final result = await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (result.isEmpty) return null;
    return fromMap(result.first);
  }

  Future<List<T>> getAll() async {
    final db = await database;
    final result = await db.query(tableName);
    return result.map(fromMap).toList();
  }

  Future<List<Map<String, Object?>>> getByCondition({
    String columns = '*',
    bool distinct = false,
    String? where,
    List<Object?>? whereArgs,
    String? orderBy,
    String? groupBy,
    String? having,
  }) async {
    final db = await database;

    final buffer = StringBuffer('SELECT ');

    if (distinct) buffer.write('DISTINCT ');

    buffer.write(columns);
    buffer.write(' FROM $tableName');

    if (where != null && where.isNotEmpty) {
      buffer.write(' WHERE $where');
    }

    if (groupBy != null) {
      buffer.write(' GROUP BY $groupBy');
    }

    if (having != null) {
      buffer.write(' HAVING $having');
    }

    if (orderBy != null) {
      buffer.write(' ORDER BY $orderBy');
    }

    return await db.rawQuery(buffer.toString(), whereArgs);
  }

  Future<List<T>> query({
    String? where,
    List<Object?>? whereArgs,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    final db = await database;
    final result = await db.query(
      tableName,
      where: where,
      whereArgs: whereArgs,
      orderBy: orderBy,
      limit: limit,
      offset: offset,
    );
    return result.map(fromMap).toList();
  }

  Future<int> update(T model, int id) async {
    final db = await database;
    return await db.update(
      tableName,
      toMap(model),
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> delete(int id) async {
    final db = await database;
    return await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteAll() async {
    final db = await database;
    return await db.delete(tableName);
  }
}
