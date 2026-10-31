import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// StateProvider is moved to legacy in Riverpod 3.x
// ignore: deprecated_member_use
import 'package:flutter_riverpod/legacy.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/haptics.dart';
import '../../dashboard/presentation/dashboard_view.dart';
import '../../schedule/presentation/schedule_view.dart';
import '../../rewards/presentation/rewards_view.dart';
import '../../profile/presentation/profile_view.dart';
import '../../schedule/data/pickup_provider.dart';
import '../../../shared/widgets/pill_nav_bar.dart';

// Navigation State Provider (Legacy API)
final navigationProvider = StateProvider<int>((ref) => 0);

class MainScaffold extends ConsumerStatefulWidget {
  const MainScaffold({super.key});

  @override
  ConsumerState<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends ConsumerState<MainScaffold> {
  // Global Key to maintain RotatingLogo state across page switches
  // Moving this into the State class fixes the "Multiple widgets used the same GlobalKey" error
  // occurring during theme transitions (ThemeTransitionWrapper builds the tree twice).
  final rotatingLogoKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(navigationProvider);
    final cs = Theme.of(context).colorScheme;
    final isPickupActive = ref.watch(pickupActiveProvider);

    final List<Widget> pages = [
      const DashboardView(),
      const ScheduleView(),
      const RewardsView(),
      const ProfileView(),
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: isPickupActive ? 0 : 80), // Hide space for PillNavigationBar if active
            child: IndexedStack(
              index: selectedIndex,
              children: pages,
            ),
          ),
          // Floating Action Button - Positioned exactly above Rewards/Profile area
          if (selectedIndex == 0)
            Positioned(
              bottom: 95,
              right: 24,
              child: FloatingActionButton.extended(
                onPressed: () {
                  AppHaptics.mediumImpact();
                  Navigator.pushNamed(context, '/schedule');
                },
                backgroundColor: cs.primary,
                foregroundColor: cs.onPrimary,
                icon: const Icon(Icons.add),
                label: Text(
                  "SCHEDULE PICKUP",
                  style: GoogleFonts.spaceGrotesk(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
            
          // New Pill Navigation Bar - Hidden when pickup is active
          if (!isPickupActive)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: PillNavigationBar(
                logoKey: rotatingLogoKey,
                currentIndex: selectedIndex,
                onLogoTap: () {
                  // Cycle through 0 -> 1 -> 2 -> 3 -> 0
                  final nextIndex = (selectedIndex + 1) % 4;
                  ref.read(navigationProvider.notifier).state = nextIndex;
                },
                items: const [
                  PillNavItemData(label: "HOME", icon: Icons.home_max),
                  PillNavItemData(label: "REQUESTS", icon: Icons.calendar_today),
                  PillNavItemData(label: "REWARDS", icon: Icons.military_tech),
                  PillNavItemData(label: "PROFILE", icon: Icons.person),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
