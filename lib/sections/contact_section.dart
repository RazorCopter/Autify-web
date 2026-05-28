import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/animated_section.dart';
import '../widgets/contact_form.dart';

/// Contact section with dark background, text info on the left, and form on the right.
class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = AppTheme.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: AppTheme.sectionPaddingVertical,
      ),
      decoration: const BoxDecoration(
        gradient: AppColors.darkGradient,
      ),
      child: Center(
        child: Padding(
          padding: AppTheme.responsivePadding(context),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: AppTheme.contentMaxWidth),
            child: isMobile
                ? _buildMobileLayout(context)
                : _buildDesktopLayout(context),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left: Text info
        Expanded(
          flex: 4,
          child: AnimatedSection(
            slideOffset: const Offset(-30, 0),
            child: _buildInfoColumn(),
          ),
        ),
        const SizedBox(width: 80),
        // Right: Form
        Expanded(
          flex: 5,
          child: AnimatedSection(
            delay: const Duration(milliseconds: 200),
            child: const ContactForm(),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        AnimatedSection(child: _buildInfoColumn()),
        const SizedBox(height: 64),
        AnimatedSection(
          delay: const Duration(milliseconds: 200),
          child: const ContactForm(),
        ),
      ],
    );
  }

  Widget _buildInfoColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Accent line
        Container(
          width: 48,
          height: 3,
          decoration: BoxDecoration(
            gradient: AppColors.ctaGradient,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Inizia il tuo\npercorso con Autify',
          style: GoogleFonts.outfit(
            fontSize: 42,
            fontWeight: FontWeight.w700,
            color: AppColors.textOnDark,
            height: 1.15,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Compila il form per richiedere una demo o ricevere maggiori informazioni. '
          'Il nostro team ti guiderà nella scoperta di come Autify può '
          'trasformare il tuo centro.',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: AppColors.textOnDarkMuted,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 48),
        // Trust Bar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: AppColors.surface.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.surface.withValues(alpha: 0.1),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TrustFeature(icon: Icons.shield_rounded, text: 'Dati Sicuri & GDPR Compliant'),
              const SizedBox(height: 12),
              _TrustFeature(icon: Icons.support_agent_rounded, text: 'Supporto Dedicato'),
              const SizedBox(height: 12),
              _TrustFeature(icon: Icons.handshake_rounded, text: 'Partner Affidabile'),
            ],
          ),
        ),
        const SizedBox(height: 48),
        // Contact info items
        _ContactInfoItem(
          icon: Icons.email_outlined,
          text: 'info@autify.it',
        ),
      ],
    );
  }
}

class _TrustFeature extends StatelessWidget {
  final IconData icon;
  final String text;

  const _TrustFeature({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.accentTeal),
        const SizedBox(width: 12),
        Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: AppColors.textOnDark,
          ),
        ),
      ],
    );
  }
}

class _ContactInfoItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _ContactInfoItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.primaryBlue.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: 20, color: AppColors.accentTeal),
        ),
        const SizedBox(width: 16),
        Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 16,
            color: AppColors.textOnDarkMuted,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
