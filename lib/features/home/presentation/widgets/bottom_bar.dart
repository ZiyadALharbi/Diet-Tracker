import 'package:flutter/material.dart';

class CustomBottomBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.blue, // Solid blue background
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Circular Highlight
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            left: _calculateHighlightPosition(screenWidth),
            top: 15, // Center the circle vertically
            child: Container(
              width: 48, // Size of the circular highlight
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  _getActiveIcon(), // Icon inside the highlight
                  color: Colors.blue,
                  size: 24,
                ),
              ),
            ),
          ),
          // Navigation Items
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                icon: Icons.book,
                label: 'Recipes',
                index: 0,
                isActive: currentIndex == 0,
                onTap: () => onTap(0),
              ),
              _buildNavItem(
                icon: Icons.home,
                label: 'Home',
                index: 1,
                isActive: currentIndex == 1,
                onTap: () => onTap(1),
              ),
              _buildNavItem(
                icon: Icons.bar_chart,
                label: 'Reports',
                index: 2,
                isActive: currentIndex == 2,
                onTap: () => onTap(2),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Calculate the horizontal position of the circular highlight
  double _calculateHighlightPosition(double screenWidth) {
    final tabWidth = screenWidth / 3; // Divide the bar into 3 equal sections
    return currentIndex * tabWidth +
        (tabWidth / 2) -
        24; // Center the highlight
  }

  // Get the active icon to display inside the white circle
  IconData _getActiveIcon() {
    if (currentIndex == 0) return Icons.book;
    if (currentIndex == 1) return Icons.home;
    return Icons.bar_chart;
  }

  // Build each navigation item
  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isActive ? Colors.blue : Colors.white,
            size:
                isActive ? 24 : 20, // Different sizes for active/inactive icons
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.blue : Colors.white.withOpacity(0.8),
              fontSize: 12,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
