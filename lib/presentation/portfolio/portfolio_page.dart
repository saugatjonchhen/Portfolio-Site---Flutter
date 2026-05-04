import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:my_portfolio/core/theme/app_theme.dart';

import '../../core/utils/responsive.dart';
import '../../data/models/project.dart';
import '../../providers/portfolio_provider.dart';
import '../components/app_bar_widget.dart';
import '../components/footer.dart';

class PortfolioPage extends ConsumerStatefulWidget {
  const PortfolioPage({super.key});

  @override
  ConsumerState<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends ConsumerState<PortfolioPage> {
  // State for filtering
  String _selectedCategory = 'All';

  // Get unique categories from project list + 'All'
  List<String> _categoriesFrom(List<Project> projects) {
    final allTags = projects.expand((p) => p.tags).toSet();
    return ['All', ...allTags.toList()..sort()];
  }

  List<Project> _filteredProjectsFrom(List<Project> projects) {
    if (_selectedCategory == 'All') return projects;
    return projects.where((p) => p.tags.contains(_selectedCategory)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final portfolioAsync = ref.watch(portfolioProvider);
    double horizontalPadding =
        ResponsiveLayout.isSmallScreen(context) ? 24 : 80;

    return Scaffold(
      appBar: const AppNavBar(),
      endDrawer: const AppDrawer(),
      body: portfolioAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Failed to load projects: $e')),
        data: (portfolio) {
          final projects = portfolio.projects;
          final categories = _categoriesFrom(projects);
          final filteredProjects = _filteredProjectsFrom(projects);

          return SingleChildScrollView(
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
                        'Featured Projects',
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(fontSize: 48),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'A collection of applications and tools I\'ve built.',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // --- FILTER TABS ---
                // Remove the SizedBox to allow the container to grow vertically
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Wrap(
                    spacing: 12, // Horizontal space between the tabs
                    runSpacing: 12, // Vertical space between the lines
                    alignment: WrapAlignment.start, // Align to the left
                    children: categories.map((category) {
                      return _FilterTab(
                        label: category,
                        isSelected: category == _selectedCategory,
                        onTap: () => setState(() {
                          _selectedCategory = category;
                        }),
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 40),

                // --- PROJECT GRID ---
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: _ProjectGrid(projects: filteredProjects),
                ),

                const SizedBox(height: 100),
                const Footer(),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}

// --- WIDGET: Responsive Grid Layout ---
class _ProjectGrid extends StatelessWidget {
  final List<Project> projects;

  const _ProjectGrid({required this.projects});

  @override
  Widget build(BuildContext context) {
    if (projects.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Text(
            'No projects found for this category.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        // Determine columns
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
          children: projects.map((project) {
            return SizedBox(
              width: cardWidth,
              // Card height is determined by content
              child: _ProjectCard(project: project),
            );
          }).toList(),
        );
      },
    );
  }
}

// --- WIDGET: Project Card ---
class _ProjectCard extends StatefulWidget {
  final Project project;

  const _ProjectCard({required this.project});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
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
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        transform: _isHovered
            ? (Matrix4.identity()
              ..translate(0.0, -12.0, 0.0)
              ..scale(1.02))
            : Matrix4.identity(),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                color: glassSurface,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: _isHovered
                      ? theme.colorScheme.primary.withValues(alpha: 0.3)
                      : glassBorder.withValues(alpha: 0.1),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: _isHovered ? 0.2 : 0.1),
                    blurRadius: _isHovered ? 40 : 20,
                    offset: Offset(0, _isHovered ? 20 : 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. IMAGE & LABEL
                  Stack(
                    children: [
                      // Image
                      Hero(
                        tag: 'project-${project.id}',
                        child: Container(
                          height: 220,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withValues(alpha: 0.05),
                          ),
                          child: project.imageUrl != null
                              ? Image.network(
                                  project.imageUrl!,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: theme.colorScheme.surface,
                                      child: Icon(Icons.language,
                                          color: theme.colorScheme.primary),
                                    );
                                  },
                                )
                              : Center(
                                  child: Icon(
                                    Icons.code,
                                    size: 50,
                                    color: theme.colorScheme.primary.withValues(alpha: 0.5),
                                  ),
                                ),
                        ),
                      ),

                      // Overlay Gradient
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withValues(alpha: 0.4),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // "Client/Company" Floating Badge
                      if (project.client != null)
                        Positioned(
                          top: 16,
                          right: 16,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primary.withValues(alpha: 0.8),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.white24),
                                ),
                                child: Text(
                                  project.client!.toUpperCase(),
                                  style: theme.textTheme.labelSmall!.copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: theme.colorScheme.onPrimary,
                                    letterSpacing: 1,
                                  ),
                                ),
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
                        Text(
                          project.title,
                          style: theme.textTheme.headlineSmall!.copyWith(
                            fontWeight: FontWeight.w900,
                            fontSize: 22,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          project.description,
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                            height: 1.5,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 24),

                        // Tech Stack Chips
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: project.tags.take(4).map((tech) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary.withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: theme.colorScheme.primary.withValues(alpha: 0.15)),
                              ),
                              child: Text(
                                tech,
                                style: theme.textTheme.labelSmall!.copyWith(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 11,
                                ),
                              ),
                            );
                          }).toList(),
                        ),

                        const SizedBox(height: 28),
                        const Divider(thickness: 1),
                        const SizedBox(height: 12),

                        // Actions (Code & Demo)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (project.sourceUrl != null)
                              TextButton.icon(
                                onPressed: () {
                                  launchUrl(Uri.parse(project.sourceUrl!));
                                },
                                icon: const FaIcon(FontAwesomeIcons.github, size: 18),
                                label: const Text('Source Code'),
                                style: TextButton.styleFrom(
                                  foregroundColor: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                                  textStyle: const TextStyle(fontWeight: FontWeight.w600),
                                ),
                              )
                            else
                              const SizedBox(),

                            if (project.demoUrl != null)
                              ElevatedButton.icon(
                                onPressed: () {
                                  launchUrl(Uri.parse(project.demoUrl!));
                                },
                                icon: const FaIcon(
                                  FontAwesomeIcons.arrowUpRightFromSquare,
                                  size: 14,
                                ),
                                label: const Text('Live Demo'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: theme.colorScheme.secondary,
                                  foregroundColor: theme.colorScheme.onSecondary,
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                          ],
                        )
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
}

// --- WIDGET: Filter Tab (Pill Shape) ---
class _FilterTab extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterTab({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primary
              : theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected ? theme.colorScheme.primary : theme.dividerColor,
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          style: theme.textTheme.labelLarge!.copyWith(
            color: isSelected
                ? theme.colorScheme.onPrimary
                : theme.textTheme.bodyMedium!.color,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
