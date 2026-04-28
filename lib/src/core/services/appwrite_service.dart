import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ryde_app/src/core/constants/appwrite.env.dart';

class AppwriteService {
  static final Client _client = Client()
      .setProject(Environment.appwriteProjectId)
      .setEndpoint(Environment.appwritePublicEndpoint);
  final Account account = Account(_client);
}

final appwriteServiceProvider = Provider<AppwriteService>((ref) {
  return AppwriteService();
});
