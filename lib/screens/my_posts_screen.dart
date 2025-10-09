import 'package:kindora/screens/edit_post_screen.dart';
import 'package:kindora/screens/new_post_screen.dart';
import 'package:kindora/screens/payment_screen.dart';
import 'package:kindora/screens/profile_screen.dart';

import 'home_screen.dart';
import 'package:flutter/material.dart';
import 'package:kindora/app_theme/app_colors.dart';

class MyPostsScreen extends StatelessWidget {
  const MyPostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,

      // Custom Header/Search Bar area
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
          child: _buildSearchBar(),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: [MyPostCard(), MyPostCard()],
      ),

      // Bottom Navigation Bar with Click Events
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  // --- Search Bar Component (Matches the image structure) ---
  Widget _buildSearchBar() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Colors.black.withOpacity(0.5),
        ), // Add a slight border to match
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10, right: 8),
            child: Icon(Icons.search, color: Colors.grey),
          ),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search",
                border: InputBorder.none,
              ),
            ),
          ),
          // Cancel/Close area
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border(left: BorderSide(color: Colors.grey.shade300)),
            ),
            child: const Row(
              children: [
                Icon(Icons.close, color: Colors.black, size: 20),
                SizedBox(width: 5),
                Text("", style: TextStyle(color: Colors.black)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Bottom Navigation Bar Component with Click Events ---
  Widget _buildBottomNavBar(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: AppColors.secondaryBackground, // E7AC98
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // 1. Home Button (Navigation)
          _navItem(
            Icons.home,
            false, // Not selected in MyPost.png
            AppColors.primaryButton,
            () {
              // CLICK EVENT: Navigate to Home Screen
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
          ),

          // 2. Add Button (Navigation)
          _navItem(
            Icons.add,
            false, // Not selected
            AppColors.primaryButton,
            () {
              // CLICK EVENT: Navigate to Add Post Screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NewPostScreen()),
              );
            },
          ),

          // 3. Profile Button (Selected State in MyPost.png)
          _navItem(
            Icons.person,
            false, // Profile is selected
            AppColors.primaryButton,
            () {
              // CLICK EVENT: Navigate to Profile Screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  // Helper function for Nav Items
  Widget _navItem(
    IconData icon,
    bool isSelected,
    Color activeColor,
    VoidCallback onPressed,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed, // The click event handler
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          decoration: isSelected
              ? BoxDecoration(
                  color: activeColor, // B55266
                  borderRadius: BorderRadius.circular(15),
                )
              : null,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 30),
              const SizedBox(height: 2),
            ],
          ),
        ),
      ),
    );
  }
}

// ====================================================================
// 4. MY POST CARD WIDGET
// ====================================================================

class MyPostCard extends StatelessWidget {
  const MyPostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfileHeader(context), // Contains the EDIT button
          const SizedBox(height: 8),
          _buildAmountRow(),
          const SizedBox(height: 8),
          const Text(
            "Pets are not just animals, they are family. They teach us unconditional love, loyalty, and how to enjoy the little moments.",
            style: TextStyle(fontSize: 14.5),
          ),
          const SizedBox(height: 10),
          _buildImageGrid(),
          const SizedBox(height: 10),
          _buildActionButtons(context),
        ],
      ),
    );
  }

  // Helper for Profile Section (Includes Edit Button Click Event)
  Widget _buildProfileHeader(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage('assets/images/user.jpeg'), // Placeholder
        ),
        const SizedBox(width: 10),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Jhon Smith",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Row(
              children: [
                Text(
                  "Kind Donor",
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
                SizedBox(width: 4),
                Text("😊", style: TextStyle(fontSize: 16)),
              ],
            ),
          ],
        ),
        const Spacer(),

        // --- EDIT BUTTON ---
        ElevatedButton.icon(
          onPressed: () {
            // CLICK EVENT: Navigate to Edit Post Screen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EditPostScreen()),
            );
          },
          icon: const Icon(Icons.edit, size: 18, color: Colors.white),
          label: const Text("Edit", style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryButton, // B55266
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            elevation: 0,
          ),
        ),
      ],
    );
  }

  // Helper for Amount Section
  Widget _buildAmountRow() {
    return Row(
      children: [
        const Text(
          "Amount Required: ",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
        ),
        Text(
          "50,000",
          style: TextStyle(fontWeight: FontWeight.bold, color:  AppColors.primaryButton,fontSize: 12),
        ), // DF8B92
        const Spacer(),
        const Text(
          "Amount Received: ",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
        ),
        Text(
          "15,000",
          style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryButton,fontSize: 12),
        ), // DF8B92
      ],
    );
  }

  // Helper for Image Grid
  Widget _buildImageGrid() {
    return Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              'assets/images/child1.jpg', // Placeholder
              fit: BoxFit.cover,
              height: 150,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              'assets/images/child2.jpeg', // Placeholder
              fit: BoxFit.cover,
              height: 150,
            ),
          ),
        ),
      ],
    );
  }

  // --- Action Buttons with Click Events ---
  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // 1. Like Button
        _feedButton(
          icon: Icons.thumb_up_alt_outlined,
          label: "Like",
          onPressed: () => debugPrint('Like Clicked!'), // CLICK EVENT: Print
          backgroundColor: AppColors.accentBackground, // ECCABF
        ),
        // 2. Comment Button
        _feedButton(
          icon: Icons.comment_outlined,
          label: "Comment",
          onPressed: () => debugPrint('Comment Clicked!'), // CLICK EVENT: Print
          backgroundColor: AppColors.accentBackground, // ECCABF
        ),
        // 3. Donate Button (Navigation)
        _feedButton(
          icon: Icons.favorite,
          label: "Donate",
          onPressed: () {
            // CLICK EVENT: Navigate to Payment Screen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PaymentScreen()),
            );
          },
          backgroundColor: AppColors.primaryButton, // E7AC98
          labelColor: Colors.white,
          iconColor: Colors.white,
        ),
      ],
    );
  }

  // Helper for consistent action buttons
  Widget _feedButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required Color backgroundColor,
    Color labelColor = Colors.black,
    Color iconColor = Colors.black,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: TextButton.icon(
          onPressed: onPressed, // The click event
          icon: Icon(icon, size: 18, color: iconColor),
          label: Text(label, style: TextStyle(color: labelColor)),
          style: TextButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(vertical: 10),
          ),
        ),
      ),
    );
  }
}
