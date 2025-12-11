// lib/models/blog.dart
class Blog {
  final String id;
  final String title;
  final String excerpt;
  final String content; // In a real app, this might be Markdown or HTML
  final String author;
  final String publishDate;
  final String readTime;
  final String imageUrl;
  final String category;
  final List<String> tags;

  const Blog({
    required this.id,
    required this.title,
    required this.excerpt,
    required this.content,
    required this.author,
    required this.publishDate,
    required this.readTime,
    required this.imageUrl,
    required this.category,
    required this.tags,
  });
}