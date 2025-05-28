import 'package:flutter/material.dart';
import '../colors_Manager.dart';

extension AppColors on ColorScheme {
  // == Light/Dark shared logic == //
  bool get isLight => brightness == Brightness.light;

  Color get btnBackMainColor => isLight
      ? ColorsManager.lighBlueMainBackColor
      : ColorsManager.darkBlueMainBackColor;

  Color get backgroundMain => isLight
      ? ColorsManager.lightBackground
      : ColorsManager.darkBackground;

  Color get textMainWhite => isLight
      ? ColorsManager.lightTextWhite
      : ColorsManager.darkTextBlack;

  Color get textMainBlack => isLight
      ? ColorsManager.darkTextWhite
      : ColorsManager.darkTextBlack;

  Color get hintText => isLight
      ? ColorsManager.lightHintText
      : ColorsManager.darkHintText;

  Color get labelText => isLight
      ? ColorsManager.lightLabelText
      : ColorsManager.darkLabelText;

  Color get elements => isLight
      ? ColorsManager.lightElements
      : ColorsManager.darkElements;

  Color get fields => isLight
      ? ColorsManager.lightFields
      : ColorsManager.darkFields;

  Color get borders => isLight
      ? ColorsManager.lightBorders
      : ColorsManager.darkBorders;

  Color get bubbleMedium => isLight
      ? ColorsManager.lightMediumBubble
      : ColorsManager.darkMediumBubble;

  Color get bubbleSmall => isLight
      ? ColorsManager.lightSmallBubble
      : ColorsManager.darkSmallBubble;

  Color get bubbleLarge => isLight
      ? ColorsManager.lightLargeBubble
      : ColorsManager.darkLargeBubble;

  Color get modeGradient => isLight
      ? ColorsManager.lightModeGradient
      : ColorsManager.darkModeGradient;
}