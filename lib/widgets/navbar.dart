import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

/// Sticky top navigation bar with glassmorphism scroll effect.
class Navbar extends StatelessWidget {
  final ScrollController scrollController;
  final Map<String, GlobalKey> sectionKeys;
  final double scrollOffset;

  const Navbar({
    super.key,
    required this.scrollController,
    required this.sectionKeys,
    this.scrollOffset = 0,
  });

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isScrolled = scrollOffset > 50;
    final isMobile = AppTheme.isMobile(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 40,
        vertical: isScrolled ? 12 : 20,
      ),
      decoration: BoxDecoration(
        color: isScrolled
            ? AppColors.surface.withValues(alpha: 0.85)
            : Colors.transparent,
        boxShadow: isScrolled
            ? [
                BoxShadow(
                  color: AppColors.primaryNavy.withValues(alpha: 0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ]
            : [],
        border: isScrolled
            ? Border(
                bottom: BorderSide(
                  color: AppColors.border.withValues(alpha: 0.5),
                  width: 1,
                ),
              )
            : null,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: AppTheme.contentMaxWidth),
          child: Row(
            children: [
              // Logo
              _buildLogo(context),
              const Spacer(),
              // Nav links (desktop only)
              if (!isMobile) ..._buildNavLinks(context),
              // Mobile menu button
              if (isMobile) _buildMobileMenu(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/logo_autify_dark.png',
          height: 40,
          filterQuality: FilterQuality.high,
        ),
      ],
    );
  }

  List<Widget> _buildNavLinks(BuildContext context) {
    final items = {
      'Features': sectionKeys['features'],
      'Valore': sectionKeys['value'],
      'Contatti': sectionKeys['contact'],
    };

    return [
      ...items.entries.map((e) => _NavLink(
            label: e.key,
            onTap: () {
              if (e.value != null) _scrollToSection(e.value!);
            },
          )),
      const SizedBox(width: 16),
      _CtaNavButton(
        label: 'Richiedi Demo',
        onTap: () {
          final contactKey = sectionKeys['contact'];
          if (contactKey != null) _scrollToSection(contactKey);
        },
      ),
    ];
  }

  Widget _buildMobileMenu(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.menu_rounded, color: AppColors.primaryNavy),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: AppColors.surface,
      elevation: 8,
      onSelected: (value) {
        final key = sectionKeys[value];
        if (key != null) _scrollToSection(key);
      },
      itemBuilder: (context) => [
        _buildMenuItem('features', 'Features'),
        _buildMenuItem('value', 'Valore'),
        _buildMenuItem('contact', 'Contatti'),
      ],
    );
  }

  PopupMenuItem<String> _buildMenuItem(String value, String label) {
    return PopupMenuItem(
      value: value,
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _NavLink({required this.label, required this.onTap});

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: _isHovered
                      ? AppColors.primaryBlue
                      : AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 2),
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOut,
                height: 2,
                width: _isHovered ? 24 : 0,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CtaNavButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _CtaNavButton({required this.label, required this.onTap});

  @override
  State<_CtaNavButton> createState() => _CtaNavButtonState();
}

class _CtaNavButtonState extends State<_CtaNavButton> {
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
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            gradient: AppColors.ctaGradient,
            borderRadius: BorderRadius.circular(10),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.primaryBlue.withValues(alpha: 0.3),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : [],
          ),
          transform: _isHovered
              ? Matrix4.translationValues(0.0, -1.0, 0.0)
              : Matrix4.identity(),
          child: Text(
            widget.label,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ),
    );
  }
}
