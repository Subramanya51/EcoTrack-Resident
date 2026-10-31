import 'package:flutter/services.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

class AppHaptics {
  static void lightImpact() {
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      HapticFeedback.lightImpact();
    }
  }

  static void selectionClick() {
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      HapticFeedback.selectionClick();
    }
  }

  static void success() {
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      HapticFeedback.vibrate(); // Basic success vibration
    }
  }

  static void mediumImpact() {
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      HapticFeedback.mediumImpact();
    }
  }

  static void heavyImpact() {
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      HapticFeedback.heavyImpact();
    }
  }
}
