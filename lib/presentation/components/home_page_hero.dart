// lib/presentation/home/components/home_page_hero.dart (NEW FILE)

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_portfolio/presentation/components/profile_card.dart';

import '../../core/utils/responsive.dart';
import '../../data/content/resume_content.dart';

class HomePageHero extends StatelessWidget {
  const HomePageHero({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Horizontal padding only applies to the scrollable content
    double horizontalPadding =
        ResponsiveLayout.isLargeScreen(context) ? 80 : 24;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Mobile/Tablet View needs the card shown here if not using the main Row
          if (!ResponsiveLayout.isLargeScreen(context)) const ProfileCard(),
          if (!ResponsiveLayout.isLargeScreen(context))
            const SizedBox(
              height: 40,
            ),

          // --- 1. LARGE HEADER TEXT (The 'SOFTWARE ENGINEER' section) ---
          Text(
            'SENIOR',
            style: theme.textTheme.displayLarge!.copyWith(
              fontSize: ResponsiveLayout.isLargeScreen(context) ? 90 : 60,
              fontWeight: FontWeight.w900,
              letterSpacing: 3,
            ),
          ),
          Text(
            'MOBILE DEVELOPER',
            style: theme.textTheme.displayLarge!.copyWith(
              fontSize: ResponsiveLayout.isLargeScreen(context) ? 90 : 60,
              fontWeight: FontWeight.w900,
              color: theme.colorScheme.secondary, // Subtle secondary color
              letterSpacing: 3,
            ),
          ),
          const SizedBox(height: 30),

          // --- 2. TAGLINE ---
          Text(
            'Passionate about creating intuitive and engaging user experiences. Specialized in transforming ideas into beautifully crafted, performant applications.',
            style: theme.textTheme.titleLarge!.copyWith(
              color: theme.textTheme.bodyMedium!.color,
              fontSize: ResponsiveLayout.isLargeScreen(context) ? 24 : 18,
            ),
          ),
          const SizedBox(height: 60),

          // --- 3. METRICS (The +12, +46 section) ---
          ResponsiveLayout.isLargeScreen(context)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _MetricItem(
                      value: '+8',
                      label: 'Years Experience',
                      theme: theme,
                    ),
                    _MetricItem(
                      value: '+15',
                      label: 'Projects Completed',
                      theme: theme,
                    ),
                    _MetricItem(
                      value: '+7',
                      label: 'Tech Stack Mastery',
                      theme: theme,
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _MetricItem(
                      value: '+8',
                      label: 'Years Experience',
                      theme: theme,
                    ),
                    const SizedBox(height: 20),
                    _MetricItem(
                      value: '+15',
                      label: 'Projects Completed',
                      theme: theme,
                    ),
                    const SizedBox(height: 20),
                    _MetricItem(
                      value: '+7',
                      label: 'Tech Stack Mastery',
                      theme: theme,
                    ),
                  ],
                ),
          const SizedBox(height: 60),

          const ExperienceSnippetCard(),
          const EducationSnippetCard(),

          // --- 6. SKILLS SUMMARY SNIPPET ---
          const SkillsSummarySnippet(),
        ],
      ),
    );
  }
}

// Helper widget for metrics
class _MetricItem extends StatelessWidget {
  final String value;
  final String label;
  final ThemeData theme;

  const _MetricItem(
      {required this.value, required this.label, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: theme.textTheme.displayLarge!.copyWith(
            fontSize: ResponsiveLayout.isLargeScreen(context) ? 48 : 36,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodyMedium,
        ),
      ],
    );
  }
}

// ------------------------------------------------------------------
// --- NEW WIDGET: HOME PAGE TIMELINE CARD STYLE (Based on image_63011f.jpg) ---
// ------------------------------------------------------------------
class HomeTimelineSnippetCard extends StatelessWidget {
  final String title; // Company Name / Institution
  final String subtitle; // Job Title / Degree
  final String duration;
  final String description;

  const HomeTimelineSnippetCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.duration,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      // Dark grey background, matching the aesthetic
      color: theme.cardTheme.color,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title (Large, Bold Text)
                Expanded(
                  child: Text(
                    title,
                    style: theme.textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.w900,
                      fontSize:
                          ResponsiveLayout.isLargeScreen(context) ? 28 : 24,
                    ),
                  ),
                ),
                // Corner Indicator/Arrow
                FaIcon(
                  FontAwesomeIcons.arrowUpRightFromSquare,
                  size: 16,
                  color: theme.colorScheme.primary.withOpacity(0.7),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Subtitle (Role/Degree)
            Text(
              subtitle,
              style: theme.textTheme.titleMedium!.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),

            // Description
            Text(
              description,
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),

            // Duration/Date
            Text(
              duration,
              style: theme.textTheme.bodySmall!.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------------------------------------------------------
// --- UPDATED SNIPPET WIDGETS TO USE HomeTimelineSnippetCard ---
// ------------------------------------------------------------------
class ExperienceSnippetCard extends StatelessWidget {
  const ExperienceSnippetCard({super.key});

  @override
  Widget build(BuildContext context) {
    final items = ResumeContent.experiences;
    items.sort((a, b) => b.duration.compareTo(a.duration));
    final latestExperience = items.isEmpty ? null : items.first;

    if (latestExperience == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeadlineSectionTitle(
            part1: 'Latest',
            part2: 'Experience',
            fontSize: 40,
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: HomeTimelineSnippetCard(
              // <-- REPLACED TimelineCard
              title: latestExperience.company,
              subtitle: latestExperience.title,
              duration: latestExperience.duration,
              description: latestExperience.description,
            ),
          ),
        ],
      ),
    );
  }
}

