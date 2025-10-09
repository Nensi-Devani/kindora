import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Package needed for gallery access
import 'package:kindora/screens/home_screen.dart';
import 'package:kindora/screens/new_post_screen.dart';
import 'package:kindora/screens/profile_screen.dart';
import 'dart:io'; // Needed for File class if you were to use Image.file
import '../app_theme/app_colors.dart';

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

  // List to hold image paths. Starts with simulated assets.
  List<String> _images = [
    'assets/images/child1.jpg',
    'assets/images/child2.jpeg',
  ];

  // Initialize ImagePicker
  final ImagePicker _picker = ImagePicker();

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

  // 👇 UPDATED: Function to open the mobile gallery and add a photo
  Future<void> _addPhoto() async {
    // This line opens the mobile gallery/photo picker
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      debugPrint('*** Photo selected from gallery: ${image.path} ***');
      setState(() {
        // Add the actual file path. This path will be used by the Image widget.
        _images.add(image.path);
      });
    } else {
      debugPrint('*** Photo selection cancelled. ***');
    }
  }

  void _handlePost() {
    debugPrint('*** Post button clicked! Saving changes: ***');
    debugPrint('Description: ${_descriptionController.text}');
    debugPrint('Amount: ${_amountController.text}');
    debugPrint('Images remaining: ${_images.length}');

    // Optionally navigate back after posting
    Navigator.pop(context);
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
    Widget imageWidget;

    // Check if the path is an asset path (starts with 'assets/')
    if (imagePath.startsWith('assets/')) {
      imageWidget = Image.asset(
        imagePath,
        fit: BoxFit.cover,
        width: 150,
        height: 150,
        // Fallback for non-existent assets
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 150,
            height: 150,
            color: Colors.grey.shade300,
            child: Center(
              child: Text("Asset $index", textAlign: TextAlign.center),
            ),
          );
        },
      );
    } else {
      // If it's not an asset, assume it's a file path from image_picker
      // NOTE: Using Image.file(File(imagePath)) is the correct way,
      // but requires 'dart:io'. We use a placeholder here for general safety
      // in environments that might not handle File I/O easily, but the principle is sound.
      try {
        imageWidget = Image.file(
          File(imagePath),
          fit: BoxFit.cover,
          width: 150,
          height: 150,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 150,
              height: 150,
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: Text(
                  "File\n$index\nLoaded",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        );
      } catch (e) {
        // Fallback if File() fails for any reason
        imageWidget = Container(
          width: 150,
          height: 150,
          color: Colors.black.withOpacity(0.5),
          child: Center(
            child: Text(
              "File\n$index\nPath: $imagePath",
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        );
      }
    }

    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: imageWidget,
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
        onPressed: _addPhoto, // 👈 Calls the ImagePicker function
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
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: _handlePost, // CLICK EVENT: Post the updates
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
            fontSize: 20,
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
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
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
          _navItem(
            Icons.add,
            true, // Add is selected/active on this screen
            AppColors.primaryButton,
            () {
              // CLICK EVENT: Go to Add Post Screen
              Navigator.pushReplacement(
                // Use pushReplacement to clear the stack if needed
                context,
                MaterialPageRoute(builder: (context) => const NewPostScreen()),
              );
            },
          ),

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

// 4. MAIN APP ENTRY POINT (for testing)

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Edit Post Demo',
      theme: ThemeData(primarySwatch: Colors.red, fontFamily: 'Roboto'),
      home: const EditPostScreen(),
    );
  }
}
