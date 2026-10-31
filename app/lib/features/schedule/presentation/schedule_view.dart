// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// // ignore: deprecated_member_use
// import 'package:flutter_riverpod/legacy.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import '../../../core/haptics.dart';
// import '../data/pickup_provider.dart';

// class ScheduleView extends ConsumerStatefulWidget {
//   const ScheduleView({super.key});

//   @override
//   ConsumerState<ScheduleView> createState() => _ScheduleViewState();
// }

// class _ScheduleViewState extends ConsumerState<ScheduleView> {
//   int selectedIndex = 0;
//   late List<Map<String, dynamic>> days;

//   @override
//   void initState() {
//     super.initState();
//     _generateDays();
//   }

//   void _generateDays() {
//     final now = DateTime.now();
//     days = List.generate(5, (index) {
//       final date = now.add(Duration(days: index));
//       return {
//         'day': DateFormat('E').format(date),
//         'date': DateFormat('d').format(date),
//         'fullDate': date,
//       };
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     final isScheduled = ref.watch(pickupActiveProvider);

//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios_new, color: cs.onSurface, size: 20),
//           onPressed: () {
//             AppHaptics.lightImpact();
//             // Optional: Handle back behavior if deeply nested
//           },
//         ),
//         title: Text(
//           "ZONE 4B",
//           style: GoogleFonts.spaceGrotesk(
//             fontSize: 14,
//             fontWeight: FontWeight.bold,
//             letterSpacing: 2,
//             color: cs.primary,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: isScheduled
//           ? _buildActiveRequestView(cs)
//           : _buildSchedulingForm(cs),
//     );
//   }

//   Widget _buildSchedulingForm(ColorScheme cs) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(24),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Schedule a Pickup",
//             style: GoogleFonts.spaceGrotesk(
//               fontSize: 32,
//               fontWeight: FontWeight.bold,
//               color: cs.primary,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             "Confirm your next automated municipal collection.",
//             style: GoogleFonts.inter(fontSize: 14, color: cs.onSurfaceVariant),
//           ),
//           const SizedBox(height: 48),

//           Text(
//             "SELECT PICKUP DATE",
//             style: GoogleFonts.spaceGrotesk(
//               fontSize: 10,
//               fontWeight: FontWeight.bold,
//               letterSpacing: 2,
//               color: cs.onSurfaceVariant,
//             ),
//           ),
//           const SizedBox(height: 16),
//           SizedBox(
//             height: 100,
//             child: ListView.separated(
//               scrollDirection: Axis.horizontal,
//               itemCount: days.length,
//               separatorBuilder: (_, __) => const SizedBox(width: 12),
//               itemBuilder: (context, index) {
//                 final isSelected = selectedIndex == index;
//                 return GestureDetector(
//                   onTap: () {
//                     AppHaptics.selectionClick();
//                     setState(() => selectedIndex = index);
//                   },
//                   child: Container(
//                     width: 72,
//                     decoration: BoxDecoration(
//                       color: isSelected ? cs.primary : cs.surfaceContainerLow,
//                       borderRadius: BorderRadius.circular(20),
//                       border: isSelected
//                           ? null
//                           : Border.all(
//                               color: cs.outlineVariant.withOpacity(0.2),
//                             ),
//                       boxShadow: isSelected
//                           ? [
//                               BoxShadow(
//                                 color: cs.primary.withOpacity(0.3),
//                                 blurRadius: 15,
//                                 spreadRadius: 2,
//                               ),
//                             ]
//                           : null,
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           days[index]['day'].toUpperCase(),
//                           style: GoogleFonts.inter(
//                             fontSize: 10,
//                             fontWeight: FontWeight.bold,
//                             color: isSelected
//                                 ? cs.onPrimary
//                                 : cs.onSurfaceVariant,
//                           ),
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           days[index]['date'],
//                           style: GoogleFonts.spaceGrotesk(
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                             color: isSelected ? cs.onPrimary : cs.onSurface,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),

