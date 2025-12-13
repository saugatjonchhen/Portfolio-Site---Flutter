import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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
                SizedBox(
                  height: 50,
                  child: ListView.separated(
                    padding:
                        EdgeInsets.symmetric(horizontal: horizontalPadding),
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return _FilterTab(
                        label: category,
                        isSelected: category == _selectedCategory,
                        onTap: () => setState(() {
                          _selectedCategory = category;
                        }),
                      );
                    },
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

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: _isHovered
            ? (Matrix4.identity()..translate(0, -8, 0)) // Lift up effect
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
              // 1. IMAGE & LABEL
              Stack(
                children: [
                  // Image
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(0.1),
                      image: project.imageUrl != null
                          ? DecorationImage(
                              image: NetworkImage(project.imageUrl!),
                              // Replace with AssetImage if local
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    // Fallback icon if no image
                    child: project.imageUrl == null
                        ? Center(
                            child: Icon(
                              Icons.code,
                              size: 50,
                              color: theme.colorScheme.primary,
                            ),
                          )
                        : null,
                  ),

                  // "Client/Company" Floating Badge
                  if (project.client != null)
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.background,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white24),
                        ),
                        child: Text(
                          project.client!,
                          style: theme.textTheme.labelSmall!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),

              // 2. CONTENT
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.title,
                      style: theme.textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      project.description,
                      style: theme.textTheme.bodyMedium!.copyWith(
                        color:
                            theme.textTheme.bodyMedium!.color!.withOpacity(0.8),
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 20),

                    // Tech Stack Chips
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: project.tags.take(4).map((tech) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                                color:
                                    theme.colorScheme.primary.withOpacity(0.2)),
                          ),
                          child: Text(
                            tech,
                            style: theme.textTheme.labelSmall!.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Fira Code', // Tech font
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 10),

                    // Actions (Code & Demo)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (project.sourceUrl != null)
                          TextButton.icon(
                            onPressed: () {
                              // launchUrl(Uri.parse(project.sourceUrl!));
                            },
                            icon:
                                const FaIcon(FontAwesomeIcons.github, size: 16),
                            label: const Text('Code'),
                            style: TextButton.styleFrom(
                              foregroundColor:
                                  theme.textTheme.bodyMedium!.color,
                            ),
                          )
                        else
                          const SizedBox(), // Spacer if no code link

                        if (project.demoUrl != null)
                          TextButton.icon(
                            onPressed: () {
                              launchUrl(Uri.parse(project.demoUrl!));
                            },
                            icon: const FaIcon(
                              FontAwesomeIcons.arrowUpRightFromSquare,
                              size: 16,
                            ),
                            label: const Text('Live Demo'),
                            style: TextButton.styleFrom(
                              foregroundColor: theme.colorScheme.primary,
                            ),
                          )
                        else
                          TextButton.icon(
                            onPressed: () {
                              // launchUrl(Uri.parse(project.demoUrl!));
                            },
                            icon: null,
                            label: const Text(''),
                            style: TextButton.styleFrom(
                              foregroundColor: theme.colorScheme.primary,
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
