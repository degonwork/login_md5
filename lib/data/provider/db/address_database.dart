import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../model/district.dart';
import '../../model/province.dart';
import '../../model/wards.dart';

class AddressDatabase {
  AddressDatabase._init();
  //create singleton instance ProductDatabaset
  static final AddressDatabase instance = AddressDatabase._init();
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB("address.db");
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final name = 'TEXT NOT NULL';
    final type = 'TEXT NOT NULL';
    final slug = 'TEXT NOT NULL';
    final name_with_type = 'TEXT NOT NULL';
    final path = 'TEXT NOT NULL';
    final path_with_type = 'TEXT NOT NULL';
    final code = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final parent_code = 'INTEGER NOT NULL';
    await db.execute('''
CREATE TABLE $tableProvinces(
  ${ProvinceField.name} $name,
  ${ProvinceField.slug} $slug,
  ${ProvinceField.type} $type,
  ${ProvinceField.name_with_type} $name_with_type,
  ${ProvinceField.code} $code
  )''');
    await db.execute('''
CREATE TABLE $tableDistrict(
  ${DistrictField.name} $name,
  ${DistrictField.type} $type,
  ${DistrictField.slug} $slug,
  ${DistrictField.name_with_type} $name_with_type,
  ${DistrictField.path} $path,
  ${DistrictField.path_with_type} $path_with_type,
  ${DistrictField.code} $code,
  ${DistrictField.parent_code} $parent_code
  )''');
    await db.execute('''
CREATE TABLE $tableWard(
  ${WardField.name} $name,
  ${WardField.type} $type,
  ${WardField.slug} $slug,
  ${WardField.name_with_type} $name_with_type,
  ${WardField.path} $path,
  ${WardField.path_with_type} $path_with_type,
  ${WardField.code} $code,
  ${WardField.parent_code} $parent_code
  )''');
  }

  // Province
  Future<void> createProvince(Province province) async {
    final db = await instance.database;
    final map = province.toJson();
    await db.insert(tableProvinces, map);
  }

  Future<Province?> readProvince(int code) async {
    final db = await instance.database;
    final maps = await db.query(
      tableProvinces,
      columns: ProvinceField.values,
      where: '${ProvinceField.code} = ?',
      whereArgs: [code],
    );
    if (maps.isNotEmpty) {
      return Province.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<List<Province>> readAllProvince() async {
    final db = await instance.database;
    final results = await db.query(tableProvinces);
    return results.map((json) => Province.fromJson(json)).toList();
  }

  // District
  Future<void> createDistrict(District district) async {
    final db = await instance.database;
    final map = district.toJson();
    await db.insert(tableDistrict, map);
  }

  Future<District?> readDistrict(int code) async {
    final db = await instance.database;
    final maps = await db.query(
      tableDistrict,
      columns: DistrictField.values,
      where: '${DistrictField.code} = ?',
      whereArgs: [code],
    );
    if (maps.isNotEmpty) {
      return District.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<List<District>> readAllDistrict() async {
    final db = await instance.database;
    final results = await db.query(tableDistrict);
    return results.map((json) => District.fromJson(json)).toList();
  }

  Future<void> deleteDistrict() async {
    final db = await instance.database;
    await db.delete(tableDistrict);
  }

  // Ward
  Future<void> createWard(Ward district) async {
    final db = await instance.database;
    final map = district.toJson();
    await db.insert(tableWard, map);
  }

  Future<Ward?> readWard(int code) async {
    final db = await instance.database;
    final maps = await db.query(
      tableWard,
      columns: WardField.values,
      where: '${WardField.code} = ?',
      whereArgs: [code],
    );
    if (maps.isNotEmpty) {
      return Ward.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<List<Ward>> readAllWard() async {
    final db = await instance.database;
    final results = await db.query(tableWard);
    return results.map((json) => Ward.fromJson(json)).toList();
  }

  Future<void> deleteWard() async {
    final db = await instance.database;
    await db.delete(tableWard);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
