// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../core/theme_provider.dart';
// import '../../core/app_theme.dart';
// import 'circular_reveal_clipper.dart';

// class ThemeTransitionWrapper extends ConsumerStatefulWidget {
//   final Widget child;

//   const ThemeTransitionWrapper({super.key, required this.child});

//   @override
//   ConsumerState<ThemeTransitionWrapper> createState() => _ThemeTransitionWrapperState();
// }

// class _ThemeTransitionWrapperState extends ConsumerState<ThemeTransitionWrapper> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   ThemeMode? _oldThemeMode;
//   ThemeMode? _currentThemeMode;
//   bool _isAnimating = false;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//           vsync: this,
//           duration: const Duration(milliseconds: 1000),
//         )..addStatusListener((status) {
//           if (status == AnimationStatus.completed) {
//             setState(() {
//               _isAnimating = false;
//               _oldThemeMode = _currentThemeMode;
//             });
//           }
//         });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final themeMode = ref.watch(themeProvider);

//     if (_currentThemeMode == null) {
//       _currentThemeMode = themeMode;
//       _oldThemeMode = themeMode;
//     } else if (_currentThemeMode != themeMode) {
//       // Theme changed!
//       _oldThemeMode = _currentThemeMode;
//       _currentThemeMode = themeMode;
//       _isAnimating = true;
//       _controller.forward(from: 0.0);
//     }

//     // We use two static Theme Data objects for the transition
//     final oldThemeData = _oldThemeMode == ThemeMode.light ? AppTheme.lightTheme : AppTheme.darkTheme;
//     final newThemeData = _currentThemeMode == ThemeMode.light ? AppTheme.lightTheme : AppTheme.darkTheme;

//     return Stack(
//       children: [
//         // Background - the "Old" theme
//         Theme(
//           data: oldThemeData,
//           child: widget.child,
//         ),

//         // Foreground - the "New" theme with Clipper
//         if (_isAnimating)
//           AnimatedBuilder(
//             animation: _controller,
//             builder: (context, child) {
//               return ClipPath(
//                 clipper: CircularRevealClipper(
//                   fraction: _controller.value,
//                   // Toggler is roughly at (ScreenWidth - 40, 60) for Profile view
//                   center: Offset(MediaQuery.of(context).size.width - 40, 60),
//                 ),
//                 child: Theme(
//                   data: newThemeData,
//                   child: widget.child,
//                 ),
//               );
//             },
//           )
//         else
//           // If not animating, just show the new theme normally
//           Theme(
//             data: newThemeData,
//             child: widget.child,
//           ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme_provider.dart';
import '../../core/app_theme.dart';
import 'circular_reveal_clipper.dart';

class ThemeTransitionWrapper extends ConsumerStatefulWidget {
  final Widget child;

  const ThemeTransitionWrapper({super.key, required this.child});

  @override
  ConsumerState<ThemeTransitionWrapper> createState() =>
      _ThemeTransitionWrapperState();
}

class _ThemeTransitionWrapperState extends ConsumerState<ThemeTransitionWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  ThemeMode? _oldThemeMode;
  ThemeMode? _currentThemeMode;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 1000),
        )..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            setState(() {
              _isAnimating = false;
              _oldThemeMode = _currentThemeMode;
            });
          }
        });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeProvider);

    if (_currentThemeMode == null) {
      _currentThemeMode = themeMode;
      _oldThemeMode = themeMode;
    } else if (_currentThemeMode != themeMode) {
      _oldThemeMode = _currentThemeMode;
      _currentThemeMode = themeMode;
      _isAnimating = true;
      _controller.forward(from: 0.0);
    }

    final oldThemeData = _oldThemeMode == ThemeMode.light
        ? AppTheme.lightTheme
        : AppTheme.darkTheme;

    final newThemeData = _currentThemeMode == ThemeMode.light
        ? AppTheme.lightTheme
        : AppTheme.darkTheme;

    return Stack(
      children: [
        // OLD THEME
        Theme(
          data: oldThemeData,
          child: Builder(builder: (context) => widget.child),
        ),

        // NEW THEME (ANIMATION)
        if (_isAnimating)
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return ClipPath(
                clipper: CircularRevealClipper(
                  fraction: _controller.value,
                  center: Offset(MediaQuery.of(context).size.width - 40, 60),
                ),
                child: Theme(
                  data: newThemeData,
                  child: Builder(builder: (context) => widget.child),
                ),
              );
            },
          )
        else
          // FINAL STATE
          Theme(
            data: newThemeData,
            child: Builder(builder: (context) => widget.child),
          ),
      ],
    );
  }
}
