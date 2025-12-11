// lib/presentation/home/components/timeline_card.dart (REFACTORED)

import 'package:flutter/material.dart';

class TimelineCard extends StatelessWidget {
  final String title;
  final String secondaryTitle;
  final String duration;
  final String? description;
  final List<String>? achievements;

  const TimelineCard.experience({
    required String title,
    required String company,
    required String duration,
    required String description,
    required List<String> achievements,
  }) : this(
          title: title,
          secondaryTitle: company,
          duration: duration,
          description: description,
          achievements: achievements,
        );

  const TimelineCard.education({
    required String degree,
    required String institution,
    required String years,
    String? description,
  }) : this(
          title: degree,
          secondaryTitle: institution,
          duration: years,
          description: description,
          achievements: null,
        );

  const TimelineCard({
    super.key,
    required this.title,
    required this.secondaryTitle,
    required this.duration,
    this.description,
    this.achievements,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 4),
              // Secondary Title (Company/Institution) and Duration
              Text(
                '$secondaryTitle | $duration',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 12),

              // Description (Used for both Experience and Education)
              if (description != null)
                Text(description!,
                    style: Theme.of(context).textTheme.bodyMedium),

              // Achievements (Only for Experience)
              if (achievements != null && achievements!.isNotEmpty) ...[
                const SizedBox(height: 12),
                ...achievements!
                    .map(
                      (achievement) => Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('• ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary)),
                            Expanded(
                                child: Text(achievement,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium)),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
