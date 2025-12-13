// lib/data/resume_content.dart

import '../models/education.dart';
import '../models/experience.dart';

// Assuming Experience and Education classes are in the lib/models directory

class ResumeContent {
  static List<Experience> experiences = [
    Experience(
      title: 'Senior Flutter Developer',
      company: 'Tech Company',
      duration: 'Jan 2022 - Present',
      description: 'Leading mobile development',
      seniorityLevel: 'Senior',
      achievements: [
        'Led flagship app (100K+ downloads)',
        'Improved performance 40%',
        'Mentored 5 developers',
        'Implemented CI/CD'
      ],
    ),
    Experience(
      title: 'Flutter Developer',
      company: 'StartUp',
      duration: 'Jun 2020 - Dec 2021',
      description: 'Developed Flutter applications',
      seniorityLevel: 'Mid-Level',
      achievements: [
        'Built 3 production apps',
        'Integrated payments',
        'Used BLoC pattern'
      ],
    ),
  ];

  static List<Education> education = [
    Education(
        degree: 'BS Computer Science',
        institution: 'University',
        years: '2015-2019',
        description: 'Focus on software engineering'),
    // Adding a second education item for better timeline visualization
    Education(
        degree: 'Cert. Full Stack Development',
        institution: 'Code Academy',
        years: '2014',
        description: 'Intensive 6-month bootcamp.'),
  ];

  static const Map<String, List<String>> skills = {
    // 1. Languages
    'Languages': [
      'Dart',
      'Kotlin',
      'Java',
      'Php',
      'Javascript',
      'C#'
    ],
    // 2. Frameworks & Libraries
    'Frameworks & Libraries': [
      'FastAPI',
      'Flutter (iOS/Android/Web/iPadOS)',
      'NumPy',
      'OpenCV',
      'Pandas',
      'PyTorch',
      'Reactjs',
      'Nextjs'
    ],
    // 3. State Management (Flutter)
    'State Management (Flutter)': ['BLoC', 'Provider', 'Riverpod'],
    // 4. Databases & Storage
    'Databases & Storage': [
      'Firebase (Firestore/Auth/Cloud Functions)',
      'Hive',
      'Local Storage',
      'MongoDB',
      'PostgreSQL'
    ],
    // 5. APIs & Networking
    'APIs & Networking': [
      'Dio',
      'GraphQL',
      'Http',
      'REST API',
      'Socket.IO',
      'Websockets'
    ],
    // 6. Tools & Platforms
    'Tools & Platforms': [
      'Android Studio',
      'CI/CD',
      'DevTool',
      'Docker',
      'Git',
      'GitHub',
      'Postman',
      'VS Code',
      'Xcode'
    ],
    // 7. Services
    'Services': [
      'Authentication',
      'Google Map',
      'In-App-Purchase',
      'Notifications',
      'OneSignal Notifications',
      'Lemon Squeezy'
    ],
    // 8. Testing
    'Testing': ['Integration Tests', 'Unit Tests', 'Widget Tests'],
    // 9. UI/UX & Design
    'UI/UX & Design': [
      'Custom Animations',
      'Figma',
      'AI Illustrator',
      'Photoshop',
      'Responsive UI',
      'Framer'
    ],
  };

  static List<String> certifications = [
    'Google Android Developer',
    'AWS Developer',
    'Flutter Bootcamp'
  ];
}
