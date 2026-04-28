import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:ryde_app/src/core/constants/assets/assets.gen.dart';
import 'package:ryde_app/src/core/utils/extensions.dart';
import 'package:ryde_app/src/features/auth/ui/screen/auth_screen.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Assets.images.homeBg.image(cacheWidth: context.width.toInt()),
          GutterLarge(),
          Text(
            "Let's get started",
            textAlign: TextAlign.center,
            style: context.text.headlineMedium?.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
          const Gutter(),
          Text(
            textAlign: TextAlign.center,
            softWrap: true,
            "Sign up or login to find out the best car for you",
            style: context.text.bodyLarge?.copyWith(),
          ),
          const GutterLarge(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(elevation: 8),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AuthScreen(isSignUp: true),
                      ),
                    );
                  },
                  child: const Text("Sign Up"),
                ),
                const Gutter.custom(size: 20),
                const Row(
                  children: [
                    Expanded(child: Divider(color: Color(0xffCED1DD))),
                    Gutter(),
                    Text("Or", style: TextStyle()),
                    Gutter(),
                    Expanded(child: Divider(color: Color(0xffCED1DD))),
                  ],
                ),
                const Gutter.custom(size: 20),
                OutlinedButton.icon(
                  onPressed: () {},
                  label: const Text("Sign up with Google"),
                  icon: Assets.icons.google.svg(),
                ),
                GutterLarge(),
                Text.rich(
                  TextSpan(
                    text: "Already have an account? ",
                    style: const TextStyle(
                      color: Color(0xff858585),
                      fontWeight: FontWeight.w600,
                    ),
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => context.push(AuthScreen()),
                        text: "Login",
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
