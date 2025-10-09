import 'package:flutter/material.dart';
import 'package:kindora/screens/change_password_screen.dart';
import 'package:kindora/screens/edit_profile_screen.dart';
import 'package:kindora/screens/my_donation_screen.dart';
import 'package:kindora/screens/my_posts_screen.dart';
import 'package:kindora/screens/received_donation_screen.dart';
import 'package:kindora/screens/signin_screen.dart';
import '../app_theme/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Dummy profile data
  final String userName = 'Jhon Smith';
  final String userEmail = 'jhon.smith@gmail.com';

  // --- LOGOUT VALIDATION/CONFIRMATION (The requested validation) ---

  Future<void> _showLogoutConfirmation() async {
    final bool confirm =
        await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: AppColors.lightBackground, // Match screen theme
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: const Text('Confirm Signout'),
              content: const Text(
                'Are you sure you want to sign out of your account?',
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: AppColors.primaryButton),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text(
                    'Sign Out',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            );
          },
        ) ??
        false;

    if (confirm) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => SignInScreen()),
        (Route<dynamic> route) => false,
      );
    } else {
      print('Action: Log Out cancelled');
    }
  }

  // --- BUILD WIDGETS ---

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
      child: Material(
        // ******************************************************
        // FIX: Changed the background color from Colors.white to AppColors.lightBackground
        // to match the surrounding card color and removed the elevation.
        // ******************************************************
        color: AppColors.lightBackground,
        borderRadius: BorderRadius.circular(18),
        elevation:
            0, // Removed elevation to flatten the tile against the background
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 20.0,
            ),
            // The border matches the design's inner tile appearance
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black26),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.black54),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.black38,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPrimaryButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryButton,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 4,
      ),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      // Changed scaffold background to match the top header color for a smooth transition
      backgroundColor: AppColors.secondaryBackground,
      body: Stack(
        children: [
          // 1. Top Curved Header Background (secondaryBackground)
          Container(
            height: size.height * 0.35,
            decoration: const BoxDecoration(
              color: AppColors.secondaryBackground,
            ),
          ),

          // 2. Main Scrollable Content
          SingleChildScrollView(
            child: Column(
              children: [
                // Custom AppBar / Back button
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () => print('Back button pressed'),
                      ),
                    ),
                  ),
                ),

                // Profile Header (Avatar, Name, Email, Buttons)
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                  child: Column(
                    children: [
                      // Profile Picture
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: AppColors.primaryButton,
                        // Placeholder image from the prompt
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/user.jpeg',
                            fit: BoxFit.cover,
                            width: 120,
                            height: 120,
                            errorBuilder: (context, error, stackTrace) =>
                                Image.network(
                                  'https://placehold.co/120x120/E7AC98/B55266?text=Pets',
                                  fit: BoxFit.cover,
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Name and Email
                      Text(
                        userName,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryButton,
                        ),
                      ),
                      Text(
                        userEmail,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.primaryButton,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Action Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildPrimaryButton(
                            text: 'Edit Profile',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditProfileScreen(),
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 12),
                          _buildPrimaryButton(
                            text: 'Change Password',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChangePasswordScreen(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Main List Card Container (lightBackground)
                Container(
                  width: size.width,
                  height: size.height,
                  decoration: const BoxDecoration(
                    color: AppColors.lightBackground,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 20.0,
                      bottom: 100.0,
                    ), // Padding for the bottom nav bar
                    child: Column(
                      children: [
                        _buildListTile(
                          icon: Icons.assignment_outlined,
                          title: 'My Posts',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyPostsScreen(),
                              ),
                            );
                          },
                        ),
                        _buildListTile(
                          icon: Icons.wallet_giftcard_outlined,
                          title: 'My Donation',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyDonationScreen(),
                              ),
                            );
                          },
                        ),
                        _buildListTile(
                          icon: Icons.inbox_outlined,
                          title: 'Received Donation',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReceivedDonationScreen(),
                              ),
                            );
                          },
                        ),
                        _buildListTile(
                          icon: Icons.logout,
                          title: 'Sign Out',
                          onTap:
                              _showLogoutConfirmation, // Calls the confirmation dialog
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // --- Bottom Navigation Bar (Fixed at the bottom) ---
      bottomNavigationBar: Container(
        height: 70,
        decoration: const BoxDecoration(
          color: AppColors.secondaryBackground,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home_outlined, size: 30),
              color: Colors.black54,
              onPressed: () => print('Nav: Home'),
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColors.primaryButton,
                borderRadius: BorderRadius.circular(15),
              ),
              child: IconButton(
                icon: const Icon(Icons.add, size: 30),
                color: Colors.white,
                onPressed: () => print('Nav: Add Post'),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.person, size: 30),
              color: AppColors.primaryButton, // Highlight current tab
              onPressed: () => print('Nav: Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
