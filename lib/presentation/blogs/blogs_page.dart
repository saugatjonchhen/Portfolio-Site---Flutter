import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../core/utils/responsive.dart';
import '../../data/content/blog_content.dart';
import '../../data/models/blog.dart';
import '../components/app_bar_widget.dart';
import '../components/footer.dart';
import '../home_page.dart';

class BlogsPage extends StatelessWidget {
  const BlogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    double horizontalPadding =
        ResponsiveLayout.isSmallScreen(context) ? 24 : 80;

    return Scaffold(
      appBar: const AppNavBar(),
      endDrawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),

            // --- HEADER ---
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Latest Articles',
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .copyWith(fontSize: 48),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Thoughts, tutorials, and insights on development.',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 60),

            // --- BLOG GRID ---
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: const _BlogGrid(),
            ),

            const SizedBox(height: 100),
            const Footer(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _BlogGrid extends StatelessWidget {
  const _BlogGrid();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = ResponsiveLayout.isLargeScreen(context)
            ? 3
            : (ResponsiveLayout.isMediumScreen(context) ? 2 : 1);

        double spacing = 32.0;
        double totalSpacing = (crossAxisCount - 1) * spacing;
        double cardWidth =
            (constraints.maxWidth - totalSpacing) / crossAxisCount;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: BlogsContent.blogs.map((blog) {
            return SizedBox(
              width: cardWidth,
              child: _BlogCard(blog: blog),
            );
          }).toList(),
        );
      },
    );
  }
}

class _BlogCard extends StatefulWidget {
  final Blog blog;

  const _BlogCard({required this.blog});

  @override
  State<_BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<_BlogCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final blog = widget.blog;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          // NAVIGATE TO DETAIL PAGE
          context.go('/blogs/${blog.id}');
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: _isHovered
              ? (Matrix4.identity()..translate(0, -8, 0))
              : Matrix4.identity(),
          child: Card(
            elevation: _isHovered ? 12 : 4,
            color: theme.colorScheme.surface,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. IMAGE
                Stack(
                  children: [
                    Container(
                      height: 220,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withOpacity(0.1),
                        image: DecorationImage(
                          image: NetworkImage(blog.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Category Badge
                    Positioned(
                      top: 16,
                      left: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          blog.category.toUpperCase(),
                          style: theme.textTheme.labelSmall!.copyWith(
                            color: theme.colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // 2. CONTENT
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Date & Read Time
                      Row(
                        children: [
                          Icon(FontAwesomeIcons.calendar,
                              size: 12,
                              color: theme.textTheme.bodySmall!.color),
                          const SizedBox(width: 6),
                          Text(blog.publishDate,
                              style: theme.textTheme.bodySmall),
                          const SizedBox(width: 12),
                          Icon(FontAwesomeIcons.clock,
                              size: 12,
                              color: theme.textTheme.bodySmall!.color),
                          const SizedBox(width: 6),
                          Text(blog.readTime, style: theme.textTheme.bodySmall),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Title
                      Text(
                        blog.title,
                        style: theme.textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 12),

                      // Excerpt
                      Text(
                        blog.excerpt,
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: theme.textTheme.bodyMedium!.color!
                              .withOpacity(0.7),
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 20),

                      // "Read More" Link
                      Row(
                        children: [
                          Text(
                            'Read Article',
                            style: theme.textTheme.titleSmall!.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            FontAwesomeIcons.arrowRight,
                            size: 12,
                            color: theme.colorScheme.primary,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
