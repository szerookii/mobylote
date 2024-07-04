import 'package:flutter/material.dart';
import 'package:mobylote/components/bottom_bar.dart';
import 'package:mobylote/components/status_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.id});

  final String id;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;


int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Column(
              children: [
                  StatusCard(id: widget.id),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: CustomBottomAppBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}