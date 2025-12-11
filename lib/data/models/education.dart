class Education {
  final String degree;
  final String institution;
  final String years;
  final String? description;

  Education({
    required this.degree,
    required this.institution,
    required this.years,
    this.description,
  });
}