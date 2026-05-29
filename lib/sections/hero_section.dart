import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

/// Full-viewport hero with split-screen layout:
/// Left: headline, subtitle, CTAs. Right: doctor image with floating UI.
class HeroSection extends StatelessWidget {
  final VoidCallback? onCtaTap;

  const HeroSection({super.key, this.onCtaTap});

  @override
  Widget build(BuildContext context) {
    final isMobile = AppTheme.isMobile(context);
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: isMobile ? screenHeight * 0.85 : screenHeight * 0.92),
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
                child: isMobile ? _buildMobileLayout(context) : _buildDesktopLayout(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left: Text Content
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.only(top: 80),
            child: _buildTextContent(context, isMobile: false),
          ),
        ),
        const SizedBox(width: 60),
        // Right: Image
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.only(top: 100),
            child: _buildHeroImage(context),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 120),
        _buildTextContent(context, isMobile: true),
        const SizedBox(height: 48),
        _buildHeroImage(context),
        const SizedBox(height: 60),
      ],
    );
  }

  Widget _buildTextContent(BuildContext context, {required bool isMobile}) {
    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.primaryBlue.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: AppColors.primaryBlue.withValues(alpha: 0.15),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.accentGreen,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Piattaforma per la Disabilità',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryBlue,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        )
            .animate()
            .fadeIn(duration: 600.ms)
            .moveY(begin: 15, end: 0, duration: 600.ms, curve: Curves.easeOutCubic),
        const SizedBox(height: 28),
        // Main headline
        Text(
          "L'intelligenza dei dati\nal servizio dell'assistenza.",
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          style: GoogleFonts.outfit(
            fontSize: isMobile ? 36 : 54,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            height: 1.12,
            letterSpacing: -1.5,
          ),
        )
            .animate()
            .fadeIn(duration: 800.ms, delay: 150.ms)
            .moveY(begin: 25, end: 0, duration: 800.ms, delay: 150.ms, curve: Curves.easeOutCubic),
        const SizedBox(height: 24),
        // Subtitle
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: isMobile ? double.infinity : 480),
          child: Text(
            'Autify trasforma il monitoraggio della qualità della vita in una pratica '
            'quotidiana accessibile a professionisti e centri di riabilitazione.',
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
            style: GoogleFonts.inter(
              fontSize: isMobile ? 16 : 18,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
              height: 1.7,
            ),
          ),
        )
            .animate()
            .fadeIn(duration: 700.ms, delay: 350.ms)
            .moveY(begin: 20, end: 0, duration: 700.ms, delay: 350.ms, curve: Curves.easeOutCubic),
        const SizedBox(height: 40),
        // CTA Buttons
        Wrap(
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          spacing: 16,
          runSpacing: 12,
          children: [
            _HeroCta(label: 'Scopri di più', isPrimary: true, onTap: onCtaTap),
            _HeroCta(label: 'Richiedi una Demo', isPrimary: false, onTap: onCtaTap),
          ],
        )
            .animate()
            .fadeIn(duration: 700.ms, delay: 550.ms)
            .moveY(begin: 20, end: 0, duration: 700.ms, delay: 550.ms, curve: Curves.easeOutCubic),
        const SizedBox(height: 40),
        // Trust indicators
        Wrap(
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          spacing: 24,
          runSpacing: 8,
          children: [
            _TrustItem(icon: Icons.shield_rounded, label: 'GDPR Compliant'),
            _TrustItem(icon: Icons.verified_rounded, label: 'Scale Certificate'),
            _TrustItem(icon: Icons.speed_rounded, label: 'Report Istantanei'),
          ],
        )
            .animate()
            .fadeIn(duration: 600.ms, delay: 750.ms),
      ],
    );
  }

  Widget _buildHeroImage(BuildContext context) {
    final isMobile = AppTheme.isMobile(context);
    return Container(
      constraints: BoxConstraints(maxHeight: isMobile ? 350 : 520),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppColors.imageShadow,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          'assets/images/hero_doctor.png',
          fit: BoxFit.cover,
          filterQuality: FilterQuality.high,
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 1000.ms, delay: 400.ms)
        .moveX(
          begin: 40,
          end: 0,
          duration: 1000.ms,
          delay: 400.ms,
          curve: Curves.easeOutCubic,
        )
        .scale(
          begin: const Offset(0.95, 0.95),
          end: const Offset(1, 1),
          duration: 1000.ms,
          delay: 400.ms,
          curve: Curves.easeOutCubic,
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
          width: 350,
          height: 350,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                AppColors.accentTeal.withValues(alpha: 0.12),
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
        left: -120,
        child: Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                AppColors.primaryBlue.withValues(alpha: 0.1),
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
      // Bottom-right accent dot
      Positioned(
        bottom: 120,
        right: size.width * 0.08,
        child: Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: AppColors.accentOrange.withValues(alpha: 0.5),
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
        top: size.height * 0.2,
        right: size.width * 0.12,
        child: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: AppColors.accentTeal.withValues(alpha: 0.6),
            shape: BoxShape.circle,
          ),
        ).animate(onPlay: (c) => c.repeat(reverse: true)).moveX(
              begin: 0,
              end: 8,
              duration: 3500.ms,
              curve: Curves.easeInOut,
            ),
      ),
      // Green dot bottom-left
      Positioned(
        bottom: size.height * 0.15,
        left: size.width * 0.05,
        child: Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: AppColors.accentGreen.withValues(alpha: 0.5),
            shape: BoxShape.circle,
          ),
        ).animate(onPlay: (c) => c.repeat(reverse: true)).moveY(
              begin: 0,
              end: 12,
              duration: 4500.ms,
              curve: Curves.easeInOut,
            ),
      ),
    ];
  }
}

class _TrustItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _TrustItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: AppColors.textMuted),
        const SizedBox(width: 6),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.textMuted,
          ),
        ),
      ],
    );
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
                    color: _isHovered ? AppColors.primaryBlue : AppColors.border,
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
