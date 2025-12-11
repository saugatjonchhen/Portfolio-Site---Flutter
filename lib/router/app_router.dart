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
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: const HomePage(),
        ),
      ),
      GoRoute(
        path: '/resume',
        name: 'resume',
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: const ResumePage(),
        ),
      ),
      GoRoute(
        path: '/portfolio',
        name: 'portfolio',
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: const PortfolioPage(),
        ),
      ),
      GoRoute(
        path: '/blogs',
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: const BlogsPage(),
        ),
      ),

      // 2. Blog Detail Page (Dynamic ID)
      GoRoute(
        path: '/blogs/:blogId', // :blogId is a parameter
        pageBuilder: (context, state) {
          final blogId = state.pathParameters['blogId']!; // Read parameter
          return NoTransitionPage<void>(
            key: state.pageKey,
            child: BlogDetailPage(blogId: blogId), // Pass to page
          );
        },
      ),
    ],
  );
}
