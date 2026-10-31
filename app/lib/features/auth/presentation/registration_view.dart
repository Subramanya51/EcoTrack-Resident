import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/haptics.dart';
import '../../../shared/widgets/custom_text_field.dart';
import 'package:app/services/auth_service.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  // ✅ Controllers
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).colorScheme.onSurface,
            size: 20,
          ),
          onPressed: () {
            AppHaptics.lightImpact();
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "JOIN THE FOREST",
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8),

              Text(
                "Create your\nEco Account",
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  height: 1.1,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),

              const SizedBox(height: 40),

              // ✅ Full Name
              CustomTextField(
                label: "Full Name",
                hint: "John Doe",
                prefixIcon: Icons.person_outline,
                controller: userNameController,
              ),
              const SizedBox(height: 20),

              // ✅ Phone Number
              CustomTextField(
                label: "Phone Number",
                hint: "9876543210",
                prefixIcon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                controller: phoneController,
              ),
              const SizedBox(height: 20),

              // ✅ Address
              CustomTextField(
                label: "Address",
                hint: "Goa",
                prefixIcon: Icons.location_on_outlined,
                controller: addressController,
              ),
              const SizedBox(height: 20),

              // ✅ Password
              CustomTextField(
                label: "Password",
                hint: "••••••••",
                obscureText: true,
                prefixIcon: Icons.lock_outline,
                controller: passwordController,
              ),

              const SizedBox(height: 48),

              // 🚀 REGISTER BUTTON
              ElevatedButton(
                onPressed: () async {
                  AppHaptics.mediumImpact();

                  setState(() => isLoading = true);

                  final response = await AuthService.registerUser(
                    userName: userNameController.text.trim(),
                    password: passwordController.text.trim(),
                    phoneNumber: phoneController.text.trim(),
                    address: addressController.text.trim(),
                    role: "ROLE_RESIDENT",
                  );

                  setState(() => isLoading = false);

                  if (response["success"]) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Registration Successful")),
                    );

                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(response["message"])),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 64),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("INITIALIZE ACCOUNT"),
              ),

              const SizedBox(height: 24),

              // T&C
              Center(
                child: Text(
                  "By joining, you agree to our Eco-Directives.",
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurfaceVariant.withOpacity(0.7),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
