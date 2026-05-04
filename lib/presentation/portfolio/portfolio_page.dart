import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:my_portfolio/core/theme/app_theme.dart';

import '../../core/utils/responsive.dart';
import '../../data/models/project.dart';
import '../../providers/portfolio_provider.dart';
import '../components/project_card.dart';
import '../components/app_bar_widget.dart';
import '../components/footer.dart';
import '../components/custom_scrollbar.dart';

class PortfolioPage extends ConsumerStatefulWidget {
  const PortfolioPage({super.key});

  @override
  ConsumerState<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends ConsumerState<PortfolioPage> {
  // State for filtering
  String _selectedCategory = 'All';
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
      appBar: AppNavBar(),
      endDrawer: AppDrawer(),
      body: portfolioAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Failed to load projects: $e')),
        data: (portfolio) {
          final projects = portfolio.projects;
          final categories = _categoriesFrom(projects);
          final filteredProjects = _filteredProjectsFrom(projects);

          return CustomScrollbar(
            controller: _scrollController,
            child: SingleChildScrollView(
              controller: _scrollController,
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
                  Footer(),
                  const SizedBox(height: 20),
                ],
              ),
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
              child: ProjectCard(project: project),
            );
          }).toList(),
        );
      },
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
