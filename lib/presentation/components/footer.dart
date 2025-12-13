import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('© 2025 Saugat Jonchhen. Built with Flutter.',
            style: Theme.of(context).textTheme.bodySmall),
        Row(
          children: [
            IconButton(
              icon: const FaIcon(
                FontAwesomeIcons.github,
                size: 20,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const FaIcon(
                FontAwesomeIcons.linkedin,
                size: 20,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const FaIcon(
                FontAwesomeIcons.envelope,
                size: 20,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
