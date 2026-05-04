import 'package:flutter/material.dart';

import '../core/utils/responsive.dart';
import 'components/app_bar_widget.dart';
import 'components/footer.dart';
import 'components/home_page_hero.dart';
import 'components/profile_card.dart';
import 'components/contact_section.dart';

import 'components/custom_scrollbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (ResponsiveLayout.isLargeScreen(context)) {
      return Scaffold(
        appBar: AppNavBar(),
        endDrawer: AppDrawer(),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: 100, // Reduced from 200 for better layout balance
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
              child: CustomScrollbar(
                controller: _scrollController,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 850,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const HomePageHero(),
                          const SizedBox(height: 80),
                          const ContactSection(),
                          const SizedBox(height: 100),
                          Footer(),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 50, // Reduced from 100
            ),
          ],
        ),
      );
    } else {
      // --- MOBILE/TABLET VIEW ---
      return Scaffold(
        appBar: AppNavBar(),
        endDrawer: AppDrawer(),
        body: CustomScrollbar(
          controller: _scrollController,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HomePageHero(),
                const SizedBox(height: 80),
                const ContactSection(),
                const SizedBox(height: 100),
                Footer(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      );
    }
  }
}
