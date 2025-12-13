import 'package:flutter_riverpod/flutter_riverpod.dart';

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
