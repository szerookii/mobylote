import 'package:flutter/material.dart';
import 'package:mobylote/components/bottom_bar.dart';
import 'package:mobylote/components/description_card.dart';
import 'package:mobylote/components/experience_card.dart';
import 'package:mobylote/components/profile_card.dart';
import 'package:mobylote/components/tech_card.dart';
import 'package:mobylote/pylote/profile.dart';
import 'package:mobylote/pylote/types.dart';
import 'package:mobylote/utils/dialog.dart';
import 'package:mobylote/views/home/home.dart';
import 'package:mobylote/views/home/job_board.dart';
import 'package:mobylote/views/login/ask_code.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.id});

  final String id;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Profile? profile;
  int _selectedIndex = 2;

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  _fetchProfile() async {
    try {
      if (!mounted) return;
      final profile = await getProfile(widget.id);
      setState(() {
        if (!mounted) return;
        this.profile = profile;
      });
    } catch (e) {
      if (!mounted) return;
      showToast(
          context,
          'Erreur lors de la récupération de votre profil, retentative dans 5 secondes...',
          ToastType.error);

      Future.delayed(const Duration(seconds: 5), () {
        if (!mounted) return;
        _fetchProfile();
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      switch (index) {
        case 0:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage(id: widget.id)),
          );
          break;
        case 1:
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => JobBoardPage(id: widget.id)),
          );
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 60.0, left: 16.0, right: 16.0),
          child: Column(
            children: [
              ProfileCard(profile: profile),
              const SizedBox(height: 16),
              TechCard(technos: profile?.skills.map((e) => e.name).toList()),
              const SizedBox(height: 16),
              DescriptionCard(description: profile?.basics.summary),
              const SizedBox(height: 16),
              ExperiencesList(experiences: profile?.work),
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
