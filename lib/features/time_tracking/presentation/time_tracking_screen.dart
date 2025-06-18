import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../application/time_tracking_controller.dart';
import '../domain/time_tracking.dart';
import 'package:uuid/uuid.dart';
import '../../auth/application/auth_controller.dart'; // Importar para pegar funcionário logado

class TimeTrackingScreen extends ConsumerWidget {
  const TimeTrackingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final records = ref.watch(timeTrackingControllerProvider);
    final controller = ref.read(timeTrackingControllerProvider.notifier);

    final employee = ref.read(authControllerProvider.notifier).loggedEmployee;
    if (employee == null) {
      return const Scaffold(
        body: Center(child: Text('Usuário não autenticado')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Controle de Ponto')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    final newRecord = TimeTracking(
                      id: const Uuid().v4(),
                      employeeId: employee.id,  // Usa o id do funcionário logado
                      date: DateTime.now(),
                      checkIn: DateTime.now(),
                    );
                    controller.checkIn(newRecord);
                  },
                  child: const Text('Registrar Entrada'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (records.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Nenhum registro para fazer check-out')),
                      );
                      return;
                    }
                    final lastRecord = records.last;
                    if (lastRecord.checkOut != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Último registro já possui check-out')),
                      );
                      return;
                    }
                    controller.checkOut(lastRecord.id, DateTime.now());
                  },
                  child: const Text('Registrar Saída'),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: records.length,
              itemBuilder: (context, index) {
                final record = records[index];
                return ListTile(
                  title: Text('Data: ${record.date.toLocal()}'),
                  subtitle: Text(
                    'Entrada: ${record.checkIn?.toLocal().toString() ?? '-'}\n'
                        'Saída: ${record.checkOut?.toLocal().toString() ?? '-'}',
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
