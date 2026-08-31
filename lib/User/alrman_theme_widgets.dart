import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// =========================================================================
// This file holds everything SHARED across pages: colors, theme, contact
// helpers (WhatsApp / Call / Email), and reusable widgets like the top bar,
// section headings, and cards. Import this file from every page that needs
// them (GetQuote.dart, Contact.dart, Gallery.dart, etc).
//
//   import 'alrman_theme_widgets.dart';
//
// IMPORTANT: Remove the duplicate copies of these classes/constants from
// GetQuote.dart (and any other file) once you add this file, otherwise
// Dart will throw "duplicate definition" errors.
// =========================================================================

class AppColors {
  static const bg = Color(0xFF0A0E16);
  static const panel = Color(0xFF111826);
  static const panel2 = Color(0xFF0D1420);
  static const border = Color(0xFF1E2937);
  static const cyan = Color(0xFF2FD6F0);
  static const cyanSoft = Color(0xFF7FE4F4);
  static const text = Color(0xFFF2F5F8);
  static const textDim = Color(0xFF93A1B4);
  static const whatsapp = Color(0xFF34C76F);
  static const call = Color(0xFF4AA8FF);
  static const email = Color(0xFFFF9D3D);
  static const gold = Color(0xFFD9B872);
}

/// The single WhatsApp / phone number used across the app.
/// Change these three constants to update every button in the app.
const String kPhoneNumber = '+971527898516';
const String kWhatsAppUrl = 'https://wa.me/971527898516';
const String kEmailAddress = 'info@alrmanadvertising.com';

ThemeData buildAppTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.bg,
    fontFamily: 'Roboto',
    colorScheme: const ColorScheme.dark(
      primary: AppColors.cyan,
      surface: AppColors.bg,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: AppColors.text),
    ),
  );
}

// =========================================================================
// CONTACT LAUNCH HELPERS
// =========================================================================

Future<void> launchUrlSafely(String url) async {
  final uri = Uri.parse(url);
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    debugPrint('Could not launch $url');
  }
}

Future<void> openWhatsApp([String? message]) async {
  final text = Uri.encodeComponent(
    message ??
        "Hello ALRMAN Advertising Team,\n\n"
        "I visited your application and I'm interested in your services. "
        "I would like to discuss my project and get more information.\n\n"
        "Looking forward to your response.\n\n"
        "Thank you.",
  );

  final url = "https://wa.me/971527898516?text=$text";

  await launchUrl(
    Uri.parse(url),
    mode: LaunchMode.externalApplication,
  );
}

Future<void> callNow() async {
  final Uri uri = Uri(scheme: 'tel', path: kPhoneNumber);

  if (!await launchUrl(uri)) {
    debugPrint("Phone app not found.");
  }
}

Future<void> sendEmail() async {
  final Uri gmailUri = Uri.parse(
    'https://mail.google.com/mail/?view=cm&fs=1'
    '&to=info@alrmanadvertising.com'
    '&su=Project Inquiry'
    '&body=Hello Alrman Team,%0A%0AI would like to discuss my project.',
  );

  await launchUrl(
    gmailUri,
    mode: LaunchMode.externalApplication,
  );
}

// =========================================================================
// DATA — the 8 portfolio pieces shared by the Quote strip and Gallery grid
// =========================================================================

enum WorkCategory { branding, print, interior, vehicle }

class WorkItem {
  final String title;
  final String categoryLabel;
  final WorkCategory category;
  final List<Color> gradient;

  const WorkItem({
    required this.title,
    required this.categoryLabel,
    required this.category,
    required this.gradient,
  });
}

const List<WorkItem> kWorkItems = [
  WorkItem(
    title: 'Storefront Signage',
    categoryLabel: 'BRANDING',
    category: WorkCategory.branding,
    gradient: [Color(0xFF2A2016), Color(0xFF141019)],
  ),
  WorkItem(
    title: 'Corporate Magazine',
    categoryLabel: 'PRINT',
    category: WorkCategory.print,
    gradient: [Color(0xFF1C2430), Color(0xFF0E131B)],
  ),
  WorkItem(
    title: 'Office Reception Wall',
    categoryLabel: 'INTERIOR',
    category: WorkCategory.interior,
    gradient: [Color(0xFF161D26), Color(0xFF0A0E14)],
  ),
  WorkItem(
    title: 'Fleet Wrap Design',
    categoryLabel: 'VEHICLES',
    category: WorkCategory.vehicle,
    gradient: [Color(0xFF1A2028), Color(0xFF0B0F16)],
  ),
  WorkItem(
    title: 'Identity & Logo Suite',
    categoryLabel: 'BRANDING',
    category: WorkCategory.branding,
    gradient: [Color(0xFF25201A), Color(0xFF12100C)],
  ),
  WorkItem(
    title: 'Product Brochure',
    categoryLabel: 'PRINT',
    category: WorkCategory.print,
    gradient: [Color(0xFF1E2A22), Color(0xFF0C130E)],
  ),
  WorkItem(
    title: 'Showroom Fit-out',
    categoryLabel: 'INTERIOR',
    category: WorkCategory.interior,
    gradient: [Color(0xFF20222C), Color(0xFF0D0E14)],
  ),
  WorkItem(
    title: 'Delivery Van Wrap',
    categoryLabel: 'VEHICLES',
    category: WorkCategory.vehicle,
    gradient: [Color(0xFF1A2530), Color(0xFF0A0E14)],
  ),
];

