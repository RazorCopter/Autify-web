import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/animated_section.dart';

/// Showcase section with social proof counters and a vertical image.
class ShowcaseSection extends StatelessWidget {
  const ShowcaseSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = AppTheme.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: AppTheme.sectionPaddingVertical,
      ),
      decoration: const BoxDecoration(
        gradient: AppColors.showcaseGradient,
      ),
      child: Center(
        child: Padding(
          padding: AppTheme.responsivePadding(context),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: AppTheme.contentMaxWidth),
            child: isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left: Vertical Image
        Expanded(
          flex: 4,
          child: AnimatedSection(
            slideOffset: const Offset(-40, 0),
            child: Container(
              constraints: const BoxConstraints(maxHeight: 600),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: AppColors.imageShadow,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/presentation_vertical.png',
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 80),
        // Right: Text and Counters
        Expanded(
          flex: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedSection(
                delay: const Duration(milliseconds: 200),
                child: Text(
                  'Professionisti di tutta Italia scelgono Autify',
                  style: GoogleFonts.outfit(
                    fontSize: 42,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textOnDark,
                    height: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              AnimatedSection(
                delay: const Duration(milliseconds: 300),
                child: Text(
                  'Unisciti ai centri all\'avanguardia che stanno rivoluzionando '
                  'il monitoraggio della qualità della vita con dati oggettivi e analisi intelligenti.',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textOnDarkMuted,
                    height: 1.6,
                  ),
                ),
              ),
              const SizedBox(height: 60),
              // Counters
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _AnimatedCounter(
                    value: 12,
                    suffix: '+',
                    label: 'Centri Attivi',
                    delay: 400,
                  ),
                  _AnimatedCounter(
                    value: 500,
                    suffix: '+',
                    label: 'Utenti Monitorati',
                    delay: 500,
                  ),
                  _AnimatedCounter(
                    value: 15,
                    suffix: 'k+',
                    label: 'Report Generati',
                    delay: 600,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AnimatedSection(
          child: Text(
            'Professionisti di tutta Italia scelgono Autify',
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: AppColors.textOnDark,
              height: 1.2,
            ),
          ),
        ),
        const SizedBox(height: 20),
        AnimatedSection(
          delay: const Duration(milliseconds: 100),
          child: Text(
            'Unisciti ai centri all\'avanguardia che stanno rivoluzionando '
            'il monitoraggio della qualità della vita con dati oggettivi.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.textOnDarkMuted,
              height: 1.6,
            ),
          ),
        ),
        const SizedBox(height: 48),
        AnimatedSection(
          delay: const Duration(milliseconds: 200),
          child: Container(
            constraints: const BoxConstraints(maxHeight: 400),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: AppColors.imageShadow,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/images/presentation_vertical.png',
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
        ),
        const SizedBox(height: 48),
        Column(
          children: [
            _AnimatedCounter(
              value: 12,
              suffix: '+',
              label: 'Centri Attivi',
              delay: 300,
            ),
            const SizedBox(height: 32),
            _AnimatedCounter(
              value: 500,
              suffix: '+',
              label: 'Utenti Monitorati',
              delay: 400,
            ),
            const SizedBox(height: 32),
            _AnimatedCounter(
              value: 15,
              suffix: 'k+',
              label: 'Report Generati',
              delay: 500,
            ),
          ],
        ),
      ],
    );
  }
}

class _AnimatedCounter extends StatelessWidget {
  final int value;
  final String suffix;
  final String label;
  final int delay;

  const _AnimatedCounter({
    required this.value,
    required this.suffix,
    required this.label,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSection(
      delay: Duration(milliseconds: delay),
      slideOffset: const Offset(0, 20),
      child: Column(
        crossAxisAlignment: AppTheme.isMobile(context) ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              TweenAnimationBuilder<int>(
                tween: IntTween(begin: 0, end: value),
                duration: const Duration(milliseconds: 1500),
                curve: Curves.easeOutCubic,
                builder: (context, currentValue, child) {
                  return Text(
                    currentValue.toString(),
                    style: GoogleFonts.outfit(
                      fontSize: 48,
                      fontWeight: FontWeight.w700,
                      color: AppColors.accentTeal,
                      height: 1,
                    ),
                  );
                },
              ),
              Text(
                suffix,
                style: GoogleFonts.outfit(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: AppColors.accentTeal,
                  height: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: AppColors.textOnDarkMuted,
            ),
          ),
        ],
      ),
    );
  }
}
