// lib/presentation/home/components/home_page_hero.dart (NEW FILE)

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:my_portfolio/data/models/education.dart';
import 'package:my_portfolio/data/models/experience.dart';
import 'package:my_portfolio/presentation/components/profile_card.dart';
import 'package:my_portfolio/core/theme/app_theme.dart';

import '../../core/utils/responsive.dart';
import '../../data/content/resume_content.dart';
import '../../providers/portfolio_provider.dart';

class HomePageHero extends ConsumerWidget {
  const HomePageHero({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final resumeAsync = ref.watch(portfolioProvider);

    // Horizontal padding only applies to the scrollable content
    double horizontalPadding =
        ResponsiveLayout.isLargeScreen(context) ? 80 : 24;

    return resumeAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error loading data: $err')),
        data: (resumeData) {
          final latestExp = resumeData.experience.isNotEmpty
              ? resumeData.experience.first
              : null;
          final latestEdu = resumeData.education.isNotEmpty
              ? resumeData.education.first
              : null;

          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: 40,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Mobile/Tablet View needs the card shown here if not using the main Row
                if (!ResponsiveLayout.isLargeScreen(context))
                  const ProfileCard()
                      .animate(onPlay: (controller) => controller.repeat(reverse: true))
                      .moveY(begin: 0, end: -10, duration: 2.seconds, curve: Curves.easeInOut)
                      .fadeIn(duration: 600.ms),
                if (!ResponsiveLayout.isLargeScreen(context))
                  const SizedBox(
                    height: 40,
                  ),

                // --- 1. LARGE HEADER TEXT ---
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SENIOR',
                      style: theme.textTheme.displayLarge!.copyWith(
                        fontSize:
                            ResponsiveLayout.isLargeScreen(context) ? 90 : 60,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 3,
                        color: theme.colorScheme.onSurface.withOpacity(0.5),
                      ),
                    ),
                    Text(
                      'MOBILE DEVELOPER',
                      style: theme.textTheme.displayLarge!.copyWith(
                        fontSize:
                            ResponsiveLayout.isLargeScreen(context) ? 90 : 60,
                        fontWeight: FontWeight.w900,
                        color: theme.colorScheme.secondary,
                        letterSpacing: 3,
                      ),
                    ),
                  ],
                ).animate().fadeIn(duration: 800.ms).moveX(begin: -30, end: 0),

                const SizedBox(height: 30),

                // --- 2. TAGLINE ---
                Text(
                  'Passionate about creating intuitive and engaging user experiences. Specialized in transforming ideas into beautifully crafted, performant applications.',
                  style: theme.textTheme.titleLarge!.copyWith(
                    color: theme.textTheme.bodyMedium!.color,
                    fontSize: ResponsiveLayout.isLargeScreen(context) ? 24 : 18,
                    height: 1.5,
                  ),
                )
                    .animate(delay: 200.ms)
                    .fadeIn(duration: 800.ms)
                    .moveY(begin: 20, end: 0),

                const SizedBox(height: 60),

                // --- 3. METRICS ---
                (ResponsiveLayout.isLargeScreen(context)
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _MetricItem(
                                value: resumeData.yearsWorked,
                                suffix: '+',
                                label: 'Years Experience',
                                theme: theme,
                              ),
                              _MetricItem(
                                value: resumeData.projects.length,
                                suffix: '+',
                                label: 'Projects Completed',
                                theme: theme,
                              ),
                              _MetricItem(
                                value: resumeData.masteryCount,
                                suffix: '+',
                                label: 'Tech Stack',
                                theme: theme,
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _MetricItem(
                                value: resumeData.yearsWorked,
                                suffix: '+',
                                label: 'Years Experience',
                                theme: theme,
                              ),
                              _MetricItem(
                                value: resumeData.projects.length,
                                suffix: '+',
                                label: 'Projects Completed',
                                theme: theme,
                              ),
                              _MetricItem(
                                value: resumeData.masteryCount,
                                suffix: '+',
                                label: 'Tech Stack',
                                theme: theme,
                              ),
                            ],
                          ))
                    .animate(delay: 400.ms)
                    .fadeIn(duration: 800.ms)
                    .scale(begin: const Offset(0.95, 0.95)),

                const SizedBox(height: 80),

                ExperienceSnippetCard(latestExp)
                    .animate(delay: 600.ms)
                    .fadeIn(duration: 800.ms)
                    .moveY(begin: 30, end: 0),

                EducationSnippetCard(latestEdu)
                    .animate(delay: 800.ms)
                    .fadeIn(duration: 800.ms)
                    .moveY(begin: 30, end: 0),

                // --- 6. SKILLS SUMMARY SNIPPET ---
                const SkillsSummarySnippet()
                    .animate(delay: 1000.ms)
                    .fadeIn(duration: 800.ms),
              ],
            ),
          );
        });
  }
}

