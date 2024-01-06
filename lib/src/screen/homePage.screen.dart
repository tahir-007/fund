import 'package:flutter/material.dart';
import 'package:fund/src/screen/projectCard.screen.dart';
import 'package:fund/src/service/database.service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DataService dataService;
  late List<Map<String, dynamic>> projects = [];

  @override
  void initState() {
    super.initState();
    dataService = DataService();
    fetchData();
  }

  Future<void> fetchData() async {
    final List<Map<String, dynamic>> data = await dataService.getProjects();
    setState(() {
      projects = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crowdfunding Projects'),
      ),
      body: projects.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: projects.length,
              itemBuilder: (context, index) {
                return ProjectCard(project: projects[index]);
              },
            ),
    );
  }
}
