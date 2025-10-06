import 'package:flutter/material.dart';
import 'package:kindora/app_theme/app_colors.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({super.key, this.child});
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.secondaryBackground,
      body: Stack(children: [SafeArea(child: child!)]),
    );
  }
}
