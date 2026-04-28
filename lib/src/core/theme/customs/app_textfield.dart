import 'package:flutter/material.dart';
import 'package:ryde_app/src/core/theme/pallete.dart';

final _inputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(100)),
  borderSide: BorderSide.none,
);

class AppTextFieldTheme {
  static InputDecorationTheme get light => InputDecorationTheme(
    enabledBorder: _inputBorder,
    border: _inputBorder,
    focusedBorder: _inputBorder.copyWith(
      borderSide: BorderSide(color: Pallete.blueColor, width: 1),
    ),
    errorBorder: _inputBorder.copyWith(
      borderSide: BorderSide(color: Colors.red, width: 1),
    ),
    fillColor: Color(0xFFF6F8FA),
    filled: true,
    hintStyle: TextStyle(color: Pallete.hintColor),
    prefixIconColor: Pallete.inactive,
    prefixIconConstraints: BoxConstraints.loose(Size.fromWidth(45)),
    suffixIconConstraints: BoxConstraints.loose(Size.fromWidth(80)),
  );
}
