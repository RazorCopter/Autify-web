import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/animated_section.dart';
import '../widgets/feature_card.dart';
import '../widgets/section_title.dart';

/// Features section with 4 feature cards in responsive grid.
/// Each card scroll-animated with staggered delays.
class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  static final List<_FeatureData> _features = [
    _FeatureData(
      icon: Icons.hub_rounded,
      title: 'Raccolta Dati Unificata',
      description:
          'Strumenti professionali pensati per psicologi, educatori e operatori. '
          'Un unico sistema per centralizzare osservazioni, valutazioni e progressi.',
      color: AppColors.primaryBlue,
    ),
    _FeatureData(
      icon: Icons.auto_awesome_rounded,
      title: 'Analisi AI Avanzata',
      description:
          'Report intelligenti basati su IA che evidenziano trend, '
          'correlazioni e progressi dell\'utente nel tempo con suggerimenti personalizzati.',
      color: AppColors.accentTeal,
    ),
    _FeatureData(
      icon: Icons.assessment_rounded,
      title: 'Multi-Scala di Valutazione',
      description:
          'Integrazione nativa dei protocolli standardizzati POS, San Martín e SIS. '
          'Compilazione guidata con calcolo automatico dei punteggi.',
      color: AppColors.accentOrange,
    ),
    _FeatureData(
      icon: Icons.speed_rounded,
      title: 'Efficienza Operativa',
      description:
          'Automazione dei flussi documentali, gestione intuitiva delle attività '
          'e riduzione del carico burocratico per dedicare più tempo alla cura.',
      color: AppColors.accentGreen,
    ),
  ];

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
                // Feature cards grid
                _buildGrid(isMobile, isTablet),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGrid(bool isMobile, bool isTablet) {
    final crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 2);
    final childAspectRatio = isMobile ? 1.4 : (isTablet ? 1.15 : 1.35);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: _features.length,
      itemBuilder: (context, index) {
        final feature = _features[index];
        return AnimatedSection(
          delay: Duration(milliseconds: 150 * index),
          child: FeatureCard(
            icon: feature.icon,
            title: feature.title,
            description: feature.description,
            accentColor: feature.color,
          ),
        );
      },
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
