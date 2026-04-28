import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:ryde_app/src/core/utils/extensions.dart';

class OnboardingWidget extends StatelessWidget {
  final Widget image;
  final String bigText, smallText;
  const OnboardingWidget({
    super.key,
    required this.image,
    required this.bigText,
    required this.smallText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        image,
        const GutterLarge(),
        Text(
          bigText,
          textAlign: TextAlign.center,
          style: context.text.headlineMedium?.copyWith(
            fontWeight: FontWeight.w900,
          ),
        ),
        const Gutter(),
        SizedBox(
          width: context.width * 0.65,
          child: Text(textAlign: TextAlign.center, softWrap: true, smallText),
        ),
      ],
    );
  }
}
