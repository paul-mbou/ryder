import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ryde_app/src/features/auth/data/appwrite_auth_repository_impl.dart';
import 'package:ryde_app/src/features/auth/domain/entity/auth_state.dart';
import 'package:ryde_app/src/features/auth/domain/repository/auth_repository.dart';

class AuthProvider extends AsyncNotifier<AuthState?> {
  AuthRepository get _repository => ref.read(authRepositoryImpl);
  @override
  Future<AuthState?> build() async => await _checkAuth();

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.signUp(name: name, email: email, password: password);
      return null;
    });
  }

  Future<void> login({required String email, required String password}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await _repository.login(email: email, password: password);
    });
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.logout();
      return null;
    });
  }

  Future<AuthState?> _checkAuth() async => await _repository.checkAuth();
}

final authProvider = AsyncNotifierProvider<AuthProvider, AuthState?>(
  AuthProvider.new,
  retry: (retryCount, error) => null,
);
