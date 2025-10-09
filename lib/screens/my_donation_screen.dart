import 'package:flutter/material.dart';
import 'package:kindora/app_theme/app_colors.dart';

// Data Model for a single donation entry
class DonationEntry {
  final String name;
  final double amount;
  final String timeAgo;
  final bool isAnonymous;

  DonationEntry({
    required this.name,
    required this.amount,
    required this.timeAgo,
    this.isAnonymous = false,
  });
}

class MyDonationScreen extends StatefulWidget {
  const MyDonationScreen({super.key});

  @override
  State<MyDonationScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<MyDonationScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Mock Data for the list
  final List<DonationEntry> _allDonations = [
    DonationEntry(
      name: 'Anonymous',
      amount: 500,
      timeAgo: 'about 2 hours ago',
      isAnonymous: true,
    ), //
    DonationEntry(
      name: 'A Toppo',
      amount: 500,
      timeAgo: 'about 7 hours ago',
    ), //
    DonationEntry(name: 'AD', amount: 531, timeAgo: 'about 9 hours ago'), //
    DonationEntry(
      name: 'Bharathi',
      amount: 1674,
      timeAgo: 'about 15 hours ago',
    ), //
    DonationEntry(
      name: 'Rishab',
      amount: 500,
      timeAgo: 'about 23 hours ago',
    ), //
    // Additional data for scrolling/generous tab
    DonationEntry(name: 'Generous Donor 1', amount: 5000, timeAgo: 'yesterday'),
    DonationEntry(name: 'Top Giver', amount: 10000, timeAgo: '3 days ago'),
    DonationEntry(name: 'Recent Contrib.', amount: 100, timeAgo: '1 hour ago'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Sort function for the "Most generous" tab
  List<DonationEntry> _getSortedDonations() {
    // Return a copy of the list sorted by amount (descending)
    return List.from(_allDonations)
      ..sort((a, b) => b.amount.compareTo(a.amount));
  }

  // ---------------------------------------------------------------------------
  // UI BUILD
  // ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: AppColors.lightBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black), //
          onPressed: () => Navigator.of(context).pop(), // Click event
        ),
        title: const Text(
          'Donors', //
          style: TextStyle(
            color: AppColors.primaryButton,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // 1. Recent Tab (Default unsorted list)
                _buildDonationList(_allDonations),
                // 2. Most Generous Tab (Sorted list)
                _buildDonationList(_getSortedDonations()),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(), //
    );
  }

  Widget _buildTabBar() {
    return Container(
      // The tab bar has no curve, matching the top-down design
      decoration: const BoxDecoration(
        color: AppColors.secondaryBackground, // Tab background color
      ),
      child: TabBar(
        controller: _tabController,
        // Click event: Optional listener for when the tab changes
        onTap: (index) {
          String tabName = index == 0 ? "Recent" : "Most generous";
          print('Tab changed to: $tabName');
        },
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: const EdgeInsets.symmetric(horizontal: 5),
        indicator: const BoxDecoration(
          color: AppColors.primaryButton, // Active tab color
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        labelColor: Colors.black, // Active label color (White)
        unselectedLabelColor: Colors.black, // Inactive label color (Black)
        labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 16,
        ),
        tabs: const [
          Tab(text: 'Recent'), //
          Tab(text: 'Most generous'), //
        ],
      ),
    );
  }

  Widget _buildDonationList(List<DonationEntry> entries) {
    return Container(
      // The list container has a white background and rounded corners
      decoration: const BoxDecoration(
        color: AppColors.lightBackground, // White card background
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 20,
      ), // Margin around the list card
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        itemCount: entries.length,
        separatorBuilder: (context, index) =>
            const Divider(height: 25, thickness: 0.5, color: Colors.grey),
        itemBuilder: (context, index) {
          final entry = entries[index];
          return _buildDonationItem(entry);
        },
      ),
    );
  }

  Widget _buildDonationItem(DonationEntry entry) {
    String donatedAmount =
        'Donated ₹${entry.amount.toStringAsFixed(entry.amount.toInt() == entry.amount ? 0 : 2)}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Name and Amount
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              entry.name, //
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              donatedAmount, // (e.g., Donated ₹500)
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        // Time Ago
        Text(
          entry.timeAgo, // (e.g., about 2 hours ago)
          style: const TextStyle(fontSize: 12, color: Colors.black),
        ),
      ],
    );
  }

  Widget _buildBottomNavBar() {
    const double navBarHeight = 70;

    return Container(
      height: navBarHeight,
      decoration: const BoxDecoration(color: AppColors.primaryButton),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navBarItem(
            icon: Icons.home,
            isSelected: true,
            onTap: () => print('Nav: Home Tapped'),
          ), // Home is selected in the image's context.
          Expanded(
            child: GestureDetector(
              onTap: () => print('Nav: Add Tapped'),
              child: Container(
                color: AppColors.secondaryBackground,
                height: double.infinity,
                child: const Icon(
                  Icons.add,
                  color: AppColors.primaryButton,
                  size: 30,
                ),
              ),
            ),
          ),
          _navBarItem(
            icon: Icons.person,
            isSelected: false,
            onTap: () => print('Nav: Profile Tapped'),
          ),
        ],
      ),
    );
  }

  Widget _navBarItem({
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    Color backgroundColor = isSelected
        ? AppColors.secondaryBackground
        : AppColors.secondaryBackground;
    Color iconColor = isSelected
        ? AppColors.primaryButton
        : Colors.black.withOpacity(0.6);

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          color: backgroundColor,
          height: double.infinity,
          child: Icon(icon, color: iconColor, size: 30),
        ),
      ),
    );
  }
}
