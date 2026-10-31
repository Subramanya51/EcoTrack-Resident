// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../../../core/haptics.dart';
// import '../../../shared/widgets/animated_theme_toggler.dart';

// class ProfileView extends StatelessWidget {
//   const ProfileView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: Text(
//           "ZONE 4B",
//           style: GoogleFonts.spaceGrotesk(
//             fontSize: 14,
//             fontWeight: FontWeight.bold,
//             letterSpacing: 2,
//             color: cs.primary,
//           ),
//         ),
//         actions: [
//           const AnimatedThemeToggler(),
//           IconButton(
//             icon: Icon(Icons.notifications_none, color: cs.onSurfaceVariant),
//             onPressed: () {
//               AppHaptics.lightImpact();
//               Navigator.pushNamed(context, '/notifications');
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           children: [
//             // Profile Header
//             Center(
//               child: Column(
//                 children: [
//                   Stack(
//                     children: [
//                       Container(
//                         width: 120,
//                         height: 120,
//                         padding: const EdgeInsets.all(4),
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           border: Border.all(color: cs.primary.withOpacity(0.3), width: 2),
//                         ),
//                         child: CircleAvatar(
//                           radius: 56,
//                           backgroundColor: cs.surfaceContainer,
//                           child: Icon(Icons.person, size: 64, color: cs.onSurfaceVariant),
//                         ),
//                       ),
//                       Positioned(
//                         bottom: 0,
//                         right: 0,
//                         child: GestureDetector(
//                           onTap: () => AppHaptics.mediumImpact(),
//                           child: Container(
//                             padding: const EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                               color: cs.primary,
//                               shape: BoxShape.circle,
//                             ),
//                             child: Icon(Icons.edit, size: 20, color: cs.onPrimary),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 24),
//                   Text(
//                     "Priya S.",
//                     style: GoogleFonts.spaceGrotesk(
//                       fontSize: 32,
//                       fontWeight: FontWeight.bold,
//                       color: cs.onSurface,
//                     ),
//                   ),
//                   Text(
//                     "priya.s@zone4b.resident",
//                     style: GoogleFonts.inter(
//                       fontSize: 14,
//                       color: cs.onSurfaceVariant,
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
//                     decoration: BoxDecoration(
//                       color: cs.primary.withOpacity(0.12),
//                       borderRadius: BorderRadius.circular(20),
//                       border: Border.all(color: cs.primary.withOpacity(0.3)),
//                     ),
//                     child: Text(
//                       "ZONE 4B RESIDENT",
//                       style: GoogleFonts.spaceGrotesk(
//                         fontSize: 10,
//                         fontWeight: FontWeight.bold,
//                         letterSpacing: 2,
//                         color: cs.primary,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 48),

//             // Stats Bento Grid
//             Row(
//               children: [
//                 _StatCard(label: "Total Pickups", value: "142"),
//                 const SizedBox(width: 12),
//                 _StatCard(label: "EcoPoints", value: "2.8k"),
//                 const SizedBox(width: 12),
//                 _StatCard(label: "Tier", value: "Elite"),
//               ],
//             ),

//             const SizedBox(height: 48),

//             // Account Preferences
//             Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 "ACCOUNT PREFERENCES",
//                 style: GoogleFonts.spaceGrotesk(
//                   fontSize: 10,
//                   fontWeight: FontWeight.bold,
//                   letterSpacing: 2,
//                   color: cs.onSurfaceVariant,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//             Container(
//               decoration: BoxDecoration(
//                 color: cs.surfaceContainerLow,
//                 borderRadius: BorderRadius.circular(24),
//                 border: Border.all(color: cs.outlineVariant.withOpacity(0.5)),
//               ),
//               child: Column(
//                 children: [
//                   _SettingsItem(
//                     icon: Icons.lock_outline,
//                     label: "Change Password",
//                     onTap: () => AppHaptics.lightImpact(),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 32),

//             ElevatedButton(
//               onPressed: () {
//                 AppHaptics.mediumImpact();
//                 Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Theme.of(context).colorScheme.error.withOpacity(0.1),
//                 foregroundColor: Theme.of(context).colorScheme.error,
//                 side: BorderSide(color: Theme.of(context).colorScheme.error.withOpacity(0.3)),
//                 minimumSize: const Size(double.infinity, 64),
//               ),
//               child: const Text("LOGOUT"),
//             ),
//             const SizedBox(height: 100),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _StatCard extends StatelessWidget {
//   final String label;
//   final String value;

//   const _StatCard({required this.label, required this.value});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return Expanded(
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
//         decoration: BoxDecoration(
//           color: cs.surfaceContainer,
//           borderRadius: BorderRadius.circular(20),
//           border: Border.all(color: cs.primary.withOpacity(0.15)),
//         ),
//         child: Column(
//           children: [
//             Text(
//               label.toUpperCase(),
//               textAlign: TextAlign.center,
//               style: GoogleFonts.spaceGrotesk(
//                 fontSize: 8,
//                 fontWeight: FontWeight.bold,
//                 letterSpacing: 1,
//                 color: cs.onSurfaceVariant,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               value,
//               style: GoogleFonts.spaceGrotesk(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: cs.primary,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _SettingsItem extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final VoidCallback onTap;

//   const _SettingsItem({required this.icon, required this.label, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(24),
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 color: cs.primary.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Icon(icon, color: cs.primary, size: 20),
//             ),
//             const SizedBox(width: 16),
//             Text(
//               label,
//               style: GoogleFonts.inter(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//                 color: cs.onSurface,
//               ),
//             ),
//             const Spacer(),
//             Icon(Icons.chevron_right, color: cs.onSurfaceVariant.withOpacity(0.7)),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/haptics.dart';
import '../../../core/app_theme.dart';
import '../../../shared/widgets/resident_app_bar.dart';
import '../../../shared/widgets/animated_theme_toggler.dart';
import '../../../services/auth_service.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  String userName = "Loading...";
  String ecoPoints = "0";
  String totalPickups = "0";
  String lastPickupDate = "";

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final token = await AuthService.getToken();
    if (token == null) return;

    final response = await AuthService.getUserProfile(token);

    if (response["success"]) {
      final data = response["data"];

      setState(() {
        userName = data["userName"] ?? "";
        ecoPoints = data["ecoPoints"].toString();
        totalPickups = data["totalPickups"].toString();
        lastPickupDate = data["lastPickupDate"] ?? "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: ResidentAppBar(
        showAvatarOnLeft: false,
        actions: [
          const AnimatedThemeToggler(),
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {
              AppHaptics.lightImpact();
              Navigator.pushNamed(context, '/notifications');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Profile Header
            Center(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: cs.primary.withOpacity(0.3),
                            width: 2,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 56,
                          backgroundColor: cs.surfaceContainer,
                          child: Icon(
                            Icons.person,
                            size: 64,
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () => AppHaptics.mediumImpact(),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: cs.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.edit,
                              size: 20,
                              color: cs.onPrimary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // ✅ UPDATED NAME
                  Text(
                    userName,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: cs.onSurface,
                    ),
                  ),

                  Text(
                    "resident@zone4b",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: cs.onSurfaceVariant,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: cs.primary.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: cs.primary.withOpacity(0.3)),
                    ),
                    child: Text(
                      "ZONE 4B RESIDENT",
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        color: cs.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 48),

            // Stats Bento Grid
            Row(
              children: [
                _StatCard(label: "Total Pickups", value: totalPickups),
                const SizedBox(width: 12),
                _StatCard(label: "EcoPoints", value: ecoPoints),
                const SizedBox(width: 12),
                _StatCard(label: "Last", value: lastPickupDate),
              ],
            ),

            const SizedBox(height: 48),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "ACCOUNT PREFERENCES",
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: cs.onSurfaceVariant,
                ),
              ),
            ),

            const SizedBox(height: 32),

            ElevatedButton(
              onPressed: () async {
                AppHaptics.mediumImpact();
                await AuthService.logout();
                if (!mounted) return;
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(
                  context,
                ).colorScheme.error.withOpacity(0.1),
                foregroundColor: Theme.of(context).colorScheme.error,
                minimumSize: const Size(double.infinity, 64),
              ),
              child: const Text("LOGOUT"),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;

  const _StatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        decoration: BoxDecoration(
          color: cs.surfaceContainer,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: cs.primary.withOpacity(0.15)),
        ),
        child: Column(
          children: [
            Text(
              label.toUpperCase(),
              textAlign: TextAlign.center,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 8,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                color: cs.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: cs.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SettingsItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: cs.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: cs.primary, size: 20),
            ),
            const SizedBox(width: 16),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: cs.onSurface,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.chevron_right,
              color: cs.onSurfaceVariant.withOpacity(0.7),
            ),
          ],
        ),
      ),
    );
  }
}
