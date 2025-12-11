// lib/data/content/blogs_content.dart
import '../models/blog.dart';

class BlogsContent {
  static const List<Blog> blogs = [
    Blog(
      id: '1',
      title: 'The Future of Flutter Development',
      excerpt:
          'Exploring the roadmap of Flutter, Impeller engine, and what it means for cross-platform developers in 2024.',
      content: _dummyContent,
      author: 'John Doe',
      publishDate: 'Dec 12, 2023',
      readTime: '5 min read',
      imageUrl:
          'https://via.placeholder.com/800x400/0F172A/00BFA5?text=Flutter+Future',
      category: 'Tech',
      tags: ['Flutter', 'Mobile', 'Dart'],
    ),
    Blog(
      id: '2',
      title: 'Mastering State Management',
      excerpt:
          'A deep dive into Riverpod 2.0. Understanding providers, notifiers, and code generation for scalable apps.',
      content: _dummyContent,
      author: 'John Doe',
      publishDate: 'Nov 28, 2023',
      readTime: '8 min read',
      imageUrl:
          'https://via.placeholder.com/800x400/0F172A/7C3AED?text=State+Management',
      category: 'Tutorial',
      tags: ['Riverpod', 'Architecture'],
    ),
    Blog(
      id: '3',
      title: 'UI/UX Principles for Developers',
      excerpt:
          'How to think like a designer. Basic principles of spacing, typography, and color theory for engineers.',
      content: _dummyContent,
      author: 'John Doe',
      publishDate: 'Oct 15, 2023',
      readTime: '6 min read',
      imageUrl:
          'https://via.placeholder.com/800x400/0F172A/FBBF24?text=Design+Principles',
      category: 'Design',
      tags: ['UI/UX', 'Figma'],
    ),
    Blog(
      id: '4',
      title: 'From Junior to Senior Engineer',
      excerpt:
          'Lessons learned over 5 years of software engineering. Soft skills, mentorship, and technical growth.',
      content: _dummyContent,
      author: 'John Doe',
      publishDate: 'Sep 02, 2023',
      readTime: '10 min read',
      imageUrl:
          'https://via.placeholder.com/800x400/0F172A/0EA5E9?text=Career+Growth',
      category: 'Career',
      tags: ['Career', 'Soft Skills'],
    ),
  ];

  static const String _dummyContent = """
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.

### The Core Concept
Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

* **Efficiency**: Optimize your build times.
* **Scalability**: Plan for growth from day one.
* **Maintainability**: Write clean, documented code.

Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.
  """;
}
