import 'package:flutter/material.dart';
import 'package:mobylote/pylote/profile.dart';
import 'package:mobylote/pylote/types.dart';
import 'package:mobylote/utils/dialog.dart';
import 'package:shimmer/shimmer.dart';

class PreferencesCard extends StatefulWidget {
  const PreferencesCard({super.key, required this.id});

  final String id;

  @override
  State<PreferencesCard> createState() => _PreferencesCardState();
}

class _PreferencesCardState extends State<PreferencesCard> {
  Profile? profile;

  _fetchProfile() async {
    if (!mounted) return;
    try {
      final profile = await getProfile(widget.id);
      if (!mounted) return;

      setState(() {
        this.profile = profile;
      });
    } catch(e) {
      if (!mounted) return;

      showToast(context, 'Erreur lors de la récupération de votre profil, retentative dans 5 secondes...', ToastType.error);

      Future.delayed(const Duration(seconds: 5), () {
        if (!mounted) return;

        _fetchProfile();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    return profile == null ? 
    Padding(
      padding: const EdgeInsets.all(16.0),
      child: Shimmer.fromColors(
      baseColor: const Color(0xFF2E3B42),
      highlightColor: const Color(0xFF23272A),
      child: Container(
            width: double.infinity,
            height: 380,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
      ),
    )
    : Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'PRÉFÉRENCES',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  _buildPreferenceItem(
                    icon: Icons.hourglass_empty,
                    iconColor: const Color(0xFFF6D365),
                    label: 'Rythme de travail',
                    value: profile?.meta.freelance.preferences.daysPerWeek ?? 'Indifférent',
                  ),
                  const SizedBox(height: 16.0),
                  _buildPreferenceItem(
                    icon: Icons.access_time,
                    iconColor: const Color(0xFFC5E1A5),
                    label: 'Durée de mission',
                    value: profile?.meta.freelance.preferences.missionDuration ?? 'Indifférent',
                  ),
                  const SizedBox(height: 16.0),
                  _buildPreferenceItem(
                    icon: Icons.home,
                    iconColor: const Color(0xFFEF9A9A),
                    label: 'Lieu de travail',
                    value: "${profile!.meta.freelance.preferences.remoteWork[0]} +${profile!.meta.freelance.preferences.remoteWork.length - 1}",
                  ),
                  const SizedBox(height: 16.0),
                  _buildPreferenceItem(
                    icon: Icons.directions_car,
                    iconColor: const Color(0xFF81D4FA),
                    label: 'Mobilité',
                    value: "${profile!.meta.freelance.preferences.mobility[0].label} +${profile!.meta.freelance.preferences.mobility.length - 1}",
                  ),
                  const SizedBox(height: 16.0),
                  _buildPreferenceItem(
                    icon: Icons.location_pin,
                    iconColor: const Color(0xFFF48FB1),
                    label: 'Localisation',
                    value: profile?.meta.freelance.preferences.location.description ?? 'Non renseigné',
                  ),
                ],
              ),
            ],
          )),
    );
  }

  Widget _buildPreferenceItem({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: iconColor,
          radius: 16,
          child: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
        ),
        const SizedBox(width: 16.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}