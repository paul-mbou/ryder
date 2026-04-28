import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ryde_app/src/features/auth/ui/auth_provider.dart';
import 'package:ryde_app/src/features/auth/ui/screen/auth_screen.dart';
import 'package:ryde_app/src/features/home/home_screen.dart';
import 'package:ryde_app/src/features/splash_screen/splash_screen.dart';

class AppStartupWidget extends ConsumerWidget {
  const AppStartupWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(authProvider)
        .when(
          skipLoadingOnReload: true,
          data: (_) {
            return HomeScreen();
          },
          error: (error, st) {
            log("Error checking auth: $error", stackTrace: st);
            return AuthScreen();
          },
          loading: () => SplashScreen(),
        );
  }
}
