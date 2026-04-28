import 'package:ryde_app/src/features/auth/domain/entity/auth_state.dart';

abstract interface class AuthRepository<T> {
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  });
  Future<AuthState> login({required String email, required String password});
  Future<void> logout();
  Future<AuthState?> checkAuth();
}
