import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';
import '../sections/hero_section.dart';
import '../sections/features_section.dart';
import '../sections/value_section.dart';
import '../sections/contact_section.dart';

/// Main landing page — assembles all sections with smooth scroll navigation.
class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0;

  // Section keys for scroll-to navigation
  final _featuresKey = GlobalKey();
  final _valueKey = GlobalKey();
  final _contactKey = GlobalKey();

  Map<String, GlobalKey> get _sectionKeys => {
        'features': _featuresKey,
        'value': _valueKey,
        'contact': _contactKey,
      };

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    setState(() => _scrollOffset = _scrollController.offset);
  }

  void _scrollToFeatures() {
    final ctx = _featuresKey.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Main scrollable content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // Hero
                HeroSection(onCtaTap: _scrollToFeatures),

                // Features
                Container(
                  key: _featuresKey,
                  child: const FeaturesSection(),
                ),

                // Value
                Container(
                  key: _valueKey,
                  child: const ValueSection(),
                ),

                // Contact
                Container(
                  key: _contactKey,
                  child: const ContactSection(),
                ),

                // Footer
                const Footer(),
              ],
            ),
          ),

          // Sticky navbar overlay
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Navbar(
              scrollController: _scrollController,
              sectionKeys: _sectionKeys,
              scrollOffset: _scrollOffset,
            ),
          ),
        ],
      ),
    );
  }
}
