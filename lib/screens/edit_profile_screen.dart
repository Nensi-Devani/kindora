import 'package:flutter/material.dart';
import 'package:kindora/screens/home_screen.dart';
import 'package:kindora/screens/new_post_screen.dart';
import 'package:kindora/screens/profile_screen.dart';
import '../app_theme/app_colors.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: 'Jhon Smith');
  final _phoneController = TextEditingController(text: '+91 12345 67890');
  final _addressController = TextEditingController(
    text: '"Happy Home", 150 ft ring road, Rajkot, Gujarat.',
  );

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  // --- Validation Logic ---
  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name.';
    }
    return null;
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number.';
    }
    if (!RegExp(r'^\+?[\d\s-]{7,20}$').hasMatch(value)) {
      return 'Enter a valid phone number.';
    }
    return null;
  }

  String? _validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your address.';
    }
    return null;
  }

  // --- Click Events ---
  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile saved successfully!')),
      );
      print('Profile Saved! Data: Name: ${_nameController.text}');
    }
  }

  void _editProfileImage() {
    print('Edit Profile Image tapped!');
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Image picker placeholder.')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryBackground,
      appBar: AppBar(
        backgroundColor: AppColors.secondaryBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.lightBackground),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- Profile Image Section ---
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  // Circular Profile Image (Using a colored circle as a placeholder)
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: AppColors.lightBackground,
                    backgroundImage: AssetImage('assets/images/user.jpeg'),
                    onBackgroundImageError: (_, __) {
                      debugPrint('Error loading profile image.');
                    },
                    child: null, // No child needed when using backgroundImage
                  ),

                  // Edit Icon
                  GestureDetector(
                    onTap: _editProfileImage,
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.primaryButton,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.edit,
                          size: 18,
                          color: AppColors.secondaryBackground,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // --- Form Card Section ---
            Container(
              height: 700,
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: AppColors.lightBackground, // Color from image
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Name Field
                    _buildTextField(
                      controller: _nameController,
                      hintText: 'Jhon Smith',
                      icon: Icons.person,
                      validator: _validateName,
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(height: 15),
                    // Phone Field
                    _buildTextField(
                      controller: _phoneController,
                      hintText: '+91 12345 67890',
                      icon: Icons.credit_card,
                      validator: _validatePhoneNumber,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 15),
                    // Address Field
                    _buildTextField(
                      controller: _addressController,
                      hintText:
                          '"Happy Home", 150 ft ring road, Rajkot, Gujarat.',
                      icon: Icons.location_on,
                      validator: _validateAddress,
                      keyboardType: TextInputType.streetAddress,
                      maxLines: 4,
                    ),
                    const SizedBox(height: 50),

                    // --- Save Button ---
                    SizedBox(
                      width: 250,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProfileScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryButton,
                          minimumSize: const Size(250, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Save',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.lightBackground,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // --- Bottom Navigation Bar ---
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  // -----------------------------------------------------------------------------
  // 3. HELPER WIDGETS
  // -----------------------------------------------------------------------------

  // Helper method to build a consistent text field style
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    required String? Function(String?) validator,
    required TextInputType keyboardType,
    int maxLines = 1,
  }) {
    EdgeInsets contentPadding = maxLines > 1
        ? const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0)
        : const EdgeInsets.symmetric(vertical: 0, horizontal: 10.0);

    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      maxLines: maxLines,
      minLines: maxLines > 1 ? maxLines : null,
      style: const TextStyle(color: AppColors.primaryButton),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.lightBackground, // White
        contentPadding: contentPadding,
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColors.primaryButton),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 15, right: 10),
          child: Icon(icon, color: AppColors.primaryButton),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: AppColors.primaryButton, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: AppColors.primaryButton,
            width: 2.0,
          ),
        ),
        // Simplified error borders for brevity
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
        ),
      ),
    );
  }

  // Helper method for the bottom navigation bar
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => NewPostScreen()),
              );
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
