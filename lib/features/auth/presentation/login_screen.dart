import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../employees/domain/employee.dart';
import '../domain/auth_state.dart';

final authControllerProvider = StateNotifierProvider<AuthController, AuthState>(
      (ref) => AuthController(),
);

class AuthController extends StateNotifier<AuthState> {
  AuthController() : super(const AuthState.unauthenticated());

  Employee? _loggedEmployee;
  Employee? get loggedEmployee => _loggedEmployee;

  // Método assíncrono para login, lança exceções para tratamento na UI
  Future<void> login(String email, String password) async {
    state = const AuthState.loading();

    try {
      // Simula delay de rede
      await Future.delayed(const Duration(seconds: 1));

      if (email.isEmpty || password.isEmpty) {
        throw Exception('Email e senha são obrigatórios');
      }

      if (email != 'user@example.com' || password != '123456') {
        throw Exception('Credenciais inválidas');
      }

      _loggedEmployee = Employee(
        id: 'employee-123',
        name: 'Carlos Ribeiro',
        role: 'Analista Senior',
      );

      state = const AuthState.authenticated();
    } catch (e) {
      state = const AuthState.unauthenticated();
      rethrow; // relança a exceção para exibir na UI
    }
  }

  void logout() {
    _loggedEmployee = null;
    state = const AuthState.unauthenticated();
  }
}
