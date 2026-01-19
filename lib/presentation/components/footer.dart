import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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
              onPressed: () {
                openURL("https://github.com/saugatjonchhen");
              },
            ),
            IconButton(
              icon: const FaIcon(
                FontAwesomeIcons.linkedin,
                size: 20,
              ),
              onPressed: () {
                openURL("https://www.linkedin.com/in/saugat-john09/");
              },
            ),
            IconButton(
              icon: const FaIcon(
                FontAwesomeIcons.envelope,
                size: 20,
              ),
              onPressed: () async {
                final Uri emailLaunchUri = Uri(
                  scheme: 'mailto',
                  path: 'saugat.john09@gmail.com',
                  queryParameters: {
                    'subject': '',
                  },
                );
                if (!await launchUrl(emailLaunchUri)) {
                  throw Exception('Could not launch $emailLaunchUri');
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  void openURL(String newUrl) async {
    final Uri url = Uri.parse(newUrl);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
