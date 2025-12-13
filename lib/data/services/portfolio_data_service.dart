import 'dart:convert';
import 'package:flutter/services.dart';

import '../models/education.dart';
import '../models/experience.dart';
import '../models/project.dart';

class PortfolioDataService {
  /// Generic JSON loader
  static Future<List<dynamic>> _loadJsonList(String path) async {
    final String jsonString = await rootBundle.loadString(path);
    final List<dynamic> jsonData = json.decode(jsonString);
    return jsonData;
  }

  /// Education
  static Future<List<Education>> loadEducation() async {
    final data = await _loadJsonList('assets/data/education.json');
    return data.map((e) => Education.fromJson(e)).toList();
  }

  /// Experience
  static Future<List<Experience>> loadExperience() async {
    final data = await _loadJsonList('assets/data/experience.json');
    return data.map((e) => Experience.fromJson(e)).toList();
  }

  /// Projects
  static Future<List<Project>> loadProjects() async {
    final data = await _loadJsonList('assets/data/projects.json');
    return data.map((e) => Project.fromJson(e)).toList();
  }

  static Future<Map<String, List<String>>> loadSkills() async {
    final jsonString =
    await rootBundle.loadString('assets/data/skills.json');

    final Map<String, dynamic> decoded = json.decode(jsonString);

    return decoded.map(
          (key, value) => MapEntry(key, List<String>.from(value)),
    );
  }
}
