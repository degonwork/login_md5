import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../model/district.dart';
import '../../model/province.dart';
import '../../model/ward.dart';

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
    final path = 'TEXT NOT NULL';
    final id = 'TEXT PRIMARY KEY';
    final parent_id = 'TEXT NOT NULL';
    await db.execute('''
CREATE TABLE $tableProvinces(
  ${ProvinceField.name} $name,
  ${ProvinceField.slug} $slug,
  ${ProvinceField.type} $type,
  ${ProvinceField.id} $id
  )''');
    await db.execute('''
CREATE TABLE $tableDistrict(
  ${DistrictField.name} $name,
  ${DistrictField.type} $type,
  ${DistrictField.slug} $slug,
  ${DistrictField.path} $path,
  ${DistrictField.id} $id,
  ${DistrictField.parent_id} $parent_id
  )''');
    await db.execute('''
CREATE TABLE $tableWard(
  ${WardField.name} $name,
  ${WardField.type} $type,
  ${WardField.slug} $slug,
  ${WardField.path} $path,
  ${WardField.id} $id,
  ${WardField.parent_id} $parent_id
  )''');
  }

  // Province
  Future<void> createProvinceToDB(Province province) async {
    final db = await instance.database;
    final map = province.toJson();
    await db.insert(tableProvinces, map);
  }

  Future<Province?> readProvinceByID(String? id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableProvinces,
      columns: ProvinceField.values,
      where: '${ProvinceField.id} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Province.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<Province?> readProvinceByName(String? name) async {
    final db = await instance.database;
    final maps = await db.query(
      tableProvinces,
      columns: ProvinceField.values,
      where: '${ProvinceField.name} = ?',
      whereArgs: [name],
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
  Future<void> createDistrictToDB(District district) async {
    final db = await instance.database;
    final map = district.toJson();
    await db.insert(tableDistrict, map);
  }

  Future<District?> readDistrictByID(String? id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableDistrict,
      columns: DistrictField.values,
      where: '${DistrictField.id} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return District.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<District?> readDistrictByName(String? name) async {
    final db = await instance.database;
    final maps = await db.query(
      tableDistrict,
      columns: DistrictField.values,
      where: '${DistrictField.name} = ?',
      whereArgs: [name],
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

  Future<List<District>> readAllDistrictByParentID(String provinceID) async {
    final db = await instance.database;
    final results = await db.query(
      tableDistrict,
      columns: DistrictField.values,
      where: '${DistrictField.parent_id} = ?',
      whereArgs: [provinceID],
    );
    return results.map((json) => District.fromJson(json)).toList();
  }

  // Ward
  Future<void> createWardToDB(Ward district) async {
    final db = await instance.database;
    final map = district.toJson();
    await db.insert(tableWard, map);
  }

  Future<Ward?> readWardByID(String? id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableWard,
      columns: WardField.values,
      where: '${WardField.id} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Ward.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<Ward?> readWardByName(String? name) async {
    final db = await instance.database;
    final maps = await db.query(
      tableWard,
      columns: WardField.values,
      where: '${WardField.name} = ?',
      whereArgs: [name],
    );
    if (maps.isNotEmpty) {
      return Ward.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<List<Ward>> readAllWardByParentID(String districtId) async {
    final db = await instance.database;
    final results = await db.query(tableWard,
        columns: WardField.values,
        where: '${WardField.parent_id} = ?',
        whereArgs: [districtId]);
    return results.map((json) => Ward.fromJson(json)).toList();
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
