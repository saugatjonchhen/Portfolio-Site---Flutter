import '../models/project.dart';

class ProjectsContent {
  static List<Project> projects = [
    Project(
      id: '1',
      title: 'E-Commerce Super App',
      description:
          'A comprehensive shopping platform with real-time inventory, payment gateway integration, and multi-vendor support.',
      tags: ['Flutter', 'Firebase', 'Stripe', 'Riverpod'],
      imageUrl:
          'https://via.placeholder.com/600x400/0F172A/00BFA5?text=E-Commerce',
      demoUrl: 'https://demo.com',
      sourceUrl: 'https://github.com/user/app',
      client: 'Innovate Corp',
    ),
    Project(
      id: '2',
      title: 'Fitness Tracker Pro',
      description:
          'Track workouts, visualize progress with complex charts, and manage diet plans locally.',
      tags: ['Flutter', 'SQLite', 'Charts'],
      imageUrl:
          'https://via.placeholder.com/600x400/0F172A/7C3AED?text=Fitness',
      sourceUrl: 'https://github.com/user/fitness',
      client: 'Personal',
    ),
    Project(
      id: '3',
      title: 'Weather Dashboard',
      description:
          'Real-time weather information with beautiful animations and location-based forecasting.',
      tags: ['Flutter', 'REST API', 'Animations'],
      imageUrl:
          'https://via.placeholder.com/600x400/0F172A/FBBF24?text=Weather',
      demoUrl: 'https://demo.com',
      sourceUrl: 'https://github.com/user/weather',
      client: 'Freelance',
    ),
    Project(
      id: '4',
      title: 'Task Master Team',
      description:
          'Organize tasks, collaborate with teams in real-time, and sync across devices.',
      tags: ['Flutter', 'Riverpod', 'Firebase'],
      imageUrl:
          'https://via.placeholder.com/600x400/0F172A/FF5722?text=Task+App',
      sourceUrl: 'https://github.com/user/tasks',
      client: 'Startup Inc',
    ),
    Project(
      id: '5',
      title: 'Social Connect',
      description:
          'A social media application focusing on privacy, local community building, and instant messaging.',
      tags: ['Flutter', 'Firebase', 'FCM', 'Provider'],
      imageUrl: 'https://via.placeholder.com/600x400/0F172A/0EA5E9?text=Social',
      sourceUrl: 'https://github.com/user/social',
      client: 'Freelance',
    ),
    Project(
      id: '6',
      title: 'Smart Recipe Finder',
      description:
          'Discover recipes based on ingredients you have, save favorites, and generate shopping lists.',
      tags: ['Flutter', 'REST API', 'SQLite'],
      imageUrl:
          'https://via.placeholder.com/600x400/0F172A/E11D48?text=Recipes',
      demoUrl: 'https://demo.com',
      sourceUrl: 'https://github.com/user/recipes',
      client: 'Personal',
    ),
  ];
}
