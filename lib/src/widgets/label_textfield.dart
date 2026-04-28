import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ryde_app/src/core/utils/extensions.dart';

class LabelTextField extends StatelessWidget {
  final String label;
  final FormBuilderField child;
  const LabelTextField({
    super.key,
    required this.label,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.text.bodyLarge?.copyWith(fontWeight: FontWeight.w900),
        ),
        child,
      ],
    );
  }
}
