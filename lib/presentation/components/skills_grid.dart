import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_portfolio/providers/portfolio_provider.dart';

import '../../core/utils/responsive.dart';

// --- NEW Aesthetic Color Palette (Consistent with Home Page) ---
const _kAestheticColors = [
  Color(0xFF34D399), // Teal (Theme Primary)
  Color(0xFF7C3AED), // Purple (Deep Berry)
  Color(0xFFFBBF24), // Gold (Warm Gold)
  Color(0xFF0EA5E9), // Blue (Sky Blue)
];

class SkillsGrid extends ConsumerWidget {
  final bool isSidebar;

  const SkillsGrid({super.key, this.isSidebar = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final portfolioAsync = ref.watch(portfolioProvider);

    return portfolioAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Text('Failed to load skills: $e'),
      data: (portfolio) {
        final skillCategories = portfolio.skills.keys.toList();

        int crossAxisCount = isSidebar
            ? 1
            : (ResponsiveLayout.isLargeScreen(context)
                ? 4
                : (ResponsiveLayout.isSmallScreen(context) ? 1 : 2));

        final skillCards = skillCategories.asMap().entries.map((entry) {
          final index = entry.key;
          final category = entry.value;
          final skillList = portfolio.skills[category]!;

          final accentColor =
              _kAestheticColors[index % _kAestheticColors.length];

          return SkillCard(
            category: category,
            skills: skillList,
            accentColor: accentColor,
            isSidebar: isSidebar,
          );
        }).toList();

        // --- Single Column Layout ---
        if (crossAxisCount == 1) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: skillCards,
          );
        }

        // --- Multi-Column Layout ---
        return LayoutBuilder(
          builder: (context, constraints) {
            const spacing = 32.0;
            final totalSpacing = (crossAxisCount - 1) * spacing;
            final cardWidth =
                (constraints.maxWidth - totalSpacing) / crossAxisCount;

            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: skillCards.map((card) {
                return SizedBox(width: cardWidth, child: card);
              }).toList(),
            );
          },
        );
      },
    );
  }
}

class SkillCard extends StatelessWidget {
  final String category;
  final List<String> skills;
  final Color accentColor;
  final bool isSidebar; // Re-introduced property for responsiveness

  const SkillCard({
    super.key,
    required this.category,
    required this.skills,
    required this.accentColor,
    this.isSidebar = false, // Default value
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Adjust padding based on whether it's in the narrow sidebar
    final double cardPadding = isSidebar ? 12.0 : 24.0;

    return Card(
      elevation: 8,
      color: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(cardPadding), // Dynamic Padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // Since the SkillCard determines its height by its children,
          // we only need to ensure the Wrap is here
          children: [
            Text(
              category,
              style: theme.textTheme.titleLarge!.copyWith(
                color: accentColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(height: 25, thickness: 1.5, color: Color(0xFF424242)),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: skills
                  .map((skill) => _SkillChip(
                        skill: skill,
                        chipColor: accentColor,
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkillChip extends StatelessWidget {
  final String skill;
  final Color chipColor; // NEW PROPERTY

  const _SkillChip({required this.skill, required this.chipColor});

  IconData _getIconForSkill(String skill) {
    final s = skill.toLowerCase();

    // --- Mobile / Frameworks ---
    if (s.contains('flutter')) return FontAwesomeIcons.bolt;
    if (s.contains('android')) return FontAwesomeIcons.android;

    // --- Programming Languages ---
    if (s == 'dart') return FontAwesomeIcons.code;
    if (s == 'java') return FontAwesomeIcons.java;
    if (s == 'kotlin') return FontAwesomeIcons.code;
    if (s == 'php') return FontAwesomeIcons.php;

    // --- Backend / APIs ---
    if (s.contains('laravel')) return FontAwesomeIcons.server;
    if (s.contains('rest')) return FontAwesomeIcons.networkWired;
    if (s.contains('json')) return FontAwesomeIcons.code;

    // --- Version Control ---
    if (s.contains('git')) return FontAwesomeIcons.gitAlt;
    if (s.contains('sourcetree')) return FontAwesomeIcons.codeBranch;

    // --- Tools ---
    if (s.contains('android studio')) return FontAwesomeIcons.mobileScreen;
    if (s.contains('postman')) return FontAwesomeIcons.paperPlane;
    if (s.contains('excel')) return FontAwesomeIcons.fileExcel;
    if (s.contains('word')) return FontAwesomeIcons.fileWord;
    if (s.contains('powerpoint')) return FontAwesomeIcons.filePowerpoint;

    // --- Architecture / Practices ---
    if (s.contains('mvvm')) return FontAwesomeIcons.layerGroup;
    if (s.contains('scrum') || s.contains('agile')) {
      return FontAwesomeIcons.peopleGroup;
    }

    // --- Payments / Services ---
    if (s.contains('esewa') || s.contains('khalti')) {
      return FontAwesomeIcons.creditCard;
    }
    if (s.contains('google maps')) return FontAwesomeIcons.mapLocationDot;

    // --- Testing ---
    if (s.contains('testing')) return FontAwesomeIcons.vial;

    // --- Default fallback ---
    return FontAwesomeIcons.microchip;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Calculate a slightly darker color for the chip background
    final chipBackgroundColor = chipColor.withOpacity(0.05);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: chipBackgroundColor, // Use accent-derived color for background
        borderRadius: BorderRadius.circular(20), // Highly rounded, pill shape
        border: Border.all(
            color: chipColor.withOpacity(0.4),
            width: 1), // Subtle accent border
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min, // Essential for Wrap layout
        children: [
          // Icon on the left
          FaIcon(
            _getIconForSkill(skill),
            size: 12,
            color: chipColor,
          ),
          const SizedBox(width: 8),
          // Text
          Text(
            skill,
            style: theme.textTheme.labelSmall!.copyWith(
              // Using the monospace Fira Code font for the tech tags
              fontFamily: 'Fira Code',
              fontSize: 12,
              color: chipColor, // Use accent color for text
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
