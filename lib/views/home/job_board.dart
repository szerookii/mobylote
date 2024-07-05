import 'package:flutter/material.dart';
import 'package:mobylote/components/bottom_bar.dart';
import 'package:mobylote/pylote/job.dart';
import 'package:mobylote/pylote/types.dart';
import 'package:mobylote/utils/dialog.dart';
import 'package:mobylote/views/home/home.dart';
import 'package:mobylote/views/home/profile.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class JobBoardPage extends StatefulWidget {
  const JobBoardPage({super.key, required this.id});

  final String id;

  @override
  State<JobBoardPage> createState() => _JobBoardPageState();
}

class _JobBoardPageState extends State<JobBoardPage> {
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _localisationController = TextEditingController();

  List<Job>? jobs;
  List<Job>? allJobs;

  @override
  void initState() {
    super.initState();
    _fetchJobs();

    _typeController.addListener(_filterJobs);
    _localisationController.addListener(_filterJobs);
  }

  @override
  void dispose() {
    _typeController.dispose();
    _localisationController.dispose();
    super.dispose();
  }

  _fetchJobs() async {
    try {
      if (!mounted) return;
      final jobs = await getJobs();
      if (!mounted) return;
      setState(() {
        this.jobs = jobs;
        this.allJobs = jobs;
      });
    } catch (e) {
      if (!mounted) return;
      showToast(
          context, 'Erreur lors de la récupération des jobs', ToastType.error);
    }
  }

  void _filterJobs() {
    final type = _typeController.text.toLowerCase();
    final location = _localisationController.text.toLowerCase();
    
    setState(() {
      jobs = allJobs?.where((job) {
        final jobType = job.title.toLowerCase();
        final jobLocation = job.city.toLowerCase();
        
        return jobType.contains(type) && jobLocation.contains(location);
      }).toList();
    });
  }

  int _selectedIndex = 1;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage(id: widget.id)),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage(id: widget.id)),
        );
        break;
    }
  }

  Widget _buildDropdown(String hint) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        hintText: hint,
        fillColor: const Color(0xFF23272A),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      items: const [],
      onChanged: (value) {},
    );
  }

  Widget _buildSearchFilters() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _typeController,
                decoration: InputDecoration(
                  hintText: 'React',
                  prefixIcon: const Icon(Icons.search),
                  fillColor: const Color(0xFF23272A),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: _localisationController,
                decoration: InputDecoration(
                  hintText: 'Localisation',
                  prefixIcon: const Icon(Icons.location_on),
                  fillColor: const Color(0xFF23272A),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildJobCard(Job job) {
    return GestureDetector(
      onTap: () async {
        try {
          await launchUrl(Uri.parse(job.url));
        } catch(e) {
          showToast(context, 'Erreur lors de l\'ouverture du lien', ToastType.error);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF23272A),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              job.plateforme,
              style: const TextStyle(color: Colors.grey),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              job.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              '${job.city} ${job.tjm.isNotEmpty ? '• ${job.tjm}' : ''}',
              style: const TextStyle(color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(
              job.aDistanceOuSurPlace,
              style: const TextStyle(color: Colors.grey),
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Text(
              getTimeStr(job.date),
              style: const TextStyle(color: Colors.grey),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJobGrid() {
    if (jobs == null) return _buildSkeletonGrid();

    if (jobs!.isEmpty) {
      return Center(
        child: Text(
          'No jobs found',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      );
    }

    return GridView.builder(
      itemCount: jobs!.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        return _buildJobCard(jobs![index]);
      },
    );
  }

  Widget _buildSkeletonGrid() {
    return GridView.builder(
      itemCount: 10,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        return _buildSkeletonCard();
      },
    );
  }

  Widget _buildSkeletonCard() {
    return Shimmer.fromColors(
      baseColor: Color(0xFF2E3B42),
      highlightColor: Color(0xFF23272A),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xFF23272A),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getTimeStr(String date) {
    final DateTime postedDate = DateTime.parse(date);
    final Duration difference = DateTime.now().difference(postedDate);

    if (difference.inDays > 0) {
      return 'Il y a ${difference.inDays} jours';
    } else {
      return 'Il y a ${difference.inHours} heures';
    }
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
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Job Board',
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 18),
                    _buildSearchFilters(),
                    const SizedBox(height: 16),
                    Expanded(
                      child: jobs == null ? _buildSkeletonGrid() : _buildJobGrid(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomAppBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}