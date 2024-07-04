import 'package:flutter/material.dart';

class CustomBottomAppBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const CustomBottomAppBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.transparent,
      shape: const CircularNotchedRectangle(),
      notchMargin: 10.0,
      child: Container(
        height: 70.0,
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF23272A),
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF23272A).withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildIconButton(Icons.home, 0),
            _buildIconButton(Icons.shopping_cart, 1),
            _buildIconButton(Icons.person, 3),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, int index) {
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 50.0,
        height: 50.0,
        decoration: BoxDecoration(
          color: selectedIndex == index ? Colors.grey : Colors.transparent,
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: Icon(
          icon,
          color: selectedIndex == index ? Colors.white : Colors.grey,
        ),
      ),
    );
  }
}