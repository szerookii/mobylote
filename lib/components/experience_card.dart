import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobylote/pylote/types.dart';
import 'package:shimmer/shimmer.dart';

class ExperiencesList extends StatelessWidget {
  const ExperiencesList({super.key, required this.experiences});

  final List<Work>? experiences;

  @override
  Widget build(BuildContext context) {
    return experiences == null ? _buildSkeletonCard() : _buildExperiencesList();
  }

  Widget _buildExperiencesList() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF23272A),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Expériences',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ...experiences!.map((e) => Column(
                children: [
                  ExperienceCard(experience: e),
                  const SizedBox(height: 8), // Added padding between experiences
                ],
              )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSkeletonCard() {
    return Shimmer.fromColors(
      baseColor: const Color(0xFF2E3B42),
      highlightColor: const Color(0xFF23272A),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ],
      ),
    );
  }
}

class ExperienceCard extends StatelessWidget {
  const ExperienceCard({super.key, required this.experience});

  final Work experience;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF23272A),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  experience.name,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  experience.position,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFFAAAAAA),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Text(
            "${DateFormat('MMMM yyyy', 'fr_FR').format(DateTime.parse(experience.startDate))} - ${experience.endDate.isNotEmpty ? DateFormat('MMMM yyyy', 'fr_FR').format(DateTime.parse(experience.endDate)) : 'En cours'}", 
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFFAAAAAA),
            ),
          ),
        ],
      ),
    );
  }
}

