import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/employee.dart';

final employeeControllerProvider = StateNotifierProvider<EmployeeController, List<Employee>>(
      (ref) => EmployeeController(),
);

class EmployeeController extends StateNotifier<List<Employee>> {
  EmployeeController() : super(_dummyEmployees());

  static List<Employee> _dummyEmployees() {
    return [
      Employee(id: '1', name: 'João Silva', role: 'Desenvolvedor'),
      Employee(id: '2', name: 'Maria Souza', role: 'Designer'),
      Employee(id: '3', name: 'Carlos Lima', role: 'Product Owner'),
    ];
  }

  void saveEmployee(Employee employee) {
    state = [
      for (final e in state)
        if (e.id == employee.id) employee else e,
      if (!state.any((e) => e.id == employee.id)) employee,
    ];
  }
}
