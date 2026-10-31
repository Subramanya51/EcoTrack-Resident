import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/app_theme.dart';
import 'features/splash/presentation/splash_view.dart';
import 'features/auth/presentation/login_view.dart';
import 'features/auth/presentation/registration_view.dart';

import 'features/main/presentation/main_scaffold.dart';
import 'features/schedule/presentation/schedule_view.dart';

import 'features/onboarding/presentation/onboarding_view.dart';
import 'features/onboarding/presentation/location_permission_view.dart';

import 'features/dashboard/presentation/notifications_view.dart';
import 'shared/widgets/theme_transition_wrapper.dart';
import 'core/theme_provider.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      title: 'Eco Connect',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      builder: (context, child) {
        return ThemeTransitionWrapper(child: child!);
      },
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashView(),
        '/onboarding': (context) => const OnboardingView(),
        '/location-permission': (context) => const LocationPermissionView(),
        '/login': (context) => const LoginView(),
        '/register': (context) => const RegistrationView(),
        '/home': (context) => const MainScaffold(),
        '/schedule': (context) => const ScheduleView(),
        '/notifications': (context) => const NotificationsView(),
      },
    );
  }
}
