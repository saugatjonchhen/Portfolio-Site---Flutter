class Project {
  final String id;
  final String title;
  final String description;
  final List<String> tags;
  final String? imageUrl;
  final String? demoUrl;
  final String? sourceUrl;
  final String? client; // NEW: To show "Freelance", "Company Name", etc.

  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.tags,
    this.imageUrl,
    this.demoUrl,
    this.sourceUrl,
    this.client,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      tags: List<String>.from(json['tags']),
      imageUrl: json['imageUrl'],
      demoUrl: json['demoUrl'],
      sourceUrl: json['sourceUrl'],
      client: json['client'],
    );
  }
}