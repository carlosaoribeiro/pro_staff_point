import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../application/employee_controller.dart';

class EmployeesScreen extends ConsumerWidget {
  const EmployeesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final employees = ref.watch(employeeControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Funcionários')),
      body: ListView.builder(
        itemCount: employees.length,
        itemBuilder: (context, index) {
          final employee = employees[index];
          return ListTile(
            title: Text(employee.name),
            subtitle: Text(employee.role),
            onTap: () => context.push('/employees/${employee.id}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/employees/form'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
