import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/employee.dart';
import '../data/employee_repository.dart';

final employeeControllerProvider =
StateNotifierProvider<EmployeeController, List<Employee>>(
      (ref) => EmployeeController(EmployeeRepository()),
);

class EmployeeController extends StateNotifier<List<Employee>> {
  final EmployeeRepository _repository;
  late List<Employee> _allEmployees;

  EmployeeController(this._repository) : super([]) {
    _loadEmployees();
  }

  Future<void> _loadEmployees() async {
    final employees = await _repository.getEmployees();
    _allEmployees = employees;
    state = employees;
  }

  Future<void> add(Employee employee) async {
    await _repository.addEmployee(employee);
    await _loadEmployees();
    print('🔄 Salvando no banco: ${employee.toString()}');
  }

  // Método update adicionado
  Future<void> update(Employee employee) async {
    await _repository.updateEmployee(employee);
    await _loadEmployees();
    print('🔄 Atualizando no banco: ${employee.toString()}');
  }

  void filter(String query) async {
    final allEmployees = await _repository.getEmployees();

    if (query.isEmpty) {
      state = allEmployees;
    } else {
      state = allEmployees
          .where((e) =>
      e.name.toLowerCase().contains(query.toLowerCase()) ||
          e.role.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}
