import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/animated_section.dart';

/// Value proposition section with stats and highlighted messaging.
class ValueSection extends StatelessWidget {
  const ValueSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = AppTheme.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: AppTheme.sectionPaddingVertical,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.symmetric(
          horizontal: BorderSide(
            color: AppColors.border.withValues(alpha: 0.4),
            width: 1,
          ),
        ),
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
        // Left: Text content
        Expanded(
          flex: 5,
          child: AnimatedSection(
            slideOffset: const Offset(-40, 0),
            child: _buildTextContent(false),
          ),
        ),
        const SizedBox(width: 80),
        // Right: Stats / Visual
        Expanded(
          flex: 4,
          child: AnimatedSection(
            delay: const Duration(milliseconds: 200),
            slideOffset: const Offset(40, 0),
            child: _buildStatsVisual(),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        AnimatedSection(child: _buildTextContent(true)),
        const SizedBox(height: 48),
        AnimatedSection(
          delay: const Duration(milliseconds: 200),
          child: _buildStatsVisual(),
        ),
      ],
    );
  }

  Widget _buildTextContent(bool isMobile) {
    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Accent line
        Container(
          width: 48,
          height: 3,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Il Valore di Autify',
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          style: GoogleFonts.outfit(
            fontSize: isMobile ? 28 : 40,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            height: 1.2,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Sistemi avanzati per la tracciabilità, '
          'facilitando l\'interazione tra professionisti e famiglie '
          'attraverso dashboard intuitive e report automatizzati.',
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          style: GoogleFonts.inter(
            fontSize: isMobile ? 16 : 18,
            fontWeight: FontWeight.w400,
            color: AppColors.textSecondary,
            height: 1.7,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Autify permette di trasformare i dati grezzi in informazioni '
          'utili per prendere decisioni cliniche basate su evidenze, '
          'migliorando la qualità della vita degli utenti e '
          'l\'efficienza dei centri.',
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          style: GoogleFonts.inter(
            fontSize: isMobile ? 15 : 16,
            fontWeight: FontWeight.w400,
            color: AppColors.textMuted,
            height: 1.7,
          ),
        ),
        const SizedBox(height: 32),
        // Feature highlights
        Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: const [
            _HighlightChip(label: 'Dashboard in tempo reale', icon: Icons.dashboard_rounded),
            _HighlightChip(label: 'Report AI', icon: Icons.psychology_rounded),
            _HighlightChip(label: 'GDPR Compliant', icon: Icons.shield_rounded),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsVisual() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.border.withValues(alpha: 0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlue.withValues(alpha: 0.05),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        children: [
          // Presentation Image Header
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(23)),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.asset(
                'assets/images/presentation_wide.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Stats content
          Container(
            padding: const EdgeInsets.all(36),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primaryBlue.withValues(alpha: 0.03),
                  AppColors.accentTeal.withValues(alpha: 0.05),
                ],
              ),
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(23)),
            ),
            child: Column(
        children: [
          _StatItem(
            value: '3',
            label: 'Scale di valutazione\nintegrate',
            icon: Icons.checklist_rounded,
            color: AppColors.primaryBlue,
          ),
          const SizedBox(height: 24),
          _StatItem(
            value: '100%',
            label: 'Tracciabilità dei\nprogressi',
            icon: Icons.trending_up_rounded,
            color: AppColors.accentTeal,
          ),
          const SizedBox(height: 24),
          _StatItem(
            value: '−60%',
            label: 'Tempo documentazione\nrisparmiato',
            icon: Icons.timer_rounded,
            color: AppColors.accentOrange,
          ),
            ],
          ),
        ),
      ],
    ),
  );
}
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color color;

  const _StatItem({
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: 24, color: color),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: GoogleFonts.outfit(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
                height: 1,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: AppColors.textMuted,
                height: 1.4,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _HighlightChip extends StatelessWidget {
  final String label;
  final IconData icon;

  const _HighlightChip({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.primaryBlue.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: AppColors.primaryBlue.withValues(alpha: 0.12),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.primaryBlue),
          const SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryBlue,
            ),
          ),
        ],
      ),
    );
  }
}
