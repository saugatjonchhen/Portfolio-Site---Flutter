import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../core/utils/responsive.dart';
import '../../data/content/blog_content.dart';
import '../../data/models/blog.dart';
import '../components/app_bar_widget.dart';
import '../components/footer.dart';

class BlogDetailPage extends StatelessWidget {
  final String blogId;

  const BlogDetailPage({super.key, required this.blogId});

  @override
  Widget build(BuildContext context) {
    // 1. Find the blog post
    final Blog? blog = BlogsContent.blogs.cast<Blog?>().firstWhere(
          (b) => b!.id == blogId,
          orElse: () => null,
        );

    // Handle not found
    if (blog == null) {
      return Scaffold(
        appBar: const AppNavBar(),
        body: const Center(child: Text('Blog post not found')),
      );
    }

    // Responsive padding - narrower reading column on desktop
    double horizontalPadding = ResponsiveLayout.isSmallScreen(context)
        ? 24
        : MediaQuery.of(context).size.width *
            0.2; // 20% padding on each side for desktop

    return Scaffold(
      appBar: const AppNavBar(),
      endDrawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- HERO IMAGE ---
            Container(
              height: 400,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(blog.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),

            // --- CONTENT COLUMN ---
            Transform.translate(
              offset: const Offset(0, -60),
              // Pull up content slightly over image
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal:
                        ResponsiveLayout.isSmallScreen(context) ? 16 : 0),
                padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding, vertical: 40),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(20), // Rounded top
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Meta Data
                    Row(
                      children: [
                        _MetaTag(
                            icon: FontAwesomeIcons.calendar,
                            text: blog.publishDate),
                        const SizedBox(width: 20),
                        _MetaTag(
                            icon: FontAwesomeIcons.clock, text: blog.readTime),
                        const SizedBox(width: 20),
                        _MetaTag(
                            icon: FontAwesomeIcons.tag, text: blog.category),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Title
                    Text(
                      blog.title,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                    ),
                    const SizedBox(height: 16),

                    // Author
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          child: Icon(FontAwesomeIcons.user,
                              size: 14,
                              color: Theme.of(context).colorScheme.onPrimary),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Written by ${blog.author}',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),
                    const Divider(),
                    const SizedBox(height: 40),

                    // BODY CONTENT (Simple styling for now)
                    Text(
                      blog.content,
                      // Displays the raw text (or Markdown if you add the package)
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            height: 1.8, // Good line height for reading
                            fontSize: 18,
                            color: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .color!
                                .withOpacity(0.9),
                          ),
                    ),

                    const SizedBox(height: 60),

                    // Tags
                    Wrap(
                      spacing: 12,
                      children: blog.tags
                          .map((tag) => Chip(
                                label: Text('#$tag'),
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.1),
                                labelStyle: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ))
                          .toList(),
                    ),

                    const SizedBox(height: 40),

                    // Back Button
                    OutlinedButton.icon(
                      onPressed: () => context.go('/blogs'),
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Back to Articles'),
                    ),
                  ],
                ),
              ),
            ),

            const Footer(),
          ],
        ),
      ),
    );
  }
}

class _MetaTag extends StatelessWidget {
  final IconData icon;
  final String text;

  const _MetaTag({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 8),
        Text(
          text,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
