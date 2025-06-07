import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../domain/employee.dart';

class EmployeeRepository {
  static Database? _database;

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
    await db.insert('employees', {
      'id': employee.id,
      'name': employee.name,
      'role': employee.role,
    });
  }

  Future<void> deleteAll() async {
    final db = await database;
    await db.delete('employees');
  }
}
