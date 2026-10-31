import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../core/haptics.dart';

class LocationPermissionView extends StatefulWidget {
  const LocationPermissionView({super.key});

  @override
  State<LocationPermissionView> createState() => _LocationPermissionViewState();
}

class _LocationPermissionViewState extends State<LocationPermissionView>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  // ✅ REAL LOCATION FUNCTION
  Future<Position?> getUserLocation() async {
    var status = await Permission.location.request();

    if (status.isDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Location permission denied")),
      );
      return null;
    }

    if (status.isPermanentlyDenied) {
      await openAppSettings();
      return null;
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: -50,
            left: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: cs.primary.withOpacity(0.03),
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: Column(
                children: [
                  const Spacer(),

                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ScaleTransition(
                          scale: _pulseAnimation,
                          child: Container(
                            width: 160,
                            height: 160,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: cs.primary.withOpacity(0.05),
                            ),
                          ),
                        ),
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: cs.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.location_on,
                            size: 48,
                            color: cs.onPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 60),

                  Text(
                    "ALLOW LOCATION ACCESS",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    "We use your location to match you with the nearest collector and send accurate proximity alerts.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(fontSize: 16),
                  ),

                  const Spacer(),

                  // ✅ UPDATED BUTTON
                  ElevatedButton(
                    onPressed: () async {
                      AppHaptics.mediumImpact();

                      final position = await getUserLocation();

                      if (position != null) {
                        print("LAT: ${position.latitude}");
                        print("LNG: ${position.longitude}");

                        Navigator.pushReplacementNamed(context, '/login');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 64),
                    ),
                    child: const Text("ALLOW LOCATION"),
                  ),

                  const SizedBox(height: 16),

                  TextButton(
                    onPressed: () {
                      AppHaptics.lightImpact();
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: Text(
                      "MAYBE LATER",
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    "SECURE 256-BIT ENCRYPTED GEO-DATA",
                    style: GoogleFonts.spaceGrotesk(fontSize: 8),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
