import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mobylote/notifications/notification_service.dart';
import 'package:mobylote/pylote/types.dart';
import 'package:mobylote/pylote/profile.dart';
import 'package:intl/intl.dart';
import 'package:mobylote/utils/dialog.dart';
import 'package:shimmer/shimmer.dart';

class StatusCard extends StatefulWidget {
  const StatusCard({super.key, required this.id});

  final String id;

  @override
  State<StatefulWidget> createState() {
    return _StatusCardState();
  }
}

class _StatusCardState extends State<StatusCard> {
  Profile? profile;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  _fetchProfile() async {
    try {
      final profile = await getProfile(widget.id);
      if (!mounted) return;
      setState(() {
        this.profile = profile;
      });
    } catch (e) {
      if (!mounted) return;
      showToast(
          context,
          'Erreur lors de la récupération de votre profil, retentative dans 5 secondes...',
          ToastType.error);

      Future.delayed(const Duration(seconds: 5), () {
        if (mounted) _fetchProfile();
      });
    }
  }

  _handleSetAvailability(bool available) async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
    });

    final result = await setAvailability(
        widget.id,
        available,
        DateFormat('yyyy-MM-dd')
            .format(DateTime.now().add(const Duration(days: 7))));

    setState(() {
      _isLoading = false;
    });

    if (!mounted) return;

    if (result) {
      showToast(
          context, 'Votre statut a bien été mis à jour', ToastType.success);

      profile = null;
      _fetchProfile();
    } else {
      showToast(context, 'Erreur lors de la mise à jour de votre statut',
          ToastType.error);
    }
  }

  Widget _buildSkeleton() {
    return Shimmer.fromColors(
      baseColor: const Color(0xFF2E3B42),
      highlightColor: const Color(0xFF23272A),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 200,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: 180,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: profile == null
            ? _buildSkeleton()
            : Column(
                key: const ValueKey<int>(1),
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello, ${profile?.meta.firstName ?? ''}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF2E3B42), Color(0xFF23272A)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'STATUT',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 10),
                            profile!.meta.freelance.available
                                ? const Row(
                                    children: [
                                      Icon(Icons.circle,
                                          color: Colors.green, size: 12),
                                      SizedBox(width: 8),
                                      Text(
                                        'Disponible',
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  )
                                : const Row(
                                    children: [
                                      Icon(Icons.circle,
                                          color: Colors.red, size: 12),
                                      SizedBox(width: 8),
                                      Text(
                                        'Indisponible',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                            const SizedBox(height: 4),
                            profile!.meta.freelance.available
                                ? Text(
                                    'pendant encore ${(DateTime.parse(profile!.meta.freelance.availabilityDate).difference(DateTime.now()).inDays) + 1} jours',
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  )
                                : Text(
                                    'jusqu\'au ${DateFormat('dd MMMM', 'fr_FR').format(DateTime.parse(profile!.meta.freelance.availabilityDate))}',
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                            const SizedBox(height: 20),
                            profile!.meta.freelance.available
                                ? ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      side: const BorderSide(
                                          color: Color(0x52ABABAB), width: 0.5),
                                      backgroundColor: Colors.transparent,
                                      minimumSize:
                                          const Size(double.infinity, 50),
                                    ),
                                    onPressed: _isLoading
                                        ? null
                                        : () async =>
                                            await _handleSetAvailability(false),
                                    child: _isLoading
                                        ? const CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.white),
                                          )
                                        : const Text(
                                            'Je ne suis plus disponible',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                  )
                                : ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      side: const BorderSide(
                                          color: Color(0x52ABABAB), width: 0.5),
                                      backgroundColor: Colors.transparent,
                                      minimumSize:
                                          const Size(double.infinity, 50),
                                    ),
                                    onPressed: _isLoading
                                        ? null
                                        : () async =>
                                            await _handleSetAvailability(true),
                                    child: _isLoading
                                        ? const CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.white),
                                          )
                                        : const Text(
                                            'Je suis disponible',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                  ),
                          ],
                        ),
                        if (profile!.meta.freelance.available)
                          Positioned(
                            top: 0,
                            right: 0,
                            child: IconButton(
                                icon: const Icon(Icons.refresh,
                                    color: Colors.grey),
                                onPressed: () async => _isLoading
                                    ? null
                                    : await _handleSetAvailability(true)),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
