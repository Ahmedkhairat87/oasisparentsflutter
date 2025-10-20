import 'dart:ui';

abstract class ColorsManager {
  // Light Theme (Enhanced)
  static const Color lighBlueMainBackColor = Color(0xff2279be);
  static const Color lightTextWhite = Color(0xFFFFFFFF);
  static const Color lightTextBlack = Color(0xFF000000);




  static const Color lightBackground = Color(0xFFF8F9FA);    // Lighter neutral
  static const Color lightText = Color(0xFF212529);          // Dark gray
  static const Color lightHintText = Color(0xFF6C757D);      // Meets WCAG
  static const Color lightLabelText = Color(0xFF495057);
  static const Color lightElements = Color(0xFF0D6EFD);      // Vibrant primary
  static const Color lightFields = Color(0xFFE9ECEF);
  static const Color lightBorders = Color(0xFFDEE2E6);
  // bubles
  static const Color lightMediumBubble = Color(0xFFB0CBEF);
  static const Color lightSmallBubble = Color(0xFF85A8D8);   // Different shade
  static const Color lightLargeBubble = Color(0xFF6094DD);
  static const Color lightModeGradient = Color(0xFFE3F2FD);  // Light blue tint

  // Dark Theme (Enhanced)

  static const Color darkBlueMainBackColor = Color(0xff2279be);
  static const Color darkTextWhite = Color(0xFF000000);
  static const Color darkTextBlack = Color(0xFFFFFFFF);


  static const Color darkBackground = Color(0xFF121212);     // True black is harsh
  static const Color darkText = Color(0xFFE1E1E1);           // Soft white
  static const Color darkHintText = Color(0xFF9E9E9E);
  static const Color darkLabelText = Color(0xFFB0B0B0);
  static const Color darkElements = Color(0xFF1976D2);        // Darker primary
  static const Color darkFields = Color(0xFF1E1E1E);
  static const Color darkBorders = Color(0xFF373737);

  // bubles
  static const Color darkMediumBubble = Color(0xFF2D3B50);
  static const Color darkSmallBubble = Color(0xFF3A4D63);
  static const Color darkLargeBubble = Color(0xFF446D99);
  static const Color darkModeGradient = Color(0xFF0A1F3D);   // Deep blue
}