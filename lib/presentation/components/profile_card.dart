import 'dart:ui';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:my_portfolio/core/constants/app_constants.dart';
import '../../core/theme/app_theme.dart';

// lib/presentation/components/profile_card.dart

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final glassSurface =
        isDark ? AppTheme.glassSurfaceDark : AppTheme.glassSurfaceLight;
    final glassBorder =
        isDark ? AppTheme.glassBorderDark : AppTheme.glassBorderLight;

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: const EdgeInsets.all(32.0),
          decoration: BoxDecoration(
            color: glassSurface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: glassBorder.withValues(alpha: 0.2),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Profile Picture with subtle glow
              Container(
                width: 280,
                height: 320,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.primary.withValues(alpha: 0.2),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    "assets/images/img_profile.jpg",
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stack) {
                      log("error: $error");
                      return Center(
                        child: FaIcon(
                          FontAwesomeIcons.solidUser,
                          size: 100,
                          color: theme.colorScheme.onPrimary.withValues(alpha: 0.4),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Name
              Text(
                'Saugat Jonchhen',
                style: theme.textTheme.displaySmall!.copyWith(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 12),

              // Short Title / Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: theme.colorScheme.primary.withValues(alpha: 0.5),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Senior Mobile Developer',
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: theme.colorScheme.secondary,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Description Snippet
              Text(
                'Architecting elegant, high-performance cross-platform experiences with Flutter.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium!.copyWith(
                  height: 1.6,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                ),
              ),
              const SizedBox(height: 32),

              // Download Resume CTA
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    openURL(AppConstants.resumeUrl);
                  },
                  icon: const FaIcon(FontAwesomeIcons.download, size: 16),
                  label: const Text('DOWNLOAD RESUME'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _SocialIcon(
                    icon: FontAwesomeIcons.facebookF,
                    url: "https://www.facebook.com/saugat.john09",
                  ),
                  const SizedBox(width: 20),
                  _SocialIcon(
                    icon: FontAwesomeIcons.instagram,
                    url: "https://www.instagram.com/saugat.john09",
                  ),
                  const SizedBox(width: 20),
                  _SocialIcon(
                    icon: FontAwesomeIcons.linkedinIn,
                    url: "https://www.linkedin.com/in/saugat-john09/",
                  ),
                  const SizedBox(width: 20),
                  _SocialIcon(
                    icon: FontAwesomeIcons.xTwitter,
                    url: "https://www.x.com/SJonchhen",
                  ),
                  const SizedBox(width: 20),
                  _SocialIcon(
                    icon: FontAwesomeIcons.github,
                    url: "https://github.com/saugatjonchhen",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void openURL(String newUrl) async {
    final Uri url = Uri.parse(newUrl);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final String url;

  const _SocialIcon({required this.icon, required this.url});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {
        final profileCard = context.findAncestorWidgetOfExactType<ProfileCard>();
        profileCard?.openURL(url);
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
          ),
        ),
        child: FaIcon(
          icon,
          size: 20,
          color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
        ),
      ),
    );
  }
}
