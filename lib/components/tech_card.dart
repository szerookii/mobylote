import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TechCard extends StatelessWidget {
  const TechCard({super.key, required this.technos});

  final List<String>? technos;

  @override
  Widget build(BuildContext context) {
    return technos == null ? _buildSkeletonCard() : _buildTechCard(technos);
  }

  Widget _buildTechCard(List<String>? technos) {
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
          const Text(
            'Technos',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: technos!.map((e) => TechChip(label: e)).toList(),
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
            height: 250,
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

class TechChip extends StatelessWidget {
  final String label;

  const TechChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: const Color.fromRGBO(171, 171, 171, 0.16),
      avatar: const CircleAvatar(
        backgroundColor: Color.fromRGBO(255, 247, 205, 1),
        child: Text(
          '?',
          style: TextStyle(color: Colors.black, fontSize: 14),
          textAlign: TextAlign.center,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide.none, // Removed border color
      ),
    );
  }
}