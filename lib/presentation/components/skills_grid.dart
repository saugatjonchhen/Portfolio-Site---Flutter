import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/utils/responsive.dart';
import '../../data/content/resume_content.dart'; // Corrected path to resume_content

// --- NEW Aesthetic Color Palette (Consistent with Home Page) ---
const _kAestheticColors = [
  Color(0xFF34D399), // Teal (Theme Primary)
  Color(0xFF7C3AED), // Purple (Deep Berry)
  Color(0xFFFBBF24), // Gold (Warm Gold)
  Color(0xFF0EA5E9), // Blue (Sky Blue)
];

class SkillsGrid extends StatelessWidget {
  final bool isSidebar;

  const SkillsGrid({super.key, this.isSidebar = false});

  @override
  Widget build(BuildContext context) {
    final skillCategories = ResumeContent.skills.keys.toList();

    // 1. Determine the number of columns based on responsive rules
    int crossAxisCount = isSidebar
        ? 1
        : (ResponsiveLayout.isLargeScreen(context)
        ? 4
        : (ResponsiveLayout.isSmallScreen(context) ? 1 : 2));

    // 2. Create the list of SkillCard widgets
    List<Widget> skillCards = skillCategories.asMap().entries.map((entry) {
      int index = entry.key;
      String category = entry.value;
      List<String> skillList = ResumeContent.skills.values.elementAt(index);
      final cardAccentColor = _kAestheticColors[index % _kAestheticColors.length];

      return SkillCard(
        category: category,
        skills: skillList,
        accentColor: cardAccentColor,
        isSidebar: isSidebar, // Pass flag to card for padding
      );
    }).toList();

    // --- Single Column Layout (Mobile & Sidebar) ---
    // Use Column/ListView which naturally allows content-driven height.
    if (crossAxisCount == 1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: skillCards,
      );
    }

    // --- Multi-Column Layout (Desktop Grid) ---
    // Use LayoutBuilder and Wrap to simulate a variable-height grid.
    return LayoutBuilder(
      builder: (context, constraints) {
        const double spacing = 32.0;
        double totalSpacing = (crossAxisCount - 1) * spacing;
        // Calculate the exact width each card should occupy
        double cardWidth = (constraints.maxWidth - totalSpacing) / crossAxisCount;

        return Wrap(
          spacing: spacing, // Horizontal spacing
          runSpacing: spacing, // Vertical spacing
          children: skillCards.map((card) {
            return SizedBox(
              width: cardWidth,
              // The height is intentionally left out, allowing the card's content to define it
              child: card,
            );
          }).toList(),
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

  // A simple way to get a relevant-looking icon based on the skill name
  IconData _getIconForSkill(String skill) {
    final lowerSkill = skill.toLowerCase();
    if (lowerSkill.contains('flutter') || lowerSkill.contains('dart'))
      return FontAwesomeIcons.bolt;
    if (lowerSkill.contains('firebase') || lowerSkill.contains('cloud'))
      return FontAwesomeIcons.cloud;
    if (lowerSkill.contains('js') ||
        lowerSkill.contains('html') ||
        lowerSkill.contains('css')) return FontAwesomeIcons.code;
    if (lowerSkill.contains('testing')) return FontAwesomeIcons.vial;
    if (lowerSkill.contains('figma')) return FontAwesomeIcons.figma;
    if (lowerSkill.contains('python')) return FontAwesomeIcons.python;
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
