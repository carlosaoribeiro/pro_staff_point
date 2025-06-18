enum AuthStatus {
  authenticated,
  unauthenticated,
  loading,
}

class AuthState {
  final AuthStatus status;

  const AuthState._({required this.status});

  const AuthState.authenticated() : this._(status: AuthStatus.authenticated);
  const AuthState.unauthenticated() : this._(status: AuthStatus.unauthenticated);
  const AuthState.loading() : this._(status: AuthStatus.loading);
}
