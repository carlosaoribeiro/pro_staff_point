import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../domain/employee.dart';

class EmployeeRepository {
  static Database? _database;

  Future<void> updateEmployee(Employee employee) async {
    final db = await database;
    await db.update(
      'employees',
      {
        'name': employee.name,
        'role': employee.role,
      },
      where: 'id = ?',
      whereArgs: [employee.id],
    );
  }

  Future<Database> get database async {
    return _database ??= await _initDB();
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'employees.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE employees (
            id TEXT PRIMARY KEY,
            name TEXT,
            role TEXT
          )
        ''');
      },
    );
  }

  Future<List<Employee>> getEmployees() async {
    final db = await database;
    final maps = await db.query('employees');

    return maps.map((e) => Employee(
      id: e['id'] as String,
      name: e['name'] as String,
      role: e['role'] as String,
    )).toList();
  }

  Future<void> addEmployee(Employee employee) async {
    final db = await database;

    await db.insert(
      'employees',
      {
        'id': employee.id,
        'name': employee.name,
        'role': employee.role,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    // DEBUG: imprime todos os registros no banco
    final result = await db.query('employees');
    print('🟢 Funcionários no banco: $result');
  }

  Future<void> deleteAll() async {
    final db = await database;
    await db.delete('employees');
  }
}


