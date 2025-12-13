// lib/presentation/resume/resume_page.dart (FINALIZED CODE)

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/utils/responsive.dart';
import '../../data/content/resume_content.dart';
import '../../data/models/education.dart';
import '../../data/models/experience.dart';
import '../../providers/portfolio_provider.dart';
import '../components/app_bar_widget.dart';
import '../components/footer.dart';
import '../components/skills_grid.dart';
import '../components/timeline_card.dart';

class ResumePage extends ConsumerWidget {
  const ResumePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final portfolioAsync = ref.watch(portfolioProvider);

    double horizontalPadding =
        ResponsiveLayout.isSmallScreen(context) ? 24 : 100;
    final isSmall = ResponsiveLayout.isSmallScreen(context);

    return Scaffold(
        appBar: const AppNavBar(),
        endDrawer: const AppDrawer(),
        body: portfolioAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) =>
              Center(child: Text('Failed to load resume data: $e')),
          data: (portfolio) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),

                    // --- HEADER & DOWNLOAD BUTTON ---
                    isSmall
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'My Professional Resume',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(fontSize: 32),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: double.infinity,
                                child: _DownloadButton(),
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'My Professional Resume',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(fontSize: 48),
                              ),
                              _DownloadButton(),
                            ],
                          ),

                    const SizedBox(height: 60),

                    // 👇 PASS DATA HERE
                    ResumeContentLayout(
                      education: portfolio.education,
                      experience: portfolio.experience,
                    ),

                    const SizedBox(height: 80),
                    const Footer(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        ));
  }
}

// Extracted Download Button Widget for clean code
class _DownloadButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Starting file download... (Placeholder)')),
        );
      },
      icon: const FaIcon(FontAwesomeIcons.filePdf, size: 20),
      label: const Text('Download PDF'),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        // Reduced vertical padding from 24 to 12 for better visual balance
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        textStyle: Theme.of(context).textTheme.titleSmall,
      ),
    );
  }
}

// ------------------------------------------------------------------
// --- WIDGET: RESPONSIBLE FOR THE TWO-COLUMN OR SINGLE-COLUMN LAYOUT ---
// ------------------------------------------------------------------
class ResumeContentLayout extends StatelessWidget {
  const ResumeContentLayout({
    super.key,
    required this.education,
    required this.experience,
  });

  final List<Education> education;
  final List<Experience> experience;

  @override
  Widget build(BuildContext context) {
    // Desktop View: Experience & Education on the left (wider column),
    // Skills & Certifications on the right (narrower column)
    if (ResponsiveLayout.isLargeScreen(context)) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Column 1: Main Content (Experience + Education)
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Experience
                Text('Professional Experience',
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 30),
                ExperienceTimeline(
                  items: experience,
                ),
                const SizedBox(height: 80), // Separator

                // 2. Education (Now Full-Width Timeline)
                Text('Education',
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 30),
                EducationTimeline(
                  items: education,
                ),
              ],
            ),
          ),
          const SizedBox(width: 60),

          // Column 2: Sidebar (Skills, Certifications)
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Skills (Compact View)
                Text('Technical Skills',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(fontSize: 24)),
                const SizedBox(height: 30),
                const SkillsGrid(isSidebar: true), // <-- Sidebar rendering
                const SizedBox(height: 60),

                // Certifications (Compact View)
                Text('Certifications',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(fontSize: 24)),
                const SizedBox(height: 30),
                const CertificationsList(),
              ],
            ),
          ),
        ],
      );
    } else {
      // --- SINGLE-COLUMN LAYOUT (Mobile/Tablet) ---
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Using Text styles that are defined outside the theme,
          // which is acceptable for a simple mobile view
          const Text(
            'Professional Experience',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
          const SizedBox(height: 30),
          ExperienceTimeline(
            items: experience,
          ),
          const SizedBox(height: 80),
          const Text(
            'Education',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
          const SizedBox(height: 30),
          EducationTimeline(items: education),
          const SizedBox(height: 80),
          const Text(
            'Technical Skills',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
          const SizedBox(height: 30),
          const SkillsGrid(), // <-- Full-width rendering
          const SizedBox(height: 80),
          const Text(
            'Certifications',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
          const SizedBox(height: 30),
          const CertificationsList(),
        ],
      );
    }
  }
}

// ------------------------------------------------------------------
// --- Education DEDICATED EXPERIENCE TIMELINE WIDGET ---
// ------------------------------------------------------------------
class EducationTimeline extends StatelessWidget {
  const EducationTimeline({super.key, required this.items});

  final List<Education> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.map((item) {
        bool isLast = item == items.last;
        double lineHeight = 120;
        double effectiveLineHeight = isLast ? lineHeight * 0.5 : lineHeight;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _TimelineRail(isLast: isLast, lineHeight: effectiveLineHeight),
            const SizedBox(width: 20),
            Expanded(
              child: TimelineCard.education(
                degree: item.degree,
                institution: item.institution,
                years: item.years,
                description: item.description,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}

// ------------------------------------------------------------------
// --- Experience DEDICATED EXPERIENCE TIMELINE WIDGET ---
// ------------------------------------------------------------------
class ExperienceTimeline extends StatelessWidget {
  const ExperienceTimeline({super.key, required this.items});

  final List<Experience> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.map((item) {
        bool isLast = item == items.last;
        double lineHeight = 220;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Timeline Rail (Left) ---
            _TimelineRail(isLast: isLast, lineHeight: lineHeight),
            const SizedBox(width: 20),

            // --- Timeline Content (Right) ---
            Expanded(
              child: TimelineCard.experience(
                title: item.title,
                company: item.company,
                duration: item.duration,
                description: item.description,
                achievements: item.achievements,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}

// ------------------------------------------------------------------
// --- CertificationsList (Extracted) ---
// ------------------------------------------------------------------
class CertificationsList extends StatelessWidget {
  const CertificationsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // This is the clean, stacked list view for the sidebar
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: ResumeContent.certifications
          .map(
            (cert) => Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FaIcon(FontAwesomeIcons.certificate,
                      size: 16, color: Theme.of(context).colorScheme.primary),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      cert,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

// ------------------------------------------------------------------
// --- REUSABLE TIMELINE RAIL COMPONENT (Color Reference Fixed) ---
// ------------------------------------------------------------------
class _TimelineRail extends StatelessWidget {
  final bool isLast;
  final double lineHeight;

  const _TimelineRail({required this.isLast, required this.lineHeight});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // Dot
          width: 16,
          height: 16,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                  blurRadius: 5.0,
                )
              ]),
        ),
        // Line segment
        Container(
          width: 2,
          height: lineHeight,
          // FIX: Use a theme-relative color for the line (onSurface.withOpacity)
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
        ),
      ],
    );
  }
}
