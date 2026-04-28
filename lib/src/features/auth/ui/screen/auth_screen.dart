import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ryde_app/src/core/constants/assets/assets.gen.dart';
import 'package:ryde_app/src/core/utils/extensions.dart';
import 'package:ryde_app/src/features/auth/ui/auth_provider.dart';
import 'package:ryde_app/src/features/home/home_screen.dart';
import 'package:ryde_app/src/widgets/app_loader.dart';
import 'package:ryde_app/src/widgets/label_textfield.dart';

class AuthScreen extends ConsumerStatefulWidget {
  final bool isSignUp;
  const AuthScreen({super.key, this.isSignUp = false});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    ref.listen(
      authProvider,
      (_, authState) => authState.handle(
        context,
        onSuccess: () {
          widget.isSignUp
              ? context.pushReplacement(AuthScreen())
              : context.pushAndRemoveUntil(HomeScreen());
        },
      ),
    );
    return AbsorbPointer(
      absorbing: ref.watch(authProvider).isLoading,
      child: Scaffold(
        body: FormBuilder(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Assets.images.homeBg.image(
                  fit: BoxFit.cover,
                  height: context.height * 0.1,
                  width: double.infinity,
                  cacheWidth: context.width.toInt(),
                  alignment: AlignmentGeometry.xy(
                    0,
                    context.height / context.height,
                  ),
                ),
                Transform.translate(
                  offset: const Offset(0, -50),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 16,
                      children: [
                        Text(
                          widget.isSignUp
                              ? "Create your account"
                              : "Welcome back",
                          style: context.text.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        GutterTiny(),
                        if (widget.isSignUp)
                          LabelTextField(
                            label: "Name",
                            child: FormBuilderTextField(
                              name: "name",
                              validator: FormBuilderValidators.minLength(3),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteractionIfError,
                              decoration: InputDecoration(
                                hintText: "Enter your name",
                                prefixIcon: Align(
                                  alignment: AlignmentGeometry.xy(0.5, 0),
                                  child: Assets.icons.profile.svg(),
                                ),
                              ),
                            ),
                          ),
                        LabelTextField(
                          label: "Email",
                          child: FormBuilderTextField(
                            name: "email",
                            validator: FormBuilderValidators.email(),
                            autovalidateMode:
                                AutovalidateMode.onUserInteractionIfError,
                            decoration: InputDecoration(
                              hintText: "Enter your email",
                              prefixIcon: Align(
                                alignment: AlignmentGeometry.xy(0.5, 0),
                                child: Assets.icons.message.svg(),
                              ),
                            ),
                          ),
                        ),
                        LabelTextField(
                          label: "Password",
                          child: FormBuilderTextField(
                            name: "password",
                            autovalidateMode:
                                AutovalidateMode.onUserInteractionIfError,
                            validator: FormBuilderValidators.password(),
                            decoration: InputDecoration(
                              hintText: "Enter your password",
                              prefixIcon: Align(
                                alignment: AlignmentGeometry.xy(0.5, 0),
                                child: Assets.icons.lock.svg(),
                              ),
                              suffixIcon: Align(
                                alignment: AlignmentGeometry.xy(0.5, 0),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Assets.icons.eye.svg(
                                    colorFilter: ColorFilter.mode(
                                      const Color(0xff858585),
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        const Gutter(),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(elevation: 8),
                          onPressed: widget.isSignUp ? _signUp : _login,
                          icon: ref.watch(authProvider).isLoading
                              ? const AppLoader()
                              : null,
                          label: Text(widget.isSignUp ? "Sign Up" : "Log In"),
                        ),
                        const Row(
                          children: [
                            Expanded(child: Divider(color: Color(0xffCED1DD))),
                            Gutter(),
                            Text("Or", style: TextStyle()),
                            Gutter(),
                            Expanded(child: Divider(color: Color(0xffCED1DD))),
                          ],
                        ),
                        OutlinedButton.icon(
                          onPressed: _authenticateWithGoogle,
                          label: Text(
                            widget.isSignUp
                                ? "Sign up with Google"
                                : "Log in with Google",
                          ),
                          icon: Assets.icons.google.svg(),
                        ),
                        const GutterTiny(),
                        Center(
                          child: Text.rich(
                            TextSpan(
                              text: widget.isSignUp
                                  ? "Already have an account? "
                                  : "Don't have an account? ",
                              style: const TextStyle(
                                color: Color(0xff858585),
                                fontWeight: FontWeight.w600,
                              ),
                              children: [
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => context.push(
                                      widget.isSignUp
                                          ? const AuthScreen()
                                          : const AuthScreen(isSignUp: true),
                                    ),
                                  text: widget.isSignUp ? "Log in" : "Sign up",
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signUp() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final formData = _formKey.currentState?.value;
      await ref
          .read(authProvider.notifier)
          .signUp(
            name: formData?['name'],
            email: formData?['email'],
            password: formData?['password'],
          );
    }
  }

  Future<void> _login() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final formData = _formKey.currentState?.value;
      await ref
          .read(authProvider.notifier)
          .login(email: formData?['email'], password: formData?['password']);
    }
  }

  Future<void> _authenticateWithGoogle() async {
    // Implementation for Google authentication
  }
}
