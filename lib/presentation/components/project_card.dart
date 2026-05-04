import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:my_portfolio/data/models/project.dart';
import 'package:my_portfolio/core/theme/app_theme.dart';

class ProjectCard extends StatefulWidget {
  final Project project;

  const ProjectCard({
    super.key,
    required this.project,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final project = widget.project;
    final isDark = theme.brightness == Brightness.dark;

    final glassSurface =
        isDark ? AppTheme.glassSurfaceDark : AppTheme.glassSurfaceLight;
    final glassBorder =
        isDark ? AppTheme.glassBorderDark : AppTheme.glassBorderLight;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
        transform: _isHovered
            ? (Matrix4.identity()
              ..translate(0.0, -12.0, 0.0)
              ..rotateX(0.02)
              ..rotateY(-0.02))
            : Matrix4.identity(),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              decoration: BoxDecoration(
                color: _isHovered
                    ? glassSurface.withOpacity(0.85)
                    : glassSurface.withOpacity(0.6),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: _isHovered
                      ? theme.colorScheme.primary.withOpacity(0.4)
                      : glassBorder.withOpacity(0.1),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.primary.withOpacity(_isHovered ? 0.15 : 0.05),
                    blurRadius: _isHovered ? 40 : 20,
                    offset: Offset(0, _isHovered ? 20 : 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. IMAGE SECTION
                  Stack(
                    children: [
                      Hero(
                        tag: 'project-${project.id}',
                        child: Container(
                          height: 220,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceVariant.withOpacity(0.5),
                          ),
                          child: project.imageUrl != null
                              ? Image.network(
                                  project.imageUrl!,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress.expectedTotalBytes != null
                                            ? loadingProgress.cumulativeBytesLoaded /
                                                loadingProgress.expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) =>
                                      _buildPlaceholder(theme),
                                )
                              : _buildPlaceholder(theme),
                        ),
                      ),
                      // Gradient Overlay
                      Positioned.fill(
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 300),
                          opacity: _isHovered ? 0.2 : 0.4,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.8),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Client Badge
                      if (project.client != null)
                        Positioned(
                          top: 16,
                          right: 16,
                          child: _buildBadge(theme, project.client!),
                        ),
                    ],
                  ),
                  // 2. CONTENT SECTION
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project.title,
                          style: theme.textTheme.titleLarge!.copyWith(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          project.description,
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.7),
                            height: 1.6,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 24),
                        // Tags
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: project.tags.take(3).map((tag) => _buildTag(theme, tag)).toList(),
                        ),
                        const SizedBox(height: 28),
                        Divider(color: theme.dividerColor, thickness: 1),
                        const SizedBox(height: 12),
                        // Actions
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (project.sourceUrl != null)
                              TextButton.icon(
                                onPressed: () => _launchURL(project.sourceUrl!),
                                icon: const FaIcon(FontAwesomeIcons.github, size: 18),
                                label: const Text('Code'),
                                style: TextButton.styleFrom(
                                  foregroundColor: theme.colorScheme.onSurface.withOpacity(0.6),
                                  textStyle: const TextStyle(fontWeight: FontWeight.w700),
                                ),
                              )
                            else
                              const SizedBox(),
                            if (project.demoUrl != null)
                              ElevatedButton.icon(
                                onPressed: () => _launchURL(project.demoUrl!),
                                icon: const FaIcon(FontAwesomeIcons.arrowUpRightFromSquare, size: 14),
                                label: const Text('Demo'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: theme.colorScheme.primary,
                                  foregroundColor: theme.colorScheme.onPrimary,
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
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
      ),
    );
  }

  Widget _buildPlaceholder(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            FontAwesomeIcons.code,
            size: 40,
            color: theme.colorScheme.primary.withOpacity(0.3),
          ),
          const SizedBox(height: 8),
          Text(
            'PROJECT PREVIEW',
            style: theme.textTheme.labelSmall!.copyWith(
              letterSpacing: 2,
              color: theme.colorScheme.primary.withOpacity(0.5),
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(ThemeData theme, String text) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withOpacity(0.85),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white24),
          ),
          child: Text(
            text.toUpperCase(),
            style: theme.textTheme.labelSmall!.copyWith(
              fontWeight: FontWeight.w900,
              color: theme.colorScheme.onPrimary,
              fontSize: 10,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTag(ThemeData theme, String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.colorScheme.primary.withOpacity(0.15)),
      ),
      child: Text(
        tag,
        style: theme.textTheme.labelSmall!.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.w700,
          fontSize: 11,
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}