class Experience {
  final String title;
  final String company;
  final String duration;
  final String description;
  final String seniorityLevel;
  final List<String> achievements;

  Experience({
    required this.title,
    required this.company,
    required this.duration,
    required this.description,
    required this.seniorityLevel,
    required this.achievements,
  });

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      title: json['title'],
      company: json['company'],
      duration: json['duration'],
      description: json['description'],
      seniorityLevel: json['seniorityLevel'],
      achievements: List<String>.from(json['achievements']),
    );
  }
}
