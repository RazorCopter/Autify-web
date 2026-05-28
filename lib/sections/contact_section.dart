import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/animated_section.dart';
import '../widgets/contact_form.dart';

/// Contact section with dark background and embedded form.
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
      crossAxisAlignment: CrossAxisAlignment.start,
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
        const SizedBox(height: 48),
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
        const SizedBox(height: 20),
        Text(
          'Inizia il tuo\npercorso con Autify',
          style: GoogleFonts.outfit(
            fontSize: 36,
            fontWeight: FontWeight.w700,
            color: AppColors.textOnDark,
            height: 1.2,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Unisciti alla waitlist o richiedi una demo personalizzata. '
          'Il nostro team ti guiderà nella scoperta di come Autify può '
          'trasformare il tuo centro.',
          style: GoogleFonts.inter(
            fontSize: 17,
            fontWeight: FontWeight.w400,
            color: AppColors.textOnDarkMuted,
            height: 1.7,
          ),
        ),
        const SizedBox(height: 32),
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            'assets/images/tablet_doctor.png',
            height: 240,
            width: double.infinity,
            fit: BoxFit.cover,
            alignment: const Alignment(0, -0.2),
          ),
        ),
        const SizedBox(height: 40),
        // Contact info items
        _ContactInfoItem(
          icon: Icons.email_outlined,
          text: 'info@autify.it',
        ),
        const SizedBox(height: 16),
        _ContactInfoItem(
          icon: Icons.language_rounded,
          text: 'www.autify.it',
        ),
        const SizedBox(height: 16),
        _ContactInfoItem(
          icon: Icons.shield_outlined,
          text: 'GDPR Compliant · Dati sicuri',
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
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.primaryBlue.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 18, color: AppColors.accentTeal),
        ),
        const SizedBox(width: 16),
        Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 15,
            color: AppColors.textOnDarkMuted,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
