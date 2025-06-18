import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:collection/collection.dart';

// Application

import 'features/employees/application/employee_controller.dart';

// Domain
import 'features/auth/domain/auth_state.dart';

// Presentation (screens)
import 'features/auth/presentation/login_screen.dart';
import 'features/dashboard/presentation/dashboard_screen.dart';
import 'features/employees/presentation/employees_screen.dart';
import 'features/employees/presentation/employee_form_screen.dart';
import 'features/employees/presentation/employee_detail_screen.dart';
import 'features/time_tracking/presentation/time_tracking_screen.dart';
import 'features/vacations/presentation/vacations_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authController = ref.watch(authControllerProvider.notifier);

  return GoRouter(
    initialLocation: '/',
    refreshListenable: GoRouterRefreshStream(authController.stream),
    redirect: (context, state) {
      final authState = ref.read(authControllerProvider);
      final isLoggedIn = authState.status == AuthStatus.authenticated;
      final loggingIn = state.uri.path == '/';

      if (!isLoggedIn && !loggingIn) return '/';
      if (isLoggedIn && loggingIn) return '/dashboard';

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
      // Rota para a listagem de funcionários
      GoRoute(
        path: '/employees',
        builder: (context, state) => const EmployeesScreen(),
      ),
      // Rota para criar novo funcionário
      GoRoute(
        path: '/employees/form',
        builder: (context, state) => const EmployeeFormScreen(),
      ),
      // Rota para editar funcionário com id
      GoRoute(
        path: '/employees/form/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return Consumer(
            builder: (context, ref, _) {
              final employee = ref
                  .watch(employeeControllerProvider)
                  .firstWhereOrNull((e) => e.id == id);
              if (employee == null) {
                return const Scaffold(
                  body: Center(child: Text('Funcionário não encontrado')),
                );
              }
              return EmployeeFormScreen(employee: employee);
            },
          );
        },
      ),
      // Rota para detalhes do funcionário
      GoRoute(
        path: '/employees/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return EmployeeDetailScreen(employeeId: id);
        },
      ),
      GoRoute(
        path: '/time-tracking',
        builder: (context, state) => const TimeTrackingScreen(),
      ),
      GoRoute(
        path: '/vacations',
        builder: (context, state) => const VacationsScreen(),
      ),
    ],
  );
});

class StaffPointProApp extends ConsumerWidget {
  const StaffPointProApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'StaffPointPro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      routerConfig: router,
    );
  }
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final StreamSubscription _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
