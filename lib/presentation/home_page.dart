import 'package:flutter/material.dart';

import '../core/utils/responsive.dart';
import 'components/app_bar_widget.dart';
import 'components/footer.dart';
import 'components/home_page_hero.dart';
import 'components/profile_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    if (ResponsiveLayout.isLargeScreen(context)) {
      return Scaffold(
        appBar: const AppNavBar(),
        endDrawer: const AppDrawer(),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: 200,
            ),
            // 1. LEFT COLUMN: FIXED Profile Card (Width: 350px)
            Container(
              width: 450,
              height: MediaQuery.of(context).size.height,
              padding:
                  const EdgeInsets.only(top: kToolbarHeight + 40, left: 40),
              child: const Align(
                alignment: Alignment.topCenter,
                child: ProfileCard(),
              ),
            ),

            // 2. RIGHT COLUMN: Scrollable Content, CONSTRAINED AND CENTERED
            Expanded(
              child: Center(
                // Center the content horizontally within the Expanded area
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth:
                        850, // Set a max width (e.g., 850px) for a contained look
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const HomePageHero(),
                        const SizedBox(height: 80),

                        // --- MINI SECTIONS (Snippets) ---
                        // ... (Placeholder for Projects, Skills, Education, Experience Snippets) ...

                        const Footer(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 100,
            ),
          ],
        ),
      );
    } else {
      // --- MOBILE/TABLET VIEW (Stacking remains the same, left-aligned) ---
      return Scaffold(
        appBar: const AppNavBar(),
        endDrawer: const AppDrawer(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomePageHero(),
              const SizedBox(height: 80),

              // ... (Snippets placeholders) ...

              const Footer(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      );
    }
  }
}
