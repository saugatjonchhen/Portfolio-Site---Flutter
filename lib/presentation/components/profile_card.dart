import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// URL for a generic, publicly available profile image placeholder.
const String _kPlaceholderImageUrl = 'https://i.pravatar.cc/300';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Simulate the dark mode card style from the image
    return Card(
      elevation: 10,
      color: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          16,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Keep it compact
          children: [
            // Placeholder for Profile Picture
            Container(
              width: 250,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                // Use a simple primary color fill or a subtle gradient
                color: theme.colorScheme.primary.withOpacity(0.8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  "assets/images/img_profile.jpg",
                  height: 350,
                  width: 350,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stack) {
                    log("error: $error");
                    return FaIcon(
                      FontAwesomeIcons.solidUser,
                      size: 100,
                      color: theme.colorScheme.onPrimary.withOpacity(0.4),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Name
            Text(
              'Saugat Jonchhen',
              style: theme.textTheme.displaySmall!.copyWith(
                fontSize: 32,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),

            // Short Title / Indicator (The small orange dot/indicator in the image)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 6,
                  backgroundColor: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Sr. Mobile Developer',
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: theme.colorScheme.secondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Description Snippet
            Text(
              'A Senior Flutter Developer specializing in crafting elegant, high-performance mobile and web solutions.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 30),

            // Social Links (as seen in the image)
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FaIcon(FontAwesomeIcons.facebookF, size: 20),
                FaIcon(FontAwesomeIcons.instagram, size: 20),
                FaIcon(FontAwesomeIcons.linkedinIn, size: 20),
                FaIcon(FontAwesomeIcons.twitter, size: 20),
                FaIcon(FontAwesomeIcons.github, size: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
