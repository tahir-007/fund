class Project {
  final int id;
  final String title;
  final String shortDescription;
  final int collectedValue;
  final int totalValue;
  final String startDate;
  final String endDate;
  final String mainImageURL;

  // Constructor to initialize Project instance with required properties
  Project({
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.collectedValue,
    required this.totalValue,
    required this.startDate,
    required this.endDate,
    required this.mainImageURL,
  });

  // Factory method to create a Project instance from a JSON map
  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['Id'] ?? 0,
      title: json['title'] ?? '',
      shortDescription: json['shortDescription'] ?? '',
      collectedValue: json['collectedValue'] ?? 0,
      totalValue: json['totalValue'] ?? 0,
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      mainImageURL: json['mainImageURL'] ?? '',
    );
  }
}
