import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../application/employee_controller.dart';


class EmployeesScreen extends ConsumerWidget {
  const EmployeesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final employees = ref.watch(employeeControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Funcionários')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: employees.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final employee = employees[index];
          return ListTile(
            title: Text(employee.name),
            subtitle: Text(employee.role),
            leading: CircleAvatar(child: Text(employee.name[0])),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Futuro: navegar para detalhes
            },
          );
        },
      ),
    );
  }
}
