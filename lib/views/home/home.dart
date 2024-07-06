import 'package:flutter/material.dart';
import 'package:mobylote/components/bottom_bar.dart';
import 'package:mobylote/components/preferences_card.dart';
import 'package:mobylote/components/status_card.dart';
import 'package:mobylote/views/home/job_board.dart';
import 'package:mobylote/views/home/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.id});

  final String id;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      switch(index) {
        case 1:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => JobBoardPage(id: widget.id)),
          );
          break;
        case 2:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ProfilePage(id: widget.id)),
          );
          break;
      }
    });
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView( 
        child: Padding(
          padding: const EdgeInsets.only(top: 60.0),
          child: Column(
            children: [
              StatusCard(id: widget.id),
              PreferencesCard(id: widget.id),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomAppBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
