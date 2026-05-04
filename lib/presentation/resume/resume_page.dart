// lib/presentation/resume/resume_page.dart (FINALIZED CODE)

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/constants/app_constants.dart';
import '../../core/utils/responsive.dart';
import '../../data/content/resume_content.dart';
import '../../data/models/education.dart';
import '../../data/models/experience.dart';
import '../../providers/portfolio_provider.dart';
import '../components/app_bar_widget.dart';
import '../components/footer.dart';
import '../components/skills_grid.dart';
import '../components/timeline_card.dart';

import '../components/custom_scrollbar.dart';

class ResumePage extends ConsumerStatefulWidget {
  const ResumePage({super.key});

  @override
  ConsumerState<ResumePage> createState() => _ResumePageState();
}

class _ResumePageState extends ConsumerState<ResumePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final portfolioAsync = ref.watch(portfolioProvider);
    final theme = Theme.of(context);

    // More granular padding for better responsiveness
    double horizontalPadding;
    if (ResponsiveLayout.isLargeScreen(context)) {
      horizontalPadding = 100;
    } else if (ResponsiveLayout.isMediumScreen(context)) {
      horizontalPadding = 48;
    } else {
      horizontalPadding = 24;
    }

    final isSmall = ResponsiveLayout.isSmallScreen(context);
    final isMedium = ResponsiveLayout.isMediumScreen(context);

    return Scaffold(
        appBar: AppNavBar(),
        endDrawer: AppDrawer(),
        body: portfolioAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) =>
              Center(child: Text('Failed to load resume data: $e')),
          data: (portfolio) {
            return CustomScrollbar(
              controller: _scrollController,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 60),

                      // --- HEADER & DOWNLOAD BUTTON ---
                      // Switch to Column on Small and Medium screens to prevent title overflow
                      (isSmall || isMedium)
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'My Professional Resume',
                                  style: theme.textTheme.displayLarge!.copyWith(
                                    fontSize: isSmall ? 32 : 40,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                const SizedBox(height: 24),
                                _DownloadButton(),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Text(
                                    'My Professional Resume',
                                    style: theme.textTheme.displayLarge!.copyWith(
                                      fontSize: 56,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
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
                      Footer(),
                      const SizedBox(height: 20),
                    ],
                  ),
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
      onPressed: () async {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(
        //       content: Text('Starting file download... (resume.pdf)')),
        // );
        downloadResume();
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

void downloadResume() async {
  final Uri url = Uri.parse(AppConstants.resumeUrl);
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
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
    final theme = Theme.of(context);
    final isDesktop = ResponsiveLayout.isLargeScreen(context);

    if (isDesktop) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Column 1: Main Content (Experience + Education)
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Professional Experience',
                    style: theme.textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w900)),
                const SizedBox(height: 40),
                ExperienceTimeline(items: experience),
                const SizedBox(height: 80),

                Text('Education',
                    style: theme.textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w900)),
                const SizedBox(height: 40),
                EducationTimeline(items: education),
              ],
            ),
          ),
          const SizedBox(width: 80),

          // Column 2: Sidebar (Skills, Certifications)
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Technical Skills',
                    style: theme.textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.w900, fontSize: 24)),
                const SizedBox(height: 32),
                const SkillsGrid(isSidebar: true),
                const SizedBox(height: 64),

                Text('Certifications',
                    style: theme.textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.w900, fontSize: 24)),
                const SizedBox(height: 32),
                const CertificationsList(),
              ],
            ),
          ),
        ],
      );
    } else {
      // --- MOBILE/TABLET LAYOUT ---
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Professional Experience',
              style: theme.textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.w900, fontSize: 32)),
          const SizedBox(height: 32),
          ExperienceTimeline(items: experience),
          const SizedBox(height: 80),

          Text('Education',
              style: theme.textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.w900, fontSize: 32)),
          const SizedBox(height: 32),
          EducationTimeline(items: education),
          const SizedBox(height: 80),

          Text('Technical Skills',
              style: theme.textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.w900, fontSize: 32)),
          const SizedBox(height: 32),
          const SkillsGrid(),
          const SizedBox(height: 80),

          Text('Certifications',
              style: theme.textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.w900, fontSize: 32)),
          const SizedBox(height: 32),
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

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TimelineRail(isLast: isLast),
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
          ),
        );
      }).toList(),
    );
  }
}

class ExperienceTimeline extends StatelessWidget {
  const ExperienceTimeline({super.key, required this.items});

  final List<Experience> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.map((item) {
        bool isLast = item == items.last;

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Timeline Rail (Left) ---
              _TimelineRail(isLast: isLast),
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
          ),
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

  const _TimelineRail({required this.isLast});

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
                  color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
                  blurRadius: 5.0,
                )
              ]),
        ),
        // Line segment
        if (!isLast)
          Expanded(
            child: Container(
              width: 2,
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2),
            ),
          )
        else
          const SizedBox(height: 32), // Spacer for the last item's bottom padding
      ],
    );
  }
}
