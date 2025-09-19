import 'package:flutter/material.dart';
import '../app_theme/app_colors.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Top image
            Padding(
              padding: const EdgeInsets.only(top: 70.0),
              child: Image.asset(
                'assets/images/welcome_img.png',
                height: 210,
                fit: BoxFit.contain,
              ),
            ),

            // Welcome text with inline logo
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Welcome to ",
                      style: TextStyle(
                        fontSize: 26,
                        color: AppColors.primaryButton,
                      ),
                    ),
                    Image.asset(
                      'assets/images/logo.png',
                      height: 30,
                      fit: BoxFit.contain,
                    ),
                    const Text(
                      " !",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryButton,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    "Your kindness makes difference.\nJoin changemakers spreading kindness and uplifting lives.",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        children: [
          Expanded(
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                color: AppColors.secondaryBackground,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                ),
              ),
              child: TextButton(
                onPressed: () {
                  // Navigate to signup
                },
                child: const Text(
                  "Sign up",
                  style: TextStyle(color: Colors.black87, fontSize: 20),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                color: AppColors.primaryButton,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                ),
              ),
              child: TextButton(
                onPressed: () {
                  // Navigate to signin
                },
                child: const Text(
                  "Sign in",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
