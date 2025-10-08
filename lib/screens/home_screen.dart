import 'package:flutter/material.dart';
import '../app_theme/app_colors.dart';
import 'new_post_screen.dart';
import 'profile_screen.dart';

// ====================================================================
// 2. TARGET NAVIGATION SCREENS (PLACEHOLDERS)
// ====================================================================

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Post')),
      body: const Center(
        child: Text('Add Post Screen', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Make a Donation')),
      body: const Center(
        child: Text('Payment Screen', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}

// ====================================================================
// 3. HOME PAGE STRUCTURE
// ====================================================================

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
          child: _buildSearchBar(),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: const [DonationFeedCard(), DonationFeedCard()],
      ),

      // Bottom Navigation Bar with Click Events
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  // --- Search Bar Component ---
  Widget _buildSearchBar() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: const TextField(
        decoration: InputDecoration(
          icon: Padding(
            padding: EdgeInsets.only(left: 10),
            child: Icon(Icons.search, color: Colors.grey),
          ),
          hintText: "Search",
          border: InputBorder.none,
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.close, color: Colors.black),
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Text("Cancel", style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
        ),
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
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // 1. Home Button (Selected State)
          _navItem(
            Icons.home,
            true,
            AppColors.primaryButton,
            () => debugPrint(
              'Already on Home Screen',
            ), // CLICK EVENT: No navigation needed
          ),

          // 2. Add Button (Navigation)
          _navItem(
            Icons.add,
            false,
            AppColors.primaryButton,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NewPostScreen()),
              );
            }, // CLICK EVENT: Navigate to Add Post Screen
          ),

          // 3. Profile Button (Navigation)
          _navItem(
            Icons.person,
            false,
            AppColors.primaryButton,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            }, // CLICK EVENT: Navigate to Profile Screen
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
// 4. DONATION CARD WIDGET
// ====================================================================

class DonationFeedCard extends StatelessWidget {
  const DonationFeedCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfileHeader(),
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
          // Pass the context to the action buttons for navigation
          _buildActionButtons(context),
        ],
      ),
    );
  }

  // Helper for Profile Section
  Widget _buildProfileHeader() {
    return const Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage('assets/images/user.jpeg'),
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Jhon Smith",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Row(
              children: [
                Text(
                  "Kind Donor with Soft Heart",
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
                SizedBox(width: 4),
                Text("😊", style: TextStyle(fontSize: 16)),
              ],
            ),
          ],
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
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        Text(
          "50,000",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.primaryButton,
          ),
        ), // DF8B92
        const Spacer(),
        const Text(
          "Amount Received: ",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        Text(
          "15,000",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.primaryButton,
          ),
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
              'assets/images/child1.jpg',
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
              'assets/images/child2.jpeg',
              fit: BoxFit.cover,
              height: 150,
            ),
          ),
        ),
      ],
    );
  }

  // --- Action Buttons with Click Events (accepts context for navigation) ---
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
          label: "Donate Now",
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
