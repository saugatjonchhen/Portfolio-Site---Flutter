import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../presentation/blogs/blogs_detail_page.dart';
import '../presentation/blogs/blogs_page.dart';
import '../presentation/home_page.dart';
import '../presentation/portfolio/portfolio_page.dart';
import '../presentation/resume/resume_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const HomePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        ),
      ),
      GoRoute(
        path: '/resume',
        name: 'resume',
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const ResumePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        ),
      ),
      GoRoute(
        path: '/portfolio',
        name: 'portfolio',
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const PortfolioPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        ),
      ),
      GoRoute(
        path: '/blogs',
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const BlogsPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        ),
      ),
      GoRoute(
        path: '/blogs/:blogId',
        pageBuilder: (context, state) {
          final blogId = state.pathParameters['blogId']!;
          return CustomTransitionPage<void>(
            key: state.pageKey,
            child: BlogDetailPage(blogId: blogId),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
          );
        },
      ),
    ],
  );
}