//           const SizedBox(height: 32),
//           Container(
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: cs.surfaceContainer.withOpacity(0.5),
//               borderRadius: BorderRadius.circular(20),
//               border: Border.all(color: cs.outlineVariant.withOpacity(0.1)),
//             ),
//             child: Row(
//               children: [
//                 Icon(Icons.schedule, color: cs.primary),
//                 const SizedBox(width: 16),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "FIXED SCHEDULE",
//                       style: GoogleFonts.spaceGrotesk(
//                         fontSize: 8,
//                         fontWeight: FontWeight.bold,
//                         letterSpacing: 1.5,
//                         color: cs.onSurfaceVariant,
//                       ),
//                     ),
//                     Text(
//                       "07:00 AM - 10:00 AM",
//                       style: GoogleFonts.inter(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: cs.onSurface,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const Spacer(),
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 10,
//                     vertical: 4,
//                   ),
//                   decoration: BoxDecoration(
//                     color: cs.primary.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Text(
//                     "MUNICIPAL",
//                     style: GoogleFonts.inter(
//                       fontSize: 8,
//                       fontWeight: FontWeight.bold,
//                       color: cs.primary,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(height: 48),
//           Center(
//             child: Column(
//               children: [
//                 Container(
//                   width: 120,
//                   height: 120,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: cs.primary.withOpacity(0.05),
//                   ),
//                   child: Icon(Icons.eco, size: 64, color: cs.primary),
//                 ),
//                 const SizedBox(height: 16),
//                 Text(
//                   "Your scheduled pickup supports the\n4B community eco-network.",
//                   textAlign: TextAlign.center,
//                   style: GoogleFonts.inter(
//                     fontSize: 12,
//                     color: cs.onSurfaceVariant,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 48),

//           ElevatedButton(
//             onPressed: () {
//               AppHaptics.success();
//               // Replace the route transition with inline state change
//               ref.read(pickupActiveProvider.notifier).state = true;
//             },
//             style: ElevatedButton.styleFrom(
//               minimumSize: const Size(double.infinity, 64),
//             ),
//             child: const Text("CONFIRM REQUEST"),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildActiveRequestView(ColorScheme cs) {
//     final selectedDate = days[selectedIndex]['fullDate'] as DateTime;
//     final isToday =
//         DateFormat('yyyy-MM-dd').format(selectedDate) ==
//         DateFormat('yyyy-MM-dd').format(DateTime.now());
//     final isTomorrow =
//         DateFormat('yyyy-MM-dd').format(selectedDate) ==
//         DateFormat(
//           'yyyy-MM-dd',
//         ).format(DateTime.now().add(const Duration(days: 1)));

//     String relativeDate = DateFormat('MMMM d').format(selectedDate);
//     if (isToday) relativeDate = "Today";
//     if (isTomorrow) relativeDate = "Tomorrow";

//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(24),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           const SizedBox(height: 24),
//           // Success Indicator
//           Center(
//             child: Container(
//               width: 120,
//               height: 120,
//               decoration: BoxDecoration(
//                 color: cs.primary,
//                 shape: BoxShape.circle,
//                 boxShadow: [
//                   BoxShadow(
//                     color: cs.primary.withOpacity(0.2),
//                     blurRadius: 40,
//                     spreadRadius: 10,
//                   ),
//                 ],
//               ),
//               child: Icon(Icons.check, size: 64, color: cs.onPrimary),
//             ),
//           ),
//           const SizedBox(height: 40),

//           Text(
//             "Pickup Requested\nSuccessfully!",
//             textAlign: TextAlign.center,
//             style: GoogleFonts.spaceGrotesk(
//               fontSize: 28,
//               fontWeight: FontWeight.bold,
//               color: cs.onSurface,
//             ),
//           ),
//           const SizedBox(height: 16),
//           RichText(
//             textAlign: TextAlign.center,
//             text: TextSpan(
//               style: GoogleFonts.inter(
//                 fontSize: 16,
//                 color: cs.onSurfaceVariant,
//               ),
//               children: [
//                 TextSpan(
//                   text: "Your collector will arrive $relativeDate between ",
//                 ),
//                 TextSpan(
//                   text: "7 AM - 10 AM",
//                   style: TextStyle(
//                     color: cs.primary,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 48),

//           // Info Card
//           Container(
//             padding: const EdgeInsets.all(24),
//             decoration: BoxDecoration(
//               color: cs.surfaceContainerLow,
//               borderRadius: BorderRadius.circular(24),
//               border: Border.all(color: cs.outlineVariant.withOpacity(0.1)),
//             ),
//             child: Column(
//               children: [
//                 _InfoRow(
//                   label: "REQUEST ID",
//                   value: "#ET-${DateFormat('Hmm').format(DateTime.now())}-4B",
//                 ),
//                 Divider(height: 32, color: cs.outlineVariant, thickness: 0.5),
//                 _InfoRow(
//                   label: "COLLECTION POINT",
//                   value: "Building C, Entrance 4",
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(height: 48),

