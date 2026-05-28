import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/animated_section.dart';

/// Value section focusing on benefits and statistics.
/// Uses a wide presentation image as a banner above the stats.
class ValueSection extends StatelessWidget {
  const ValueSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = AppTheme.isMobile(context);
    final isTablet = AppTheme.isTablet(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: AppTheme.sectionPaddingVertical,
      ),
      color: AppColors.background,
      child: Center(
        child: Padding(
          padding: AppTheme.responsivePadding(context),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: AppTheme.contentMaxWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Header Text
                AnimatedSection(
                  child: Text(
                    'Il Valore per il tuo Centro',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      fontSize: isMobile ? 32 : 48,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                      height: 1.15,
                      letterSpacing: -1,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                AnimatedSection(
                  delay: const Duration(milliseconds: 100),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: Text(
                      'Un sistema progettato non solo per archiviare dati, ma per '
                      'generare insight, migliorare gli esiti e ottimizzare il lavoro di squadra.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: isMobile ? 16 : 18,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textSecondary,
                        height: 1.6,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 64),
                
                // Wide Banner Image
                AnimatedSection(
                  delay: const Duration(milliseconds: 200),
                  child: Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(maxHeight: 450),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: AppColors.imageShadow,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.asset(
                        'assets/images/presentation_wide.png',
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 64),
                
                // Stats Row/Column
                AnimatedSection(
                  delay: const Duration(milliseconds: 300),
                  child: isMobile
                      ? _buildMobileStats()
                      : _buildDesktopStats(isTablet),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopStats(bool isTablet) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 48),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
        boxShadow: AppColors.softShadow,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatColumn(
            value: '3',
            label: 'Scale di valutazione\nintegrate',
            icon: Icons.checklist_rounded,
            color: AppColors.primaryBlue,
          ),
          Container(height: 80, width: 1, color: AppColors.border),
          _StatColumn(
            value: '100%',
            label: 'Tracciabilità dei\nprogressi',
            icon: Icons.trending_up_rounded,
            color: AppColors.accentTeal,
          ),
          Container(height: 80, width: 1, color: AppColors.border),
          _StatColumn(
            value: '−60%',
            label: 'Tempo documentazione\nrisparmiato',
            icon: Icons.timer_rounded,
            color: AppColors.accentOrange,
          ),
        ],
      ),
    );
  }

  Widget _buildMobileStats() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        children: [
          _StatColumn(
            value: '3',
            label: 'Scale di valutazione\nintegrate',
            icon: Icons.checklist_rounded,
            color: AppColors.primaryBlue,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Divider(color: AppColors.border),
          ),
          _StatColumn(
            value: '100%',
            label: 'Tracciabilità dei\nprogressi',
            icon: Icons.trending_up_rounded,
            color: AppColors.accentTeal,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Divider(color: AppColors.border),
          ),
          _StatColumn(
            value: '−60%',
            label: 'Tempo documentazione\nrisparmiato',
            icon: Icons.timer_rounded,
            color: AppColors.accentOrange,
          ),
        ],
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color color;

  const _StatColumn({
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(height: 16),
        Text(
          value,
          style: GoogleFonts.outfit(
            fontSize: 42,
            fontWeight: FontWeight.w700,
            color: color,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
