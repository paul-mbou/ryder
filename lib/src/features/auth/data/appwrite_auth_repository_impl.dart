import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ryde_app/src/core/exceptions/app_exceptions.dart';
import 'package:ryde_app/src/core/services/appwrite_service.dart';
import 'package:ryde_app/src/features/auth/domain/entity/auth_state.dart';
import 'package:ryde_app/src/features/auth/domain/repository/auth_repository.dart';

class AppwriteAuthRepositoryImpl implements AuthRepository {
  final AppwriteService _client;
  AppwriteAuthRepositoryImpl(this._client);

  @override
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final user = await _client.account.create(
        userId: ID.unique(),
        email: email,
        password: password,
        name: name,
      );
      log(user.toString());
    } on AppwriteException catch (e) {
      final exception = ErrorHandler.fromAppwriteException(e);
      throw exception;
    }
  }

  @override
  Future<AuthState> login({
    required String email,
    required String password,
  }) async {
    try {
      final session = await _client.account.createEmailPasswordSession(
        email: email,
        password: password,
      );
      log(session.toString());
      return AuthState(
        userId: session.userId,
        sessionId: session.$id,
        userEmail: email,
      );
    } on AppwriteException catch (e) {
      log(e.toString(), name: "AppwriteException Login Error");
      final exception = ErrorHandler.fromAppwriteException(e);
      throw exception;
    }
  }

  @override
  Future<void> logout() async =>
      await _client.account.deleteSession(sessionId: "current");

  @override
  Future<AuthState?> checkAuth() async {
    try {
      final session = await _client.account.getSession(sessionId: "current");
      final user = await _client.account.get();
      final parsedSession = DateTime.tryParse(session.expire);
      if (parsedSession == null) {
        throw "Invalid session expiration date";
      }
      if (parsedSession.isAfter(DateTime.now()) && user.$id == session.userId) {
        log("Session is valid");
        return AuthState(
          userId: session.userId,
          sessionId: session.$id,
          userEmail: user.email,
        );
      } else {
        log("Session has expired");
        return null;
      }
    } on AppwriteException catch (e) {
      log(e.toString(), name: "AppwriteException isLoggedIn Error");
      throw "Your session has expired.";
    }
  }
}

final authRepositoryImpl = Provider<AuthRepository>((ref) {
  return AppwriteAuthRepositoryImpl(ref.watch(appwriteServiceProvider));
});