class EducationSnippetCard extends StatelessWidget {
  const EducationSnippetCard({super.key});

  @override
  Widget build(BuildContext context) {
    final items = ResumeContent.education;
    items.sort((a, b) => b.years.compareTo(a.years));

    final latestEducation = items.isEmpty ? null : items.first;

    if (latestEducation == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeadlineSectionTitle(
            part1: 'Recent',
            part2: 'Education',
            fontSize: 40,
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: HomeTimelineSnippetCard(
              // <-- REPLACED TimelineCard
              title: latestEducation.institution,
              subtitle: latestEducation.degree,
              duration: latestEducation.years,
              description:
                  latestEducation.description ?? 'No description provided.',
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------------------------------------------------------
// --- NEW WIDGET: SKILLS SUMMARY SNIPPET ---
// ------------------------------------------------------------------
class SkillsSummarySnippet extends StatelessWidget {
  const SkillsSummarySnippet({super.key});

  // Helper function to get an icon based on a skill category string
  IconData _getIconForCategory(String category) {
    if (category.toLowerCase().contains('language'))
      return FontAwesomeIcons.code;
    if (category.toLowerCase().contains('framework'))
      return FontAwesomeIcons.layerGroup;
    if (category.toLowerCase().contains('backend'))
      return FontAwesomeIcons.server;
    if (category.toLowerCase().contains('cloud')) return FontAwesomeIcons.cloud;
    return FontAwesomeIcons.tools;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    const universalAestheticColors = [
      Color(0xFF34D399), // Theme Primary (Energetic Teal/Green)
      Color(0xFF7C3AED), // Deep Berry (Professional Purple)
      Color(0xFFFBBF24), // Warm Gold (Sophisticated Yellow)
      Color(0xFF0EA5E9), // Sky Blue (Clean Technical Blue)
    ];

    // Get the first four skill categories for a compact summary
    final skillCategories = ResumeContent.skills.keys.take(4).toList();

    if (skillCategories.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 60),
        // NEW TITLE STYLE
        const HeadlineSectionTitle(
          part1: 'Core',
          part2: 'Tech Stack',
          fontSize: 40,
        ),
        const SizedBox(height: 30),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: skillCategories.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: ResponsiveLayout.isSmallScreen(context) ? 2 : 4,
            crossAxisSpacing: 20.0,
            mainAxisSpacing: 20.0,
            childAspectRatio: 1.0, // Square cards
          ),
          itemBuilder: (context, index) {
            final category = skillCategories[index];
            final skills = ResumeContent.skills[category]!.join(', ');
            final color = universalAestheticColors[
                index % universalAestheticColors.length];

            return _SkillSnippetCard(
              title: category,
              icon: _getIconForCategory(category),
              detail: skills,
              color: color,
            );
          },
        ),
      ],
    );
  }
}

// Inner Widget for the Skill Card look (based on image_63daf8.jpg)
class _SkillSnippetCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String detail;
  final Color color;

  const _SkillSnippetCard({
    required this.title,
    required this.icon,
    required this.detail,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      color: color,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FaIcon(icon, size: 24, color: theme.colorScheme.onPrimary),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleLarge!.copyWith(
                    color: theme.colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  detail,
                  style: theme.textTheme.bodySmall!.copyWith(
                    color: theme.colorScheme.onPrimary.withOpacity(0.8),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------------------------------------------------------
// --- NEW WIDGET: Reusable Headline Section Title ---
// ------------------------------------------------------------------
class HeadlineSectionTitle extends StatelessWidget {
  final String part1;
  final String part2;
  final double fontSize;

  const HeadlineSectionTitle({
    super.key,
    required this.part1,
    required this.part2,
    this.fontSize = 50, // Default size for main sections
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLarge = ResponsiveLayout.isLargeScreen(context);

    // Calculate responsive font size
    final responsiveFontSize = isLarge ? fontSize : fontSize * 0.7;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          part1.toUpperCase(),
          style: theme.textTheme.displayLarge!.copyWith(
            fontSize: responsiveFontSize,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
            // First part is subdued/faded
            color: theme.textTheme.bodyLarge!.color!.withOpacity(0.5),
          ),
        ),
        Text(
          part2.toUpperCase(),
          style: theme.textTheme.displayLarge!.copyWith(
            fontSize: responsiveFontSize,
            fontWeight: FontWeight.w900,
            // Second part is vibrant/highlighted
            color: theme.colorScheme.secondary,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }
}
