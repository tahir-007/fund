import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProjectCard extends StatefulWidget {
  final Map<String, dynamic> project;

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  List<String> images = [];

  @override
  void initState() {
    super.initState();
    // Check if 'mainImageURL' is a string or a list of strings
    if (widget.project['mainImageURL'] is String) {
      images.add(widget.project['mainImageURL']);
    } else if (widget.project['mainImageURL'] is List<String>) {
      images.addAll(widget.project['mainImageURL']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(widget.project['title']),
            subtitle: Text(widget.project['shortDescription']),
          ),
          SizedBox(
            height: 150,
            child: images.isNotEmpty // Check if 'images' is not empty
                ? PageView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      return CachedNetworkImage(
                        imageUrl: images[index],
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      );
                    },
                  )
                : const Center(
                    child: Text('No images available'),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Collected Value: ${widget.project['collectedValue']}'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Total Value: ${widget.project['totalValue']}'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Start Date: ${widget.project['startDate']}'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('End Date: ${widget.project['endDate']}'),
          ),
        ],
      ),
    );
  }
}
