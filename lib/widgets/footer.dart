import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

/// Landing page footer with copyright, links, and social icons.
class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = AppTheme.isMobile(context);
    final year = DateTime.now().year;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: 40,
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryNavy,
        border: Border(
          top: BorderSide(
            color: AppColors.primaryBlue.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: AppTheme.contentMaxWidth),
          child: isMobile ? _buildMobileLayout(year) : _buildDesktopLayout(year),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(int year) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Logo + Copyright
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/logo_autify_dark.png',
                  height: 32,
                  filterQuality: FilterQuality.high,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              '© $year Autify.it — Tutti i diritti riservati',
              style: GoogleFonts.inter(
                fontSize: 13,
                color: AppColors.textOnDarkMuted,
              ),
            ),
          ],
        ),
        const Spacer(),
        // Links
        _FooterLink(label: 'Privacy Policy', onTap: () {}),
        const SizedBox(width: 32),
        _FooterLink(label: 'Termini di Servizio', onTap: () {}),
        const SizedBox(width: 32),
        _FooterLink(label: 'info@autify.it', onTap: () {}),
      ],
    );
  }

  Widget _buildMobileLayout(int year) {
    return Column(
      children: [
        Image.asset(
          'assets/images/logo_autify_dark.png',
          height: 32,
          filterQuality: FilterQuality.high,
        ),
        const SizedBox(height: 20),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 24,
          runSpacing: 8,
          children: [
            _FooterLink(label: 'Privacy Policy', onTap: () {}),
            _FooterLink(label: 'Termini di Servizio', onTap: () {}),
            _FooterLink(label: 'info@autify.it', onTap: () {}),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          '© $year Autify.it — Tutti i diritti riservati',
          style: GoogleFonts.inter(
            fontSize: 13,
            color: AppColors.textOnDarkMuted,
          ),
        ),
      ],
    );
  }
}

class _FooterLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _FooterLink({required this.label, required this.onTap});

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: _isHovered ? Colors.white : AppColors.textOnDarkMuted,
          ),
          child: Text(widget.label),
        ),
      ),
    );
  }
}
