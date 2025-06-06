enum AuthStatus {
  authenticated,
  unauthenticated,
  loading,
}

class AuthState {
  final AuthStatus status;

  const AuthState._(this.status);

  const AuthState.authenticated() : this._(AuthStatus.authenticated);
  const AuthState.unauthenticated() : this._(AuthStatus.unauthenticated);
  const AuthState.loading() : this._(AuthStatus.loading);
}
