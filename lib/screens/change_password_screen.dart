import 'package:flutter/material.dart';
import 'package:kindora/app_theme/app_colors.dart';
import 'package:kindora/screens/home_screen.dart';
import 'package:kindora/screens/new_post_screen.dart';
import 'package:kindora/screens/profile_screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _reEnterPasswordController = TextEditingController();

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _reEnterPasswordController.dispose();
    super.dispose();
  }

  String? _validatePassword(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter your $fieldName.';
    }
    if (value.length < 6) {
      return '$fieldName must be at least 6 characters.';
    }
    return null;
  }

  String? _validateReEnterPassword(String? value) {
    String? requiredCheck = _validatePassword(value, "password");
    if (requiredCheck != null) return requiredCheck;

    if (_newPasswordController.text != value) {
      return 'New password and re-entered password do not match.';
    }
    return null;
  }

  void _changePassword() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password changed successfully!')),
      );
      print('Old Password: ${_oldPasswordController.text}');
      print('New Password: ${_newPasswordController.text}');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ProfileScreen()),
      );
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
            const SizedBox(height: 20),
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: AppColors.lightBackground,
                    backgroundImage: const AssetImage(
                      'assets/images/user.jpeg',
                    ),
                    onBackgroundImageError: (_, __) =>
                        debugPrint('Error loading profile image.'),
                  ),
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
            Container(
              height:
                  MediaQuery.of(context).size.height -
                  kToolbarHeight -
                  MediaQuery.of(context).padding.top,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: AppColors.lightBackground,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildPasswordField(
                      controller: _oldPasswordController,
                      hintText: 'Old Password',
                      icon: Icons.lock_outline,
                      validator: (value) =>
                          _validatePassword(value, 'Old Password'),
                    ),
                    const SizedBox(height: 15),
                    _buildPasswordField(
                      controller: _newPasswordController,
                      hintText: 'New Password',
                      icon: Icons.lock,
                      validator: (value) =>
                          _validatePassword(value, 'New Password'),
                    ),
                    const SizedBox(height: 15),
                    _buildPasswordField(
                      controller: _reEnterPasswordController,
                      hintText: 'Re-enter New Password',
                      icon: Icons.lock_reset,
                      validator: _validateReEnterPassword,
                    ),
                    const SizedBox(height: 50),
                    SizedBox(
                      width: 250,
                      child: ElevatedButton(
                        onPressed: _changePassword,
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
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      style: const TextStyle(color: AppColors.primaryButton),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.lightBackground,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
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

  Widget _buildBottomNavBar(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: AppColors.secondaryBackground,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(Icons.home, false, AppColors.primaryButton, () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          }),
          _navItem(Icons.add, false, AppColors.primaryButton, () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const NewPostScreen()),
            );
          }),
          _navItem(Icons.person, false, AppColors.primaryButton, () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
          }),
        ],
      ),
    );
  }

  Widget _navItem(
    IconData icon,
    bool isSelected,
    Color activeColor,
    VoidCallback onPressed,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          decoration: isSelected
              ? BoxDecoration(
                  color: activeColor,
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
