import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/app_theme.dart';
import 'router/app_router.dart';

// Riverpod provider for theme state
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.dark);

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final themeData =
        themeMode == ThemeMode.dark ? AppTheme.darkTheme : AppTheme.lightTheme;

    return MaterialApp.router(
      title: 'My Portfolio - Saugat Jonchhen',
      // Using dark theme as base
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
      // 2. Wrap the entire application content with AnimatedTheme
      builder: (context, child) {
        if (child == null) return const SizedBox.shrink();

        return AnimatedTheme(
          // 3. Pass the target theme data determined by the Riverpod state
          data: themeData,

          // 4. Set a smooth transition time (e.g., 400 milliseconds)
          duration: const Duration(milliseconds: 400),

          child:
              child, // The actual router content (HomePage, ResumePage, etc.)
        );
      },
    );
  }
}
