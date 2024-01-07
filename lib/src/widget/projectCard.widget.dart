import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fund/src/model/project.model.dart';
import 'package:intl/intl.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

class ProjectCard extends StatefulWidget {
  final Project project;

  // Constructor to initialize the widget with a project
  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  List<String> images = [];
  late int collectedValue;
  late int totalValue;
  late double percentage;
  late ValueNotifier<double> valueNotifier;
  late String startDate;
  late String endDate;

  @override
  void initState() {
    super.initState();

    // Extract and set initial values from the project
    if (widget.project.mainImageURL is List<String>) {
      images.addAll(widget.project.mainImageURL as Iterable<String>);
    } else {
      images.add(widget.project.mainImageURL);
    }
    collectedValue = widget.project.collectedValue;
    totalValue = widget.project.totalValue;
    percentage = (collectedValue / totalValue) * 100.0;
    valueNotifier = ValueNotifier(percentage);
    startDate = formattedDate(widget.project.startDate);
    endDate = formattedDate(widget.project.endDate);
  }

  // Helper method to format date
  String formattedDate(String inputDate) {
    DateTime dateTime = DateFormat("MM/dd/yyyy").parse(inputDate);

    String formattedDate = DateFormat('d\'th\' MMM yyyy').format(dateTime);

    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 250,
            width: 500,
            child: images.isNotEmpty
                ? Stack(
                    children: [
                      // Image carousel using PageView.builder
                      PageView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: images.length,
                        itemBuilder: (context, index) {
                          // Cached network image with error handling
                          return CachedNetworkImage(
                            imageUrl: images[index],
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      // Project information overlay
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Project title
                              Text(
                                widget.project.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              // Project short description
                              Text(
                                widget.project.shortDescription,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : const Center(
                    child: Text('No images available'),
                  ),
          ),
          // Funding information section
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 10,
                ),
                // Circular progress bar showing fundraising percentage
                SimpleCircularProgressBar(
                  valueNotifier: valueNotifier,
                  size: 70,
                  backStrokeWidth: 7,
                  progressStrokeWidth: 7,
                  progressColors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor
                  ],
                  backColor: Colors.black.withOpacity(0.4),
                  mergeMode: true,
                  onGetText: (double value) {
                    // Display fundraising percentage as text
                    return Text(
                      '${value.toInt()}%',
                      style: Theme.of(context).textTheme.titleLarge,
                    );
                  },
                ),
                const SizedBox(
                  width: 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text displaying the amount raised
                    Text(
                      "Raised",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    // Text showing the collected and total values
                    Text.rich(
                      TextSpan(
                        text: 'Rs.$collectedValue',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: Theme.of(context).primaryColor),
                        children: [
                          TextSpan(
                            text: ' of Rs.$totalValue',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                    // Text displaying the project date range
                    Text("$startDate - $endDate"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
