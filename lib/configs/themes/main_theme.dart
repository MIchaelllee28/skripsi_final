import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trainee/configs/themes/main_color.dart';

final ThemeData mainTheme = ThemeData(
  primaryColor: MainColor.primary,
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSwatch(
    accentColor: MainColor.primary,
    cardColor: MainColor.white,
    errorColor: MainColor.danger,
  ),
  iconTheme: IconThemeData(
    color: MainColor.primary,
    size: 24.sp,
  ),
);
