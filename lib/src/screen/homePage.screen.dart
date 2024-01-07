import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fund/src/model/project.model.dart';
import 'package:fund/src/service/connectivity.service.dart';
import 'package:fund/src/service/database.service.dart';
import 'package:fund/src/widget/projectCard.widget.dart';
import 'package:fund/src/widget/shimmer.widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DataService dataService;
  late List<Project> projects = [];

  @override
  void initState() {
    super.initState();
    dataService = DataService();
    fetchData();
  }

  // Fetch project data from the database
  Future<void> fetchData() async {
    final List<Project> data = await dataService.getProjects();
    setState(() {
      projects = data;
    });
  }

  // Show a Snackbar
  void showSnackbar(String message, Color color) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
      backgroundColor: color,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    // Display shimmer loading content if projects are still loading
    return projects.isEmpty
        ? const ShimmerContent()
        : Scaffold(
            appBar: AppBar(
              leading: const Icon(
                FontAwesome.heartbeat,
                color: Colors.white,
              ),
              title: Text(
                'Funding Projects',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.white,
                    ),
              ),
              centerTitle: true,
              backgroundColor: Theme.of(context).primaryColor,
            ),
            body: Consumer<ConnectivityService>(
              // Check connectivity status and show appropriate Snackbar
              builder: (context, connectivityService, child) {
                Future.microtask(() {
                  if (!connectivityService.isFirstLaunch) {
                    if (!connectivityService.isOnline) {
                      showSnackbar(
                        "Sorry, it seems you're offline. Please check your internet connection.",
                        Colors.red,
                      );
                    } else {
                      showSnackbar(
                        'Welcome back! You are now online and ready to resume.',
                        Colors.green,
                      );
                    }
                  }
                });

                // Display the list of ProjectCard widgets
                return ListView.builder(
                  itemCount: projects.length,
                  itemBuilder: (context, index) {
                    return ProjectCard(project: projects[index]);
                  },
                );
              },
            ),
          );
  }
}
