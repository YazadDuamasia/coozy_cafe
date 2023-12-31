import 'package:flutter/material.dart';

class AppColor {
  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF924C00),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFFFDCC4),
    onPrimaryContainer: Color(0xFF2F1500),
    secondary: Color(0xFF96490C),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFFFDBC8),
    onSecondaryContainer: Color(0xFF321200),
    tertiary: Color(0xFF7B5800),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFFFDEA5),
    onTertiaryContainer: Color(0xFF271900),
    error: Color(0xFFBA1A1A),
    errorContainer: Color(0xFFFFDAD6),
    onError: Color(0xFFFFFFFF),
    onErrorContainer: Color(0xFF410002),
    background: Color(0xFFFFFBFF),
    onBackground: Color(0xFF201A17),
    surface: Color(0xFFFFFBFF),
    onSurface: Color(0xFF201A17),
    surfaceVariant: Color(0xFFF3DFD2),
    onSurfaceVariant: Color(0xFF51443B),
    outline: Color(0xFF84746A),
    onInverseSurface: Color(0xFFFAEEE8),
    inverseSurface: Color(0xFF352F2B),
    inversePrimary: Color(0xFFFFB77F),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF924C00),
    outlineVariant: Color(0xFFD6C3B7),
    scrim: Color(0xFF000000),
  );

  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFFFB77F),
    onPrimary: Color(0xFF4E2600),
    primaryContainer: Color(0xFF6F3800),
    onPrimaryContainer: Color(0xFFFFDCC4),
    secondary: Color(0xFFFFB68B),
    onSecondary: Color(0xFF522300),
    secondaryContainer: Color(0xFF753400),
    onSecondaryContainer: Color(0xFFFFDBC8),
    tertiary: Color(0xFFF6BD48),
    onTertiary: Color(0xFF412D00),
    tertiaryContainer: Color(0xFF5D4200),
    onTertiaryContainer: Color(0xFFFFDEA5),
    error: Color(0xFFFFB4AB),
    errorContainer: Color(0xFF93000A),
    onError: Color(0xFF690005),
    onErrorContainer: Color(0xFFFFDAD6),
    background: Color(0xFF201A17),
    onBackground: Color(0xFFECE0DA),
    surface: Color(0xFF201A17),
    onSurface: Color(0xFFECE0DA),
    surfaceVariant: Color(0xFF51443B),
    onSurfaceVariant: Color(0xFFD6C3B7),
    outline: Color(0xFF9F8D82),
    onInverseSurface: Color(0xFF201A17),
    inverseSurface: Color(0xFFECE0DA),
    inversePrimary: Color(0xFF924C00),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFFFFB77F),
    outlineVariant: Color(0xFF51443B),
    scrim: Color(0xFF000000),
  );

  static const Color online = Color(0xFF4BCB1F);

  static const LinearGradient createRoomGradient = LinearGradient(
    colors: [Color(0xFF4958A9), Color(0xFFDEE0FF)],
  );
}
