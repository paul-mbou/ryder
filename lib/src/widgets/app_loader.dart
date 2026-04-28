import 'package:flutter/material.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 20, maxWidth: 20),
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 3,
          // color: Theme.of(context).colorScheme.onPrimary,
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).colorScheme.onPrimary, // visible on primary bg
          ),
          strokeCap: StrokeCap.round,
        ),
      ),
    );
  }
}
