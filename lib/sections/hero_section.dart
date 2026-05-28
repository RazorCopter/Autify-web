import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

/// Full-viewport hero with gradient background, headline, subtitle,
/// logo, CTA, and floating decorative elements.
class HeroSection extends StatelessWidget {
  final VoidCallback? onCtaTap;

  const HeroSection({super.key, this.onCtaTap});

  @override
  Widget build(BuildContext context) {
    final isMobile = AppTheme.isMobile(context);
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: screenHeight * 0.92),
      decoration: const BoxDecoration(
        gradient: AppColors.heroGradient,
      ),
      child: Stack(
        children: [
          // Floating decorative shapes
          ..._buildDecorations(context),
          // Content
          Center(
            child: Padding(
              padding: AppTheme.responsivePadding(context),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: AppTheme.contentMaxWidth),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: isMobile ? 120 : 100),
                    // Logo
                    Image.asset(
                      'assets/images/logo_autify_int.png',
                      height: isMobile ? 110 : 150,
                      filterQuality: FilterQuality.high,
                    )
                        .animate()
                        .fadeIn(
                          duration: 800.ms,
                          curve: Curves.easeOut,
                        )
                        .scale(
                          begin: const Offset(0.85, 0.85),
                          end: const Offset(1, 1),
                          duration: 800.ms,
                          curve: Curves.easeOutBack,
                        ),
                    const SizedBox(height: 40),
                    // Main headline
                    Text(
                      "L'intelligenza dei dati\nal servizio della cura.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.outfit(
                        fontSize: isMobile ? 34 : 56,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                        height: 1.15,
                        letterSpacing: -1,
                      ),
                    )
                        .animate()
                        .fadeIn(duration: 800.ms, delay: 200.ms)
                        .moveY(
                          begin: 30,
                          end: 0,
                          duration: 800.ms,
                          delay: 200.ms,
                          curve: Curves.easeOutCubic,
                        ),
                    const SizedBox(height: 24),
                    // Subtitle
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 640),
                      child: Text(
                        'Autify è nata per trasformare il monitoraggio della qualità '
                        'della vita in una pratica quotidiana accessibile a professionisti '
                        'e centri di riabilitazione.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: isMobile ? 16 : 19,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textSecondary,
                          height: 1.7,
                        ),
                      ),
                    )
                        .animate()
                        .fadeIn(duration: 700.ms, delay: 450.ms)
                        .moveY(
                          begin: 20,
                          end: 0,
                          duration: 700.ms,
                          delay: 450.ms,
                          curve: Curves.easeOutCubic,
                        ),
                    const SizedBox(height: 44),
                    // CTA Buttons
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 16,
                      runSpacing: 12,
                      children: [
                        _HeroCta(
                          label: 'Scopri di più',
                          isPrimary: true,
                          onTap: onCtaTap,
                        ),
                        _HeroCta(
                          label: 'Richiedi una Demo',
                          isPrimary: false,
                          onTap: onCtaTap,
                        ),
                      ],
                    )
                        .animate()
                        .fadeIn(duration: 700.ms, delay: 650.ms)
                        .moveY(
                          begin: 20,
                          end: 0,
                          duration: 700.ms,
                          delay: 650.ms,
                          curve: Curves.easeOutCubic,
                        ),
                    SizedBox(height: isMobile ? 80 : 60),
                    // Scroll indicator
                    _ScrollIndicator()
                        .animate(onPlay: (c) => c.repeat(reverse: true))
                        .moveY(begin: 0, end: 8, duration: 1500.ms)
                        .animate()
                        .fadeIn(delay: 1200.ms, duration: 500.ms),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildDecorations(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return [
      // Top-right blob
      Positioned(
        top: -80,
        right: -60,
        child: Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                AppColors.accentTeal.withValues(alpha: 0.06),
                AppColors.accentTeal.withValues(alpha: 0),
              ],
            ),
          ),
        ).animate(onPlay: (c) => c.repeat(reverse: true)).moveY(
              begin: 0,
              end: 15,
              duration: 4000.ms,
              curve: Curves.easeInOut,
            ),
      ),
      // Left blob
      Positioned(
        top: size.height * 0.3,
        left: -100,
        child: Container(
          width: 250,
          height: 250,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                AppColors.primaryBlue.withValues(alpha: 0.05),
                AppColors.primaryBlue.withValues(alpha: 0),
              ],
            ),
          ),
        ).animate(onPlay: (c) => c.repeat(reverse: true)).moveY(
              begin: 0,
              end: -20,
              duration: 5000.ms,
              curve: Curves.easeInOut,
            ),
      ),
      // Bottom-right accent
      Positioned(
        bottom: 100,
        right: size.width * 0.1,
        child: Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: AppColors.accentOrange.withValues(alpha: 0.4),
            shape: BoxShape.circle,
          ),
        ).animate(onPlay: (c) => c.repeat(reverse: true)).moveY(
              begin: 0,
              end: 10,
              duration: 3000.ms,
              curve: Curves.easeInOut,
            ),
      ),
      // Small teal dot
      Positioned(
        top: size.height * 0.25,
        right: size.width * 0.15,
        child: Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: AppColors.accentTeal.withValues(alpha: 0.5),
            shape: BoxShape.circle,
          ),
        ).animate(onPlay: (c) => c.repeat(reverse: true)).moveX(
              begin: 0,
              end: 8,
              duration: 3500.ms,
              curve: Curves.easeInOut,
            ),
      ),
    ];
  }
}

class _HeroCta extends StatefulWidget {
  final String label;
  final bool isPrimary;
  final VoidCallback? onTap;

  const _HeroCta({
    required this.label,
    required this.isPrimary,
    this.onTap,
  });

  @override
  State<_HeroCta> createState() => _HeroCtaState();
}

class _HeroCtaState extends State<_HeroCta> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 18),
          decoration: BoxDecoration(
            gradient: widget.isPrimary ? AppColors.ctaGradient : null,
            color: widget.isPrimary ? null : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: widget.isPrimary
                ? null
                : Border.all(
                    color: _isHovered
                        ? AppColors.primaryBlue
                        : AppColors.border,
                    width: 1.5,
                  ),
            boxShadow: widget.isPrimary && _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.primaryBlue.withValues(alpha: 0.3),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : [],
          ),
          transform: _isHovered
              ? Matrix4.translationValues(0.0, -2.0, 0.0)
              : Matrix4.identity(),
          child: Text(
            widget.label,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: widget.isPrimary
                  ? Colors.white
                  : (_isHovered ? AppColors.primaryBlue : AppColors.textPrimary),
              letterSpacing: 0.3,
            ),
          ),
        ),
      ),
    );
  }
}

class _ScrollIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 28,
          height: 44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: AppColors.textMuted.withValues(alpha: 0.3),
              width: 1.5,
            ),
          ),
          child: Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Container(
                width: 4,
                height: 10,
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
