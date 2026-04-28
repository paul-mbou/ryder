import 'dart:convert';

import 'package:appwrite/appwrite.dart';

// enum AppException {
//   userAlreadyExists('User already exists', 'user_already_exists', '409'),
//   unknown('An unknown error occurred', 'unknown_error', '500');

//   const AppException(this.message, this.type, this.code);
//   final String message, type, code;
// }

class ErrorHandler {
  static String fromAppwriteException(AppwriteException e) {
    final json = jsonDecode(e.response!);
    return switch (json["type"]) {
      "user_already_exists" => "User already exists",
      "user_invalid_credentials" => "Invalid email or password",
      _ => "An unknown error occurred. Please try again later.",
    };
  }
}
