import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/services/auth_service.dart';
import '../../../core/haptics.dart';
import '../../../core/app_theme.dart';
import '../../../shared/widgets/resident_app_bar.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({super.key});

  @override
  ConsumerState<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {

  bool isLoading = true;

  String userName = "";
  int ecoPoints = 0;
  int totalPickups = 0;
  String lastPickupDate = "";
  bool isPickupActive = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadDashboard();
  }

  Future<void> loadDashboard() async {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is String) {
      userName = args;
    } else {
      userName = await AuthService.getUsernameFromToken() ?? "User";
    }

    final token = await AuthService.getToken();

    if (token == null) {
      Navigator.pushReplacementNamed(context, '/login');
      return;
    }

    final profileRes = await AuthService.getUserProfile(token);
    final pickupRes = await AuthService.getActivePickup(token);

    if (profileRes["success"]) {
      final data = profileRes["data"];
      ecoPoints = data["ecoPoints"] ?? 0;
      totalPickups = data["totalPickups"] ?? 0;
      lastPickupDate = data["lastPickupDate"] ?? "";
    }

    if (pickupRes["success"]) {
      isPickupActive = pickupRes["isActive"];
    }

    if (mounted) {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: ResidentAppBar(
        showAvatarOnLeft: true,
        title: userName.toUpperCase(),
        actions: [
          IconButton(
            onPressed: () {
              AppHaptics.lightImpact();
              Navigator.pushNamed(context, '/notifications');
            },
            icon: Stack(
              children: [
                const Icon(Icons.notifications_outlined, color: Colors.white),
                Positioned(
                  right: 4,
                  top: 4,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppTheme.primaryNeon,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            isPickupActive ? const _StatusCard() : const _NoActivityCard(),

            const SizedBox(height: 32),

            _PointsCard(ecoPoints: ecoPoints),

            const SizedBox(height: 16),

            _LastRequestCard(date: lastPickupDate),

            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }
}

class _PointsCard extends StatelessWidget {
  final int ecoPoints;

  const _PointsCard({required this.ecoPoints});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: cs.primary.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "ECO POINTS",
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: cs.onSurfaceVariant,
                ),
              ),
              Icon(Icons.military_tech, color: cs.primary),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "$ecoPoints",
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: cs.onSurface,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8, left: 4),
                child: Icon(Icons.bolt, color: cs.primary, size: 24),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: ecoPoints / 100,
              backgroundColor: cs.surfaceContainerHighest,
              color: cs.primary,
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$ecoPoints pts earned",
                style: GoogleFonts.inter(
                  fontSize: 10,
                  color: cs.onSurfaceVariant,
                ),
              ),
              Text(
                "TOTAL $ecoPoints",
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: cs.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LastRequestCard extends StatelessWidget {
  final String date;

  const _LastRequestCard({required this.date});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: cs.outlineVariant.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "MY LAST REQUEST",
            style: GoogleFonts.spaceGrotesk(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              color: cs.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: cs.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(Icons.recycling, color: cs.primary, size: 32),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Collected on $date",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: cs.onSurface,
                    ),
                  ),
                  Text(
                    "Completed",
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NoActivityCard extends StatelessWidget {
  const _NoActivityCard();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: cs.outlineVariant.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: cs.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.eco_outlined, size: 48, color: cs.primary),
          ),
          const SizedBox(height: 24),
          Text(
            "NO ACTIVE ACTIVITY",
            style: GoogleFonts.spaceGrotesk(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              color: cs.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Your ecosystem is currently at rest. Schedule a new pickup to start tracking.",
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(fontSize: 14, color: cs.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: cs.primary.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "CURRENT STATUS",
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Collector is on the way",
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: cs.onSurface,
                    ),
                  ),
                ],
              ),
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: cs.primary, width: 2),
                ),
                child: Icon(Icons.local_shipping, color: cs.primary),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: const [
              _StepIndicator(isActive: true, label: "Requested"),
              _StepLine(isActive: true),
              _StepIndicator(isActive: true, label: "Assigned"),
              _StepLine(isActive: true),
              _StepIndicator(
                isActive: true,
                isCurrent: true,
                label: "En Route",
              ),
              _StepLine(isActive: false),
              _StepIndicator(isActive: false, label: "Arrived"),
            ],
          ),
        ],
      ),
    );
  }
}

class _StepIndicator extends StatelessWidget {
  final bool isActive;
  final bool isCurrent;
  final String label;

  const _StepIndicator({
    required this.isActive,
    this.isCurrent = false,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      children: [
        Container(
          width: isCurrent ? 16 : 10,
          height: isCurrent ? 16 : 10,
          decoration: BoxDecoration(
            color: isActive ? cs.primary : cs.outlineVariant.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label.toUpperCase(),
          style: TextStyle(
            fontSize: 8,
            fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
            color: isActive ? cs.primary : cs.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _StepLine extends StatelessWidget {
  final bool isActive;

  const _StepLine({required this.isActive});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Expanded(
      child: Container(
        height: 1,
        margin: const EdgeInsets.symmetric(horizontal: 8).copyWith(bottom: 16),
        color: isActive ? cs.primary : cs.outlineVariant.withOpacity(0.5),
      ),
    );
  }
}
