import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

/// Reusable section title with headline, subtitle, and accent line.
class SectionTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool centered;
  final Color? titleColor;

  const SectionTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.centered = true,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = AppTheme.isMobile(context);

    return Column(
      crossAxisAlignment:
          centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
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
        // Title
        Text(
          title,
          textAlign: centered ? TextAlign.center : TextAlign.left,
          style: GoogleFonts.outfit(
            fontSize: isMobile ? 28 : 40,
            fontWeight: FontWeight.w700,
            color: titleColor ?? AppColors.textPrimary,
            height: 1.2,
            letterSpacing: -0.5,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Text(
              subtitle!,
              textAlign: centered ? TextAlign.center : TextAlign.left,
              style: GoogleFonts.inter(
                fontSize: isMobile ? 16 : 18,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondary,
                height: 1.65,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