// Helper widget for metrics
class _MetricItem extends StatelessWidget {
  final int value;
  final String suffix;
  final String label;
  final ThemeData theme;

  const _MetricItem({
    required this.value,
    required this.suffix,
    required this.label,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: value.toDouble()),
          duration: const Duration(seconds: 2),
          curve: Curves.easeOutExpo,
          builder: (context, val, child) {
            return Text(
              '${val.toInt()}$suffix',
              style: theme.textTheme.displayLarge!.copyWith(
                fontSize: ResponsiveLayout.isLargeScreen(context) ? 48 : 36,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            );
          },
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
    final isDark = theme.brightness == Brightness.dark;

    final glassSurface =
        isDark ? AppTheme.glassSurfaceDark : AppTheme.glassSurfaceLight;
    final glassBorder =
        isDark ? AppTheme.glassBorderDark : AppTheme.glassBorderLight;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(28.0),
          decoration: BoxDecoration(
            color: glassSurface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: glassBorder.withOpacity(0.1),
              width: 1.5,
            ),
          ),
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
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                  // Corner Indicator/Arrow
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      context.go('/resume');
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.arrowUpRightFromSquare,
                      size: 16,
                      color: theme.colorScheme.primary.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Subtitle (Role/Degree)
              Text(
                subtitle,
                style: theme.textTheme.titleMedium!.copyWith(
                  color: theme.colorScheme.secondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 16),

              // Description
              Text(
                description,
                style: theme.textTheme.bodyLarge!.copyWith(
                  height: 1.6,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.9),
                ),
              ),
              const SizedBox(height: 20),

              // Duration/Date
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  duration,
                  style: theme.textTheme.bodySmall!.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ------------------------------------------------------------------
// --- UPDATED SNIPPET WIDGETS TO USE HomeTimelineSnippetCard ---
// ------------------------------------------------------------------
class ExperienceSnippetCard extends StatelessWidget {
  const ExperienceSnippetCard(this.latestExperience, {super.key});

  final Experience? latestExperience;

  @override
  Widget build(BuildContext context) {
    // final items = ResumeContent.experiences;
    // items.sort((a, b) => b.duration.compareTo(a.duration));
    // final latestExperience = items.isEmpty ? null : items.first;

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
              title: latestExperience?.title ?? "",
              subtitle: latestExperience?.company ?? "",
              duration: latestExperience?.duration ?? "",
              description: latestExperience?.description ?? "",
            ),
          ),
        ],
      ),
    );
  }
}

class EducationSnippetCard extends StatelessWidget {
  const EducationSnippetCard(this.latestEducation, {super.key});

  final Education? latestEducation;

  @override
  Widget build(BuildContext context) {
    // final items = ResumeContent.education;
    // items.sort((a, b) => b.years.compareTo(a.years));
    //
    // final latestEducation = items.isEmpty ? null : items.first;

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
              title: latestEducation?.institution ?? "",
              subtitle: latestEducation?.degree ?? "",
              duration: latestEducation?.years ?? "",
              description:
                  latestEducation?.description ?? 'No description provided.',
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
    if (category.toLowerCase().contains('language')) {
      return FontAwesomeIcons.code;
    }
    if (category.toLowerCase().contains('framework')) {
      return FontAwesomeIcons.layerGroup;
    }
    if (category.toLowerCase().contains('backend')) {
      return FontAwesomeIcons.server;
    }
    if (category.toLowerCase().contains('cloud')) {
      return FontAwesomeIcons.cloud;
    }
    return FontAwesomeIcons.screwdriverWrench;
  }

  @override
  Widget build(BuildContext context) {
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
                    color: theme.colorScheme.onPrimary.withValues(alpha: 0.8),
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
            color: theme.textTheme.bodyLarge!.color!.withValues(alpha: 0.5),
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
