import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/animated_section.dart';
import '../widgets/section_title.dart';

/// Features section with product mockup image + feature list layout.
class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  static const List<_FeatureData> _features = [
    _FeatureData(
      icon: Icons.hub_rounded,
      title: 'Raccolta Dati Unificata',
      description:
          'Un unico sistema per centralizzare osservazioni, valutazioni e progressi.',
      color: AppColors.primaryBlue,
    ),
    _FeatureData(
      icon: Icons.auto_awesome_rounded,
      title: 'Analisi AI Avanzata',
      description:
          'Report intelligenti che evidenziano trend, correlazioni e suggerimenti personalizzati.',
      color: AppColors.accentTeal,
    ),
    _FeatureData(
      icon: Icons.assessment_rounded,
      title: 'Multi-Scala di Valutazione',
      description:
          'Protocolli POS, San Martín e SIS con compilazione guidata e punteggio automatico.',
      color: AppColors.accentOrange,
    ),
    _FeatureData(
      icon: Icons.speed_rounded,
      title: 'Efficienza Operativa',
      description:
          'Automazione dei flussi documentali per dedicare più tempo alla cura.',
      color: AppColors.accentGreen,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = AppTheme.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: AppTheme.sectionPaddingVertical,
      ),
      decoration: const BoxDecoration(
        gradient: AppColors.featuresBgGradient,
      ),
      child: Center(
        child: Padding(
          padding: AppTheme.responsivePadding(context),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: AppTheme.contentMaxWidth),
            child: Column(
              children: [
                // Section title
                AnimatedSection(
                  child: const SectionTitle(
                    title: 'Funzionalità Avanzate',
                    subtitle:
                        'Ogni strumento è progettato per semplificare il lavoro '
                        'dei professionisti e migliorare la qualità dell\'assistenza.',
                  ),
                ),
                const SizedBox(height: 64),
                // Content: Image + Feature list
                isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left: Product mockup image
        Expanded(
          flex: 5,
          child: AnimatedSection(
            slideOffset: const Offset(-40, 0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: AppColors.imageShadow,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/ui_dashboard.png',
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 64),
        // Right: Feature list
        Expanded(
          flex: 5,
          child: Column(
            children: List.generate(_features.length, (index) {
              return AnimatedSection(
                delay: Duration(milliseconds: 100 * index),
                slideOffset: const Offset(30, 0),
                child: _CompactFeatureItem(
                  data: _features[index],
                  isLast: index == _features.length - 1,
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        // Image
        AnimatedSection(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: AppColors.mediumShadow,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/images/ui_dashboard.png',
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
        ),
        const SizedBox(height: 48),
        // Feature list
        ...List.generate(_features.length, (index) {
          return AnimatedSection(
            delay: Duration(milliseconds: 100 * index),
            child: _CompactFeatureItem(
              data: _features[index],
              isLast: index == _features.length - 1,
            ),
          );
        }),
      ],
    );
  }
}

/// Compact feature item with icon, title, and description in a row layout.
class _CompactFeatureItem extends StatefulWidget {
  final _FeatureData data;
  final bool isLast;

  const _CompactFeatureItem({required this.data, this.isLast = false});

  @override
  State<_CompactFeatureItem> createState() => _CompactFeatureItemState();
}

class _CompactFeatureItemState extends State<_CompactFeatureItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: EdgeInsets.only(bottom: widget.isLast ? 0 : 8),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: _isHovered ? AppColors.surface : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered
                ? widget.data.color.withValues(alpha: 0.2)
                : Colors.transparent,
          ),
          boxShadow: _isHovered ? AppColors.softShadow : [],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    widget.data.color.withValues(alpha: _isHovered ? 0.15 : 0.08),
                    widget.data.color.withValues(alpha: _isHovered ? 0.08 : 0.03),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                widget.data.icon,
                size: 24,
                color: widget.data.color,
              ),
            ),
            const SizedBox(width: 20),
            // Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.data.title,
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.data.description,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondary,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureData {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const _FeatureData({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });
}
