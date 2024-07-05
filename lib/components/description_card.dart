import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DescriptionCard extends StatelessWidget {
  const DescriptionCard({super.key, required this.description});

  final String? description;

  @override
  Widget build(BuildContext context) {
    return description == null ? _buildSkeletonCard() : _buildDescriptionCard();
  }

  Widget _buildDescriptionCard() {
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
            'Description',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            description!,
            style: const TextStyle(
              color: Color(0xFFAAAAAA),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkeletonCard() {
    return Shimmer.fromColors(
      baseColor: Color(0xFF2E3B42),
      highlightColor: Color(0xFF23272A),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 200,
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