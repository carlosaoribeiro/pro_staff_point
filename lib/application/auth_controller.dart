import 'package:flutter_riverpod/flutter_riverpod.dart';
// Escolha UM import correto abaixo e remova o outro
import '../domain/auth_state.dart';
import '../features/auth/domain/auth_state.dart';
// import '../features/auth/domain/auth_state.dart';

class AuthController extends StateNotifier<AuthState> {
  AuthController() : super(const AuthState.unauthenticated());

  Future<void> login(String email, String password) async {
    state = const AuthState.loading();
    await Future.delayed(const Duration(seconds: 2));
    state = const AuthState.authenticated();
  }

  void logout() {
    state = const AuthState.unauthenticated();
  }
}

final authControllerProvider = StateNotifierProvider<AuthController, AuthState>(
      (ref) => AuthController(),
);
