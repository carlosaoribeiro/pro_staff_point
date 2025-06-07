import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../application/employee_controller.dart';
import '../domain/employee.dart';

class EmployeeDetailScreen extends ConsumerWidget {
  final String employeeId;

  const EmployeeDetailScreen({super.key, required this.employeeId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final employees = ref.watch(employeeControllerProvider);
    final Employee? employee = employees
        .where((e) => e.id == employeeId)
        .cast<Employee?>()
        .firstOrNull;

    if (employee == null) {
      return const Scaffold(
        body: Center(child: Text('Funcionário não encontrado')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(employee.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Cargo: ${employee.role}',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            const Text('Mais detalhes podem ser adicionados aqui.'),
          ],
        ),
      ),
    );
  }
}
