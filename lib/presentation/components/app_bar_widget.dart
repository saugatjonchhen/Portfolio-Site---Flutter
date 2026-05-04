import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../main.dart'; // For themeModeProvider

class AppNavBar extends ConsumerWidget implements PreferredSizeWidget {
  const AppNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final isDark = themeMode == ThemeMode.dark;
    final theme = Theme.of(context);

    // Get the current route path to highlight the active tab
    final currentRoute =
        GoRouter.of(context).routerDelegate.currentConfiguration.uri.toString();

    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight + 20),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: AppBar(
            toolbarHeight: kToolbarHeight + 20,
            backgroundColor: theme.colorScheme.surface.withOpacity(0.7),
            elevation: 0,
            centerTitle: false,
            title: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                '<SAUGAT JONCHHEN. //',
                style: theme.textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
            shape: Border(
              bottom: BorderSide(
                color: theme.dividerColor,
                width: 1,
              ),
            ),
            actions: [
              if (MediaQuery.of(context).size.width > 768) ...[
                // --- NAVIGATION ITEMS (Desktop) ---
                _NavBarItem(
                  title: 'Home',
                  path: '/',
                  isSelected: currentRoute == '/',
                  onPressed: () => context.go('/'),
                ),
                _NavBarItem(
                  title: 'Resume',
                  path: '/resume',
                  isSelected: currentRoute == '/resume',
                  onPressed: () => context.go('/resume'),
                ),
                _NavBarItem(
                  title: 'Portfolio',
                  path: '/portfolio',
                  isSelected: currentRoute == '/portfolio',
                  onPressed: () => context.go('/portfolio'),
                ),
                _NavBarItem(
                  title: 'Blogs',
                  path: '/blogs',
                  isSelected: currentRoute == '/blogs',
                  onPressed: () => context.go('/blogs'),
                ),
                const SizedBox(width: 20),
              ],
              // Theme Toggle Button
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: Icon(
                    isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                    size: 20,
                    color: theme.colorScheme.primary,
                  ),
                  onPressed: () {
                    ref.read(themeModeProvider.notifier).state =
                        isDark ? ThemeMode.light : ThemeMode.dark;
                  },
                ),
              ),
              // Hamburger Menu Icon for Mobile
              if (MediaQuery.of(context).size.width <= 768)
                Builder(builder: (context) {
                  return IconButton(
                    icon: const Icon(Icons.menu_rounded),
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                  );
                }),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20);
}

// Reusable horizontal item for desktop view
class _NavBarItem extends StatefulWidget {
  final String title;
  final String path;
  final bool isSelected;
  final VoidCallback onPressed;

  const _NavBarItem({
    required this.title,
    required this.path,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  State<_NavBarItem> createState() => _NavBarItemState();
}

class _NavBarItemState extends State<_NavBarItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: TextButton(
        onPressed: widget.onPressed,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          foregroundColor: widget.isSelected || _isHovered
              ? theme.colorScheme.primary
              : theme.colorScheme.onSurface,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.title,
              style: theme.textTheme.bodyLarge!.copyWith(
                fontWeight:
                    widget.isSelected ? FontWeight.w900 : FontWeight.w500,
                fontSize: 15,
                color: widget.isSelected || _isHovered
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 2,
              width: widget.isSelected ? 20 : (_isHovered ? 12 : 0),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ----------------------------------------------------------------------
// --- NEW WIDGET: THE SLIDING DRAWER CONTENT ---
// ----------------------------------------------------------------------
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final currentRoute =
    GoRouter.of(context).routerDelegate.currentConfiguration.uri.toString();

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Header space (to clear the status bar)
          SizedBox(height: MediaQuery.of(context).padding.top + 20),

          // Drawer Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Navigation',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          const Divider(),

          // Navigation Links
          _DrawerItem(
            title: 'Home',
            path: '/',
            isSelected: currentRoute == '/',
            onTap: () => _handleNavigation(context, '/'),
          ),
          _DrawerItem(
            title: 'Resume',
            path: '/resume',
            isSelected: currentRoute == '/resume',
            onTap: () => _handleNavigation(context, '/resume'),
          ),
          _DrawerItem(
            title: 'Portfolio',
            path: '/portfolio',
            isSelected: currentRoute == '/portfolio',
            onTap: () => _handleNavigation(context, '/portfolio'),
          ),
          _DrawerItem(
            title: 'Blogs',
            path: '/blogs',
            isSelected: currentRoute == '/blogs',
            onTap: () => _handleNavigation(context, '/blogs'),
          ),
        ],
      ),
    );
  }

  void _handleNavigation(BuildContext context, String path) {
    if (GoRouter.of(context).routerDelegate.currentConfiguration.uri.toString() != path) {
      context.go(path);
    }
    // Closes the drawer immediately after selection
    Navigator.of(context).pop();
  }
}

// Reusable vertical item for the drawer
class _DrawerItem extends StatelessWidget {
  final String title;
  final String path;
  final bool isSelected;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.title,
    required this.path,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onSurface,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      selectedTileColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      onTap: onTap,
    );
  }
}