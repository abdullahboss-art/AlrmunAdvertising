import 'package:adverting_app/User/Login.dart';
import 'package:adverting_app/admin/admin_login.dart';
import 'package:flutter/material.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  static const Color bgColor = Color(0xFF06131A);
  static const Color panelColor = Color(0xFF0B1C24);
  static const Color panelColor2 = Color(0xFF0E222B);
  static const Color borderColor = Color(0xFF1A303A);

  static const Color cyan = Color(0xFF16B7C9);
  static const Color cyanDark = Color(0xFF0A8F9E);

  static const Color textColor = Color(0xFFEAF4F6);
  static const Color textDim = Color(0xFF71808C);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Stack(
          children: [
            // ==========================================
            // BACKGROUND GLOW
            // ==========================================

            Positioned(
              top: -100,
              left: -80,
              child: Container(
                width: 260,
                height: 260,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: cyan.withOpacity(0.055),
                ),
              ),
            ),

            Positioned(
              bottom: -120,
              right: -80,
              child: Container(
                width: 280,
                height: 280,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: cyan.withOpacity(0.035),
                ),
              ),
            ),

            // ==========================================
            // MAIN CONTENT
            // ==========================================

            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 28,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 430,
                  ),
                  child: Column(
                    children: [
                      // ======================================
                      // LOGO — full logo, no circle crop, no glow
                      // ======================================

                      Image.asset(
                        'images/assets/Alrmun_logo.png',
                        width: 130,
                        height: 130,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.restaurant_rounded,
                            color: cyan,
                            size: 50,
                          );
                        },
                      ),

                      const SizedBox(height: 28),

                      // ======================================
                      // WELCOME TEXT
                      // ======================================

                      const Text(
                        'Welcome to QuickBite',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.3,
                        ),
                      ),

                      const SizedBox(height: 9),

                      const Text(
                        'Choose an option to continue',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: textDim,
                          fontSize: 12.5,
                          height: 1.4,
                        ),
                      ),

                      const SizedBox(height: 34),

                      // ======================================
                      // USER LOGIN CARD
                      // ======================================

                      _RoleCard(
                        icon: Icons.person_outline_rounded,
                        title: 'User Login',
                        description:
                            'Login to order your favorite food',
                        isPrimary: true,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const LoginPage(),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 14),

                      // ======================================
                      // ADMIN LOGIN CARD
                      // ======================================

                      _RoleCard(
                        icon: Icons.admin_panel_settings_outlined,
                        title: 'Admin Login',
                        description:
                            'Manage orders, foods and users',
                        isPrimary: false,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const AdminLogin(),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 34),

                      // ======================================
                      // FOOTER
                      // ======================================

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                              color: cyan,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Fast • Fresh • Easy',
                            style: TextStyle(
                              color: textDim,
                              fontSize: 10.5,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        'Your food, your way.',
                        style: TextStyle(
                          color: Color(0xFF435660),
                          fontSize: 9.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================================
// ROLE CARD
// ==========================================================

class _RoleCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final bool isPrimary;
  final VoidCallback onTap;

  const _RoleCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.isPrimary,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        splashColor: RoleSelectionScreen.cyan.withOpacity(0.08),
        highlightColor:
            RoleSelectionScreen.cyan.withOpacity(0.04),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isPrimary
                ? RoleSelectionScreen.cyan
                : RoleSelectionScreen.panelColor,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isPrimary
                  ? RoleSelectionScreen.cyan
                  : RoleSelectionScreen.borderColor,
              width: 1,
            ),
            boxShadow: isPrimary
                ? [
                    BoxShadow(
                      color: RoleSelectionScreen.cyan
                          .withOpacity(0.16),
                      blurRadius: 22,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.18),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ],
          ),
          child: Row(
            children: [
              // ============================================
              // ICON
              // ============================================

              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: isPrimary
                      ? RoleSelectionScreen.cyanDark
                      : RoleSelectionScreen.panelColor2,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isPrimary
                        ? RoleSelectionScreen.cyanDark
                        : RoleSelectionScreen.borderColor,
                  ),
                ),
                child: Icon(
                  icon,
                  size: 24,
                  color: isPrimary
                      ? const Color(0xFF05242A)
                      : RoleSelectionScreen.cyan,
                ),
              ),

              const SizedBox(width: 14),

              // ============================================
              // TEXT
              // ============================================

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: isPrimary
                            ? const Color(0xFF05242A)
                            : RoleSelectionScreen.textColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      description,
                      style: TextStyle(
                        color: isPrimary
                            ? const Color(0xFF15515A)
                            : RoleSelectionScreen.textDim,
                        fontSize: 10.5,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // ============================================
              // ARROW
              // ============================================

              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: isPrimary
                      ? const Color(0xFF0A8F9E)
                      : RoleSelectionScreen.panelColor2,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_forward_rounded,
                  size: 16,
                  color: isPrimary
                      ? const Color(0xFF05242A)
                      : RoleSelectionScreen.textDim,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}