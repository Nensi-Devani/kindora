import 'package:flutter/material.dart';
import 'home_screen.dart';
import '../app_theme/app_colors.dart';

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

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Profile')),
      body: const Center(
        child: Text('Profile Screen', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}

// ====================================================================
// 3. EDIT POST SCREEN (MAIN WIDGET)
// ====================================================================

class EditPostScreen extends StatefulWidget {
  const EditPostScreen({super.key});

  @override
  State<EditPostScreen> createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  // State for the text fields (simulated for demonstration)
  final TextEditingController _descriptionController = TextEditingController(
    text:
        "Pets are not just animals, they are family. They teach us unconditional love, loyalty, and how to enjoy the little moments.",
  );
  final TextEditingController _amountController = TextEditingController(
    text: "50,000",
  );

  // Simplified image list for demonstration of deletion
  List<String> _images = [
    'assets/images/child1.jpg',
    'assets/images/child2.jpeg',
  ];

  @override
  void dispose() {
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _deleteImage(int index) {
    setState(() {
      debugPrint('Photo at index $index deleted!');
      _images.removeAt(index);
    });
  }

  void _addPhoto() {
    // In a real app, this would use an image picker package (image_picker)
    debugPrint('*** Photo Gallery/Camera opened to add new photo! ***');
    // Simulate adding a new placeholder image
    setState(() {
      _images.add('assets/placeholder.png');
    });
  }

  void _handlePost() {
    // In a real app, this would save the updated data to a backend
    debugPrint('Description: ${_descriptionController.text}');
    debugPrint('Amount: ${_amountController.text}');
    debugPrint('Images remaining: ${_images.length}');

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const HomeScreen()),
      (route) => false,
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
          "Edit Post",
          style: TextStyle(
            color: AppColors.primaryButton, // B55266
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Description Text Field
            _buildDescriptionField(),

            const SizedBox(height: 25),

            // 2. Old Images Section
            const Text(
              "Old Images",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10),
            _buildImageGrid(),

            const SizedBox(height: 20),

            // 3. Add Photo Button
            _buildAddPhotoButton(),

            const SizedBox(height: 25),

            // 4. Enter Required Amount Field
            _buildAmountField(),

            const SizedBox(height: 40),

            // 5. Post Button
            _buildPostButton(),
          ],
        ),
      ),

      // 6. Bottom Navigation Bar
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
        ), // ECCABF slight opacity for background
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: _descriptionController,
        maxLines: 5,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: "Write your post description here...",
        ),
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildImageGrid() {
    return Wrap(
      spacing: 15,
      runSpacing: 15,
      children: List.generate(_images.length, (index) {
        return _buildEditableImage(
          imagePath: _images[index],
          index: index,
          onDelete: () => _deleteImage(index),
        );
      }),
    );
  }

  Widget _buildEditableImage({
    required String imagePath,
    required int index,
    required VoidCallback onDelete,
  }) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.asset(
            imagePath, // Placeholder asset
            fit: BoxFit.cover,
            width: 150,
            height: 150,
            // Simple error handling for non-existent assets
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 150,
                height: 150,
                color: Colors.grey.shade300,
                child: Center(
                  child: Text("Image $index", textAlign: TextAlign.center),
                ),
              );
            },
          ),
        ),
        Positioned(
          top: -5,
          right: -5,
          child: GestureDetector(
            onTap: onDelete, // CLICK EVENT: Delete photo
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
              ),
              child: const Icon(
                Icons.close,
                color: AppColors.primaryButton, // B55266
                size: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddPhotoButton() {
    return SizedBox(
      width: double.infinity,
      child: TextButton.icon(
        onPressed: _addPhoto, // CLICK EVENT: Add photo (simulates gallery open)
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
                  color: Colors.black, // DF8B92
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
              color: Colors.black, // DF8B92
            ),
            onChanged: (value) {
              debugPrint('Amount changed to: $value'); // Changes amount
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPostButton() {
    return Center(
      child: SizedBox(
        width: 250,
        height: 60,
        child: ElevatedButton(
          onPressed: _handlePost, // CLICK EVENT: Post the updates
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryButton, // B55266
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 5,
          ),
          child: const Text(
            "Save",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
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
          _navItem(Icons.home, false, AppColors.primaryButton, () {
            // CLICK EVENT: Go to Home Screen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          }),

          // 2. Add Button (Selected State in the image)
          _navItem(Icons.add, false, AppColors.primaryButton, () {
            // CLICK EVENT: Go to Add Post Screen
            Navigator.pushReplacement(
              // Use pushReplacement to clear the stack if needed
              context,
              MaterialPageRoute(builder: (context) => const AddPostScreen()),
            );
          }),

          // 3. Profile Button (Navigation)
          _navItem(Icons.person, false, AppColors.primaryButton, () {
            // CLICK EVENT: Go to Profile Screen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
          }),
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