//           // Action Buttons: "PICKED UP" and "NOT PICKED UP"
//           Row(
//             children: [
//               Expanded(
//                 child: OutlinedButton(
//                   onPressed: () {
//                     AppHaptics.lightImpact();
//                     ref.read(pickupActiveProvider.notifier).state = false;
//                   },
//                   style: OutlinedButton.styleFrom(
//                     side: BorderSide(color: cs.error.withOpacity(0.5)),
//                     foregroundColor: cs.error,
//                     minimumSize: const Size(double.infinity, 56),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                   ),
//                   child: const Text(
//                     "NOT PICKED UP",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: ElevatedButton(
//                   onPressed: () {
//                     AppHaptics.success();
//                     ref.read(pickupActiveProvider.notifier).state = false;
//                   },
//                   style: ElevatedButton.styleFrom(
//                     minimumSize: const Size(double.infinity, 56),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                   ),
//                   child: const Text(
//                     "PICKED UP",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 32),
//         ],
//       ),
//     );
//   }
// }

// class _InfoRow extends StatelessWidget {
//   final String label;
//   final String value;

//   const _InfoRow({required this.label, required this.value});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           label,
//           style: GoogleFonts.spaceGrotesk(
//             fontSize: 10,
//             fontWeight: FontWeight.bold,
//             letterSpacing: 1.5,
//             color: cs.onSurfaceVariant,
//           ),
//         ),
//         Text(
//           value,
//           style: GoogleFonts.inter(
//             fontSize: 14,
//             fontWeight: FontWeight.bold,
//             color: cs.onSurface,
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: deprecated_member_use
import 'package:flutter_riverpod/legacy.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';

import '../../../core/haptics.dart';
import '../../../core/app_theme.dart';
import '../../../shared/widgets/resident_app_bar.dart';
import '../data/pickup_provider.dart';
import '../../../services/auth_service.dart';

class ScheduleView extends ConsumerStatefulWidget {
  const ScheduleView({super.key});

  @override
  ConsumerState<ScheduleView> createState() => _ScheduleViewState();
}

class _ScheduleViewState extends ConsumerState<ScheduleView> {
  int selectedIndex = 0;
  late List<Map<String, dynamic>> days;

  @override
  void initState() {
    super.initState();
    _generateDays();
  }

