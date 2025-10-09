import 'home_screen.dart';
import 'profile_screen.dart';
import 'package:flutter/material.dart';
import '../app_theme/app_colors.dart';

class NewPostScreen extends StatefulWidget {
  const NewPostScreen({super.key});

  @override
  State<NewPostScreen> createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  // Controllers for user input
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController(
    text: "0.00",
  );

  // List to hold image paths (simulated)
  List<String> _images = [];

  @override
  void dispose() {
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _addPhoto() {
    // 🚀 CLICK EVENT: Simulates opening the gallery/computer file explorer
    debugPrint('*** Photo Gallery/Camera opened to add new photo! ***');
    // In a real app, you would use a package like 'image_picker' here.

    // Simulate adding a new placeholder image for demonstration
    // If you need to see the image appear, you'd add state logic here.
    // For this minimal screen, we just log the event.
  }

  void _handlePost() {
    // 🚀 CLICK EVENT: Post the new data
    // In a real app, this sends data to your backend/database
    debugPrint('*** Post button clicked! New post data: ***');
    debugPrint('Description: ${_descriptionController.text}');
    debugPrint('Amount: ${_amountController.text}');
    debugPrint('Images uploaded: ${_images.length}');

    // Optionally navigate back to the home screen after posting
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground, // F7E6CD
      // Custom AppBar with Back button
      appBar: AppBar(
        backgroundColor: AppColors.lightBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryButton),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          "New Post",
          style: TextStyle(
            color: AppColors.primaryButton, // B55266
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 1. Description Text Field
            _buildDescriptionField(),

            const SizedBox(height: 25),

            // 2. Add Photo Button
            _buildAddPhotoButton(),

            const SizedBox(height: 25),

            // 3. Enter Required Amount Field
            _buildAmountField(),

            const SizedBox(height: 40),

            // 4. Post Button
            _buildPostButton(),
          ],
        ),
      ),

      // 5. Bottom Navigation Bar
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  // --- Widget Builders ---

  Widget _buildDescriptionField() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.accentBackground.withOpacity(
          0.5,
        ), // ECCABF slight opacity
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: _descriptionController,
        maxLines: 5,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: "Enter description", // Matches the image
        ),
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildAddPhotoButton() {
    return SizedBox(
      width: double.infinity,
      child: TextButton.icon(
        onPressed:
            _addPhoto, // 🚀 CLICK EVENT: Add photo (simulates gallery open)
        icon: const Icon(
          Icons.camera_alt_outlined,
          size: 30,
          color: Colors.black87,
        ),
        label: const Text(
          "+Add Photo",
          style: TextStyle(
            fontSize: 18,
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: TextButton.styleFrom(
          backgroundColor: AppColors.accentBackground, // ECCABF
          padding: const EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }

  Widget _buildAmountField() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.accentBackground, // ECCABF
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Enter required amount",
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
          TextFormField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              prefixIcon: Text(
                "₹",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryButton, // DF8B92
                ),
              ),
              prefixIconConstraints: const BoxConstraints(
                minWidth: 0,
                minHeight: 0,
              ),
              border: InputBorder.none,
            ),
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryButton, // DF8B92
            ),
            onChanged: (value) {
              debugPrint('Amount changed to: $value');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPostButton() {
    return SizedBox(
      // width: double.infinity,
      width: 250,
      // height: 60,
      child: ElevatedButton(
        onPressed: _handlePost, // 🚀 CLICK EVENT: Post the new content
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryButton, // B55266
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
        ),
        child: const Text(
          "Post",
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // --- Bottom Navigation Bar with Click Events ---

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
            false, // Not selected
            AppColors.primaryButton,
            () {
              // CLICK EVENT: Go to Home Screen
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
          ),

          // 2. Add Button (Selected State)
          _navItem(
            Icons.add,
            true, // Add is selected/active on this screen
            AppColors.primaryButton,
            () {
              debugPrint('Already on New Post Screen');
            },
          ),

          // 3. Profile Button (Navigation)
          _navItem(
            Icons.person,
            false, // Not selected
            AppColors.primaryButton,
            () {
              // CLICK EVENT: Go to Profile Screen
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
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
            children: [Icon(icon, color: Colors.white, size: 30)],
          ),
        ),
      ),
    );
  }
}
