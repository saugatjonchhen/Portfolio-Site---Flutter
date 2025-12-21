import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/utils/helper_functions.dart';
import '../data/models/education.dart';
import '../data/models/experience.dart';
import '../data/models/project.dart';
import '../data/services/portfolio_data_service.dart';

/// ----------------------------
/// STATE
/// ----------------------------
class PortfolioState {
  final List<Education> education;
  final List<Experience> experience;
  final List<Project> projects;
  final Map<String, List<String>> skills;

  const PortfolioState({
    required this.education,
    required this.experience,
    required this.projects,
    required this.skills,
  });

  factory PortfolioState.empty() {
    return const PortfolioState(
      education: [],
      experience: [],
      projects: [],
      skills: {},
    );
  }
}

/// ----------------------------
/// NOTIFIER
/// ----------------------------
class PortfolioNotifier extends AsyncNotifier<PortfolioState> {
  @override
  Future<PortfolioState> build() async {
    return _loadPortfolio();
  }

  Future<PortfolioState> _loadPortfolio() async {
    final education = await PortfolioDataService.loadEducation();
    final experience = await PortfolioDataService.loadExperience();
    final projects = await PortfolioDataService.loadProjects();
    final skills = await PortfolioDataService.loadSkills();

    return PortfolioState(
      education: education,
      experience: experience,
      projects: projects,
      skills: skills,
    );
  }

  /// Optional: refresh manually
  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_loadPortfolio);
  }
}

/// ----------------------------
/// PROVIDER
/// ----------------------------
final portfolioProvider =
    AsyncNotifierProvider<PortfolioNotifier, PortfolioState>(
  PortfolioNotifier.new,
);

extension PortfolioMetrics on PortfolioState {

  // --- 1. YEARS WORKED (Corrected) ---
  int get yearsWorked {
    if (experience.isEmpty) return 0;

    double totalDays = 0;
    for (var job in experience) {
      // Split using the en-dash (–) from your screenshot
      final dateParts = job.duration.split(RegExp(r'[–\-]'));

      if (dateParts.length == 2) {
        final start = parseDate(dateParts[0].trim());
        final end = parseDate(dateParts[1].trim());

        // Calculate difference in days for this specific job
        totalDays += end.difference(start).inDays;
      }
    }

    // Convert total days to years.
    // Based on 2017-2025, this should result in 8.
    return (totalDays / 365.25).floor();
  }

  // --- 2. TECH STACK (Unique Skill Count) ---
  // If your JSON has "Flutter" in two categories, this counts it only ONCE.
  int get techStackCount {
    final allUniqueSkills = skills.values.expand((list) => list).toSet();
    return allUniqueSkills.length;
  }

  // --- 3. MASTERY (Dynamic Category Count) ---
  // A common portfolio metric is the number of "Core Competencies" (Categories)
  int get masteryCount {
    return skills.keys.length; // e.g., Languages, Frameworks, Tools = 3
  }
}