  void _generateDays() {
    final now = DateTime.now();
    days = List.generate(5, (index) {
      final date = now.add(Duration(days: index));
      return {
        'day': DateFormat('E').format(date),
        'date': DateFormat('d').format(date),
        'fullDate': date,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isScheduled = ref.watch(pickupActiveProvider);

    return Scaffold(
      extendBodyBehindAppBar: isScheduled,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: ResidentAppBar(
        showAvatarOnLeft: false,
        leading: null,
      ),
      body: PopScope(
        canPop: !isScheduled,
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop) {
            // Optional: Show a snackbar or haptic feedback
            AppHaptics.heavyImpact();
          }
        },
        child: isScheduled ? _buildActiveRequestView(cs) : _buildSchedulingForm(cs),
      ),
    );
  }

  Widget _buildSchedulingForm(ColorScheme cs) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Schedule a Pickup",
            style: GoogleFonts.spaceGrotesk(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: cs.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Confirm your next automated municipal collection.",
            style: GoogleFonts.inter(fontSize: 14, color: cs.onSurfaceVariant),
          ),
          const SizedBox(height: 48),

          Text(
            "SELECT PICKUP DATE",
            style: GoogleFonts.spaceGrotesk(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              color: cs.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),

          SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: days.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final isSelected = selectedIndex == index;
                return GestureDetector(
                  onTap: () {
                    AppHaptics.selectionClick();
                    setState(() => selectedIndex = index);
                  },
                  child: Container(
                    width: 72,
                    decoration: BoxDecoration(
                      color: isSelected ? cs.primary : cs.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(20),
                      border: isSelected
                          ? null
                          : Border.all(
                              color: cs.outlineVariant.withOpacity(0.2),
                            ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: cs.primary.withOpacity(0.3),
                                blurRadius: 15,
                                spreadRadius: 2,
                              ),
                            ]
                          : null,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          days[index]['day'].toUpperCase(),
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: isSelected
                                ? cs.onPrimary
                                : cs.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          days[index]['date'],
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? cs.onPrimary : cs.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 48),

          ElevatedButton(
            onPressed: () async {
              AppHaptics.success();

              final token = await AuthService.getToken();
              if (token == null) return;

              final selectedDate = days[selectedIndex]['fullDate'] as DateTime;
              final formattedDate = DateFormat(
                'yyyy-MM-dd',
              ).format(selectedDate);

              final position = await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.high,
              );

              final response = await AuthService.createPickup(
                token: token,
                requestDate: formattedDate,
                latitude: position.latitude,
                longitude: position.longitude,
              );

              if (response["success"]) {
                await AuthService.savePickupId(response["pickupId"]);
                ref.read(pickupActiveProvider.notifier).state = true;
              }
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 64),
            ),
            child: const Text("CONFIRM REQUEST"),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveRequestView(ColorScheme cs) {
    final selectedDate = days[selectedIndex]['fullDate'] as DateTime;
    final isToday =
        DateFormat('yyyy-MM-dd').format(selectedDate) ==
        DateFormat('yyyy-MM-dd').format(DateTime.now());
    final isTomorrow =
        DateFormat('yyyy-MM-dd').format(selectedDate) ==
        DateFormat(
          'yyyy-MM-dd',
        ).format(DateTime.now().add(const Duration(days: 1)));

    String relativeDate = DateFormat('MMMM d').format(selectedDate);
    if (isToday) relativeDate = "Today";
    if (isTomorrow) relativeDate = "Tomorrow";

    return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppTheme.surfaceBase,
              const Color(0xFF031A12),
              const Color(0xFF010E0A),
            ],
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background "Forest" feel
            Positioned.fill(
              child: Opacity(
                opacity: 0.1,
                child: Image.network(
                  "https://images.unsplash.com/photo-1441974231531-c6227db76b6e?q=80&w=2560&auto=format&fit=crop",
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(),
                ),
              ),
            ),
            
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 10),
                  
                  // Success Indicator
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppTheme.primaryNeon.withOpacity(0.05),
                            border: Border.all(
                              color: AppTheme.primaryNeon.withOpacity(0.1),
                              width: 1,
                            ),
                          ),
                        ),
                        Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppTheme.primaryNeon.withOpacity(0.1),
                          ),
                        ),
                        Container(
                          width: 85,
                          height: 85,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppTheme.primaryNeon,
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.primaryNeon,
                                blurRadius: 25,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: const Icon(Icons.check_rounded, size: 50, color: AppTheme.onPrimary),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 40),

                  Text(
                    "Pickup Requested\nSuccessfully!",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.1,
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        color: AppTheme.onSurfaceVariant.withOpacity(0.8),
                      ),
                      children: [
                        TextSpan(text: "Your collector will arrive $relativeDate between "),
                        TextSpan(
                          text: "7 AM - 10 AM",
                          style: const TextStyle(
                            color: AppTheme.primaryNeon,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 40),


                  const SizedBox(height: 120),
                ],
              ),
            ),

            // Action Buttons pinned to bottom
            Positioned(
              bottom: 40,
              left: 24,
              right: 24,
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () async {
                        AppHaptics.lightImpact();

                        final token = await AuthService.getToken();
                        final pickupId = await AuthService.getPickupId();

                        if (token == null || pickupId == null) return;

                        final success = await AuthService.updatePickupStatus(
                          token: token,
                          pickupId: pickupId,
                          status: "FAILED",
                        );

                        if (success) {
                          ref.read(pickupActiveProvider.notifier).state = false;
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFFF5252), width: 1),
                        minimumSize: const Size(double.infinity, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        "NOT PICKED UP",
                        style: GoogleFonts.spaceGrotesk(
                          color: const Color(0xFFFF5252),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        AppHaptics.success();

                        final token = await AuthService.getToken();
                        final pickupId = await AuthService.getPickupId();

                        if (token == null || pickupId == null) return;

                        final success = await AuthService.updatePickupStatus(
                          token: token,
                          pickupId: pickupId,
                          status: "COMPLETED",
                          points: 10,
                        );

                        if (success) {
                          ref.read(pickupActiveProvider.notifier).state = false;
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryNeon,
                        foregroundColor: AppTheme.onPrimary,
                        minimumSize: const Size(double.infinity, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        "PICKED UP",
                        style: GoogleFonts.spaceGrotesk(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
  }



}
