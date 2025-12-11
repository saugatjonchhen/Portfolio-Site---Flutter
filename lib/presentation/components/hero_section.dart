import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/utils/responsive.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      largeScreen: _buildDesktopLayout(context),
      mediumScreen: _buildDesktopLayout(context),
      smallScreen: _buildMobileLayout(context),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 6,
          child: _buildTextContent(context)
              .animate()
              .fadeIn(duration: 400.ms)
              .slideX(begin: -0.15),
        ),
        const SizedBox(width: 40),
        Expanded(
          flex: 4,
          child: _buildTimelineVisual(context)
              .animate()
              .fadeIn(duration: 400.ms)
              .slideX(begin: 0.15),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTimelineVisual(context), // Placing visual first on mobile
        const SizedBox(height: 40),
        _buildTextContent(context),
      ],
    );
  }

  Widget _buildTextContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hi, my name is',
          style: Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: 18),
        ),
        const SizedBox(height: 8),
        Text(
          'JOHN DOE',
          style:
              Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 72),
        ),
        Text(
          'Senior Flutter Developer',
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(color: Theme.of(context).colorScheme.primary),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: 500,
          child: Text(
            'A passionate developer crafting beautiful and functional cross-platform apps with a focus on Riverpod, clean architecture and user experience. I build things for the web and mobile.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        const SizedBox(height: 40),
        Row(
          children: [
            ElevatedButton.icon(
              onPressed: () {},
              icon: const FaIcon(FontAwesomeIcons.download, size: 16),
              label: const Text('Download Resume'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                textStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 16),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const FaIcon(FontAwesomeIcons.eye, size: 16),
              label: const Text('View Projects'),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Theme.of(context).colorScheme.primary),
                foregroundColor: Theme.of(context).colorScheme.primary,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                textStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTimelineVisual(BuildContext context) {
    // Replicating the visual shown in the design
    return Center(
      child: Column(
        children: [
          // Profile Image Placeholder
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: Theme.of(context).colorScheme.primary, width: 2),
              image: const DecorationImage(
                image: NetworkImage('https://via.placeholder.com/300'),
                // Replace with actual profile image
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Placeholder for the "M.Sc. Computer Science" details
          Text(
            'M.Sc. Computer Science',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            'University of Technology | 2019-2021',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