/// Top bar used on every screen (Quote / Gallery / Contact / Detail).
class AlrmanTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;

  const AlrmanTopBar({super.key, required this.title, this.onBack, required Color color});

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            _circleIcon(
              icon: Icons.arrow_back_ios_new_rounded,
              onTap: onBack ??
                  () {
                    if (Navigator.of(context).canPop()) {
                      Navigator.of(context).pop();
                    }
                  },
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.cyan,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(width: 30, height: 2, color: AppColors.cyan),
                ],
              ),
            ),
            _circleIcon(
              icon: Icons.chat_bubble_outline_rounded,
              onTap: openWhatsApp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _circleIcon({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.04),
          border: Border.all(color: AppColors.border),
        ),
        child: Icon(icon, size: 16, color: AppColors.text),
      ),
    );
  }
}

/// "—— LABEL ——" section heading used before each section.
class SectionHeading extends StatelessWidget {
  final String label;
  final String? subtitle;

  const SectionHeading({super.key, required this.label, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(width: 26, height: 1, color: const Color(0xFF2A3644)),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.cyan,
                fontSize: 13,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(width: 10),
            Container(width: 26, height: 1, color: const Color(0xFF2A3644)),
          ],
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 8),
          Text(
            subtitle!,
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.textDim, fontSize: 12.5),
          ),
        ],
      ],
    );
  }
}

/// One of the 4 icons in the "Free Consultation / Custom Pricing / ..." strip.
class FeatureItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool showDivider;

  const FeatureItem({
    super.key,
    required this.icon,
    required this.label,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(border: _borderFor()),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppColors.cyan, size: 24),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textDim,
                fontSize: 11.5,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Border? _borderFor() {
    if (!showDivider) return null;
    return const Border(right: BorderSide(color: AppColors.border, width: 1));
  }
}

/// Card used inside "Why Choose Alrman?" grid.
///
/// Hover behavior: on web/desktop, hovering the mouse over the card swaps
/// its content from the short icon/title/subtitle view to a details view
/// (using [details]) with an animated fade + size transition. Moving the
/// mouse away reverts it. On touch devices (no mouse), tapping the card
/// toggles the same state as a fallback since MouseRegion never fires there.
///
/// Visual style: circular gradient icon badge, top accent strip, soft
/// gradient background and elevation shadow for a more premium feel.
class WhyCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String details;

  const WhyCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.details,
  });

  @override
  State<WhyCard> createState() => _WhyCardState();
}

class _WhyCardState extends State<WhyCard> {
  bool _hovering = false;

  void _setHover(bool value) {
    if (_hovering != value) {
      setState(() => _hovering = value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _setHover(true),
      onExit: (_) => _setHover(false),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _setHover(!_hovering),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.panel,
                AppColors.panel2,
              ],
            ),
            border: Border.all(
              color: _hovering ? AppColors.cyan : AppColors.border,
              width: _hovering ? 1.4 : 1,
            ),
            boxShadow: _hovering
                ? [
                    BoxShadow(
                      color: AppColors.cyan.withOpacity(0.18),
                      blurRadius: 18,
                      spreadRadius: -2,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top accent strip
                Container(
                  height: 3,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.cyan.withOpacity(_hovering ? 1 : 0.35),
                        AppColors.cyanSoft.withOpacity(_hovering ? 1 : 0.15),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 220),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: SizeTransition(
                          sizeFactor: animation,
                          axisAlignment: -1,
                          child: child,
                        ),
                      );
                    },
                    child: _hovering
                        ? _buildDetails(key: const ValueKey('details'))
                        : _buildFront(key: const ValueKey('front')),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFront({Key? key}) {
    return Column(
      key: key,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Icon sits in a soft circular gradient badge instead of bare icon
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.cyan.withOpacity(0.18),
                AppColors.cyan.withOpacity(0.05),
              ],
            ),
            border: Border.all(color: AppColors.cyan.withOpacity(0.35)),
          ),
          child: Icon(widget.icon, color: AppColors.cyan, size: 20),
        ),
        const SizedBox(height: 12),
        Text(
          widget.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: AppColors.text,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          widget.subtitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 11.5,
            color: AppColors.textDim,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildDetails({Key? key}) {
    return Column(
      key: key,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.cyan.withOpacity(0.14),
              ),
              child: Icon(widget.icon, color: AppColors.cyan, size: 14),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                widget.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 12.5, fontWeight: FontWeight.w700, color: AppColors.text),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          widget.details,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 10.5, color: AppColors.textDim, height: 1.4),
        ),
      ],
    );
  }
}

/// A single "Let's Connect" contact card (WhatsApp / Call / Email).
class ConnectCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String description;
  final String ctaLabel;
  final VoidCallback onTap;

  const ConnectCard({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.description,
    required this.ctaLabel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: AppColors.panel2,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withOpacity(0.14),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(height: 10),
            Text(title,
                style: const TextStyle(
                    fontSize: 13.5, fontWeight: FontWeight.w700, color: AppColors.text)),
            const SizedBox(height: 4),
            SizedBox(
              height: 28,
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 10.5, color: AppColors.textDim, height: 1.3),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.cyan,
                borderRadius: BorderRadius.circular(9),
              ),
              child: Text(
                ctaLabel,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF04222A),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Bottom "Need More Help? / Start Conversation" banner.
class HelpBanner extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonLabel;
  final VoidCallback onTap;

  const HelpBanner({
    super.key,
    required this.title,
    required this.subtitle,
    required this.buttonLabel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 30, 20, 34),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.panel,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF17414A)),
            ),
            child: const Icon(Icons.support_agent_rounded, color: AppColors.cyan, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: AppColors.cyan, fontSize: 13.5, fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text(subtitle,
                    style: const TextStyle(color: AppColors.textDim, fontSize: 11.5, height: 1.4)),
              ],
            ),
          ),
          const SizedBox(width: 10),
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.cyan,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                buttonLabel,
                style: const TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF04222A),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
