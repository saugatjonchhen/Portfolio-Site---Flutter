import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:my_portfolio/core/theme/app_theme.dart';
import '../../core/utils/responsive.dart';
import 'home_page_hero.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final glassSurface =
        isDark ? AppTheme.glassSurfaceDark : AppTheme.glassSurfaceLight;
    final glassBorder =
        isDark ? AppTheme.glassBorderDark : AppTheme.glassBorderLight;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveLayout.isLargeScreen(context) ? 0 : 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeadlineSectionTitle(
            part1: "Let's",
            part2: "Connect",
            fontSize: 40,
          ).animate().fadeIn(duration: 800.ms).moveY(begin: 20, end: 0),
          const SizedBox(height: 30),
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  color: glassSurface,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: glassBorder.withValues(alpha: 0.1),
                    width: 1.5,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      "Interested in working together or just want to say hi? My inbox is always open!",
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleLarge!.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      alignment: WrapAlignment.center,
                      children: [
                        _ContactButton(
                          icon: Icons.email_rounded,
                          label: "Email Me",
                          onTap: () => _launchURL("mailto:saugat.john09@gmail.com"),
                          isPrimary: true,
                        ),
                        _ContactButton(
                          icon: FontAwesomeIcons.linkedin,
                          label: "LinkedIn",
                          onTap: () => _launchURL("https://www.linkedin.com/in/saugat-john09/"),
                          isPrimary: false,
                        ),
                        _ContactButton(
                          icon: FontAwesomeIcons.github,
                          label: "GitHub",
                          onTap: () => _launchURL("https://github.com/saugatjonchhen"),
                          isPrimary: false,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ).animate(delay: 200.ms).fadeIn(duration: 800.ms).scale(begin: const Offset(0.95, 0.95)),
        ],
      ),
    );
  }

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}

class _ContactButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isPrimary;

  const _ContactButton({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.isPrimary,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
        decoration: BoxDecoration(
          color: isPrimary ? theme.colorScheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isPrimary ? theme.colorScheme.primary : theme.colorScheme.primary.withValues(alpha: 0.5),
            width: 2,
          ),
          boxShadow: isPrimary
              ? [
                  BoxShadow(
                    color: theme.colorScheme.primary.withValues(alpha: 0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  )
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(
              icon,
              size: 20,
              color: isPrimary ? theme.colorScheme.onPrimary : theme.colorScheme.primary,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: theme.textTheme.titleMedium!.copyWith(
                color: isPrimary ? theme.colorScheme.onPrimary : theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
