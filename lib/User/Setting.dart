import 'package:adverting_app/User/AboutUs.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppThemeController {
  static final ValueNotifier<ThemeMode> themeMode =
      ValueNotifier<ThemeMode>(ThemeMode.dark);

  static void setTheme(ThemeMode mode) {
    themeMode.value = mode;
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // =========================================================
  // ALRMAN ADVERTISING THEME
  // =========================================================

  static const Color background = Color(0xFF07131B);
  static const Color card = Color(0xFF0D1B24);
  static const Color field = Color(0xFF08151D);
  static const Color cyan = Color(0xFF16C8D8);
  static const Color lightCyan = Color(0xFF9FEFF5);

  // Light theme colors
  static const Color lightBackground = Color(0xFFF3F8FA);
  static const Color lightCard = Colors.white;
  static const Color lightField = Color(0xFFE8F1F3);

  bool notificationsEnabled = true;
  bool promotionalNotifications = true;

  Future<void> _clearAppData() async {
    final shouldClear = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: _dialogCardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: Text(
            'Clear App Data',
            style: TextStyle(
              color: _textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'This will clear local app preferences. '
            'Your Firebase account will not be deleted.',
            style: TextStyle(
              color: _secondaryTextColor,
              height: 1.5,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: _secondaryTextColor,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: cyan,
                foregroundColor: Colors.white,
                elevation: 0,
              ),
              child: const Text('Clear'),
            ),
          ],
        );
      },
    );

    if (shouldClear != true) return;

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: _dialogCardColor,
        content: Text(
          'App preferences cleared.',
          style: TextStyle(
            color: _textColor,
          ),
        ),
      ),
    );
  }

  // =========================================================
  // PRIVACY
  // =========================================================

  void _openPrivacyPolicy() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const InfoPage(
          title: 'Privacy Policy',
          icon: Icons.privacy_tip_outlined,
          text: '''
At Alrman Advertising, we respect your privacy.

We only use information provided through the application
to deliver requested services, quotations and customer
support.

Your information is handled responsibly and is not sold
to third parties.

When you contact us through WhatsApp or other external
services, their own privacy policies may also apply.

For any privacy-related questions, please contact
Alrman Advertising directly.
''',
        ),
      ),
    );
  }

  // =========================================================
  // TERMS
  // =========================================================

  void _openTerms() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const InfoPage(
          title: 'Terms & Conditions',
          icon: Icons.description_outlined,
          text: '''
By using the Alrman Advertising application, you agree
to use the application responsibly.

Quotations shown inside the application are estimates
and may be adjusted after reviewing the final project
requirements.

Final pricing, production details, timelines and
installation charges may vary depending on the actual
project.

Users are responsible for providing accurate project
information.

Alrman Advertising reserves the right to update service
pricing and application features when required.
''',
        ),
      ),
    );
  }

  // =========================================================
  // HELP
  // =========================================================

  void _openHelp() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const InfoPage(
          title: 'Help & Support',
          icon: Icons.support_agent_outlined,
          text: '''
Need help?

You can contact Alrman Advertising for:

• Quotation assistance
• Service information
• Project discussions
• Printing requirements
• Branding support
• Digital marketing services

You can also use the WhatsApp option provided in the
quotation section to send your project details directly
to our team.
''',
        ),
      ),
    );
  }



  void _openAbout() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AboutUsPage(),
      ),
    );
  }


  bool get isDark =>
      AppThemeController.themeMode.value == ThemeMode.dark;

  Color get _currentBackground =>
      isDark ? background : lightBackground;

  Color get _currentCard =>
      isDark ? card : lightCard;

  Color get _currentField =>
      isDark ? field : lightField;

  Color get _textColor =>
      isDark ? Colors.white : const Color(0xFF102027);

  Color get _secondaryTextColor =>
      isDark ? Colors.white54 : const Color(0xFF60747A);

  Color get _borderColor =>
      isDark ? Colors.white10 : const Color(0xFFD5E4E8);

  Color get _dialogCardColor =>
      isDark ? card : lightCard;

  String get _themeName =>
      isDark ? 'Dark theme' : 'Light theme';

  // =========================================================
  // APPEARANCE DIALOG
  // =========================================================

  void _showAppearanceDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return ValueListenableBuilder<ThemeMode>(
          valueListenable: AppThemeController.themeMode,
          builder: (context, mode, _) {
            return AlertDialog(
              backgroundColor: _dialogCardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Text(
                'Appearance',
                style: TextStyle(
                  color: _textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _themeOption(
                    dialogContext,
                    title: 'Dark Theme',
                    subtitle: 'Alrman dark navy interface',
                    icon: Icons.dark_mode_outlined,
                    selected: mode == ThemeMode.dark,
                    onTap: () {
                      AppThemeController.setTheme(
                        ThemeMode.dark,
                      );
                      Navigator.pop(dialogContext);
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 10),
                  _themeOption(
                    dialogContext,
                    title: 'Light Theme',
                    subtitle: 'Clean bright interface',
                    icon: Icons.light_mode_outlined,
                    selected: mode == ThemeMode.light,
                    onTap: () {
                      AppThemeController.setTheme(
                        ThemeMode.light,
                      );
                      Navigator.pop(dialogContext);
                      setState(() {});
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _themeOption(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: selected
              ? cyan.withOpacity(0.10)
              : _currentField,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected
                ? cyan.withOpacity(0.40)
                : _borderColor,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: cyan.withOpacity(0.10),
                borderRadius: BorderRadius.circular(11),
              ),
              child: Icon(
                icon,
                color: cyan,
                size: 21,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: _textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: _secondaryTextColor,
                      fontSize: 11.5,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off,
              color: selected
                  ? cyan
                  : _secondaryTextColor,
            ),
          ],
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return ValueListenableBuilder<ThemeMode>(
      valueListenable: AppThemeController.themeMode,
      builder: (context, mode, _) {
        return Scaffold(
          backgroundColor: _currentBackground,

          appBar: AppBar(
            backgroundColor: _currentBackground,
            elevation: 0,
            iconTheme: IconThemeData(
              color: _textColor,
            ),
            title: Row(
              children: [
              
                const SizedBox(width: 10),
                Text(
                  'Settings',
                  style: TextStyle(
                    color: _textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                  ),
                ),
              ],
            ),
          ),

          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                16,
                8,
                16,
                35,
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                

                  _sectionTitle('ACCOUNT'),

                  const SizedBox(height: 10),

                  _accountCard(user),

                  const SizedBox(height: 24),

                  const SizedBox(height: 24),

                 

                  _sectionTitle('APP PREFERENCES'),

                  const SizedBox(height: 10),

                  _settingsCard(
                    children: [
                      _actionTile(
                        icon: Icons.dark_mode_outlined,
                        title: 'Appearance',
                        subtitle: _themeName,
                        trailing: _statusBadge(
                          isDark ? 'DARK' : 'LIGHT',
                        ),
                        onTap: _showAppearanceDialog,
                      ),

                      _divider(),

                      _actionTile(
                        icon: Icons.language_outlined,
                        title: 'Language',
                        subtitle: 'English',
                        trailing: Icon(
                          Icons.chevron_right_rounded,
                          color: _secondaryTextColor,
                        ),
                        onTap: () {
                          _showLanguageDialog();
                        },
                      ),

                      _divider(),

                    
                    ],
                  ),

                  const SizedBox(height: 24),

                  // =================================================
                  // SUPPORT
                  // =================================================

                  _sectionTitle(
                    'SUPPORT & INFORMATION',
                  ),

                  const SizedBox(height: 10),

                  _settingsCard(
                    children: [
                      _actionTile(
                        icon:
                            Icons.support_agent_outlined,
                        title: 'Help & Support',
                        subtitle: 'Get assistance',
                        trailing: Icon(
                          Icons.chevron_right_rounded,
                          color: _secondaryTextColor,
                        ),
                        onTap: _openHelp,
                      ),

                      _divider(),

                      _actionTile(
                        icon: Icons.info_outline,
                        title: 'About Us',
                        subtitle:
                            'Learn more about Alrman Advertising',
                        trailing: Icon(
                          Icons.chevron_right_rounded,
                          color: _secondaryTextColor,
                        ),
                        onTap: _openAbout,
                      ),

                      _divider(),

                      _actionTile(
                        icon:
                            Icons.privacy_tip_outlined,
                        title: 'Privacy Policy',
                        subtitle:
                            'How we handle your information',
                        trailing: Icon(
                          Icons.chevron_right_rounded,
                          color: _secondaryTextColor,
                        ),
                        onTap: _openPrivacyPolicy,
                      ),

                      _divider(),

                      _actionTile(
                        icon:
                            Icons.description_outlined,
                        title: 'Terms & Conditions',
                        subtitle:
                            'Application terms',
                        trailing: Icon(
                          Icons.chevron_right_rounded,
                          color: _secondaryTextColor,
                        ),
                        onTap: _openTerms,
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  // =================================================
                  // VERSION
                  // =================================================

                  Center(
                    child: Column(
                      children: [
                        const Text(
                          'ALRMAN ADVERTISING',
                          style: TextStyle(
                            color: cyan,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Version 1.0.0',
                          style: TextStyle(
                            color: _secondaryTextColor,
                            fontSize: 11,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '© 2026 Alrman Advertising',
                          style: TextStyle(
                            color: _secondaryTextColor
                                .withOpacity(0.6),
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // =========================================================
  // ACCOUNT CARD
  // =========================================================

  Widget _accountCard(User? user) {
    final isLoggedIn = user != null;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _currentCard,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: cyan.withOpacity(0.18),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: _currentField,
            backgroundImage:
                isLoggedIn &&
                        user.photoURL != null &&
                        user.photoURL!.isNotEmpty
                    ? NetworkImage(user.photoURL!)
                    : null,
            child:
                !isLoggedIn ||
                        user.photoURL == null ||
                        user.photoURL!.isEmpty
                    ? const Icon(
                        Icons.person,
                        color: cyan,
                        size: 28,
                      )
                    : null,
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  isLoggedIn
                      ? (user.displayName ?? 'User')
                      : 'Guest User',
                  style: TextStyle(
                    color: _textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  isLoggedIn
                      ? (user.email ??
                          user.phoneNumber ??
                          'Account')
                      : 'Not signed in',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: _secondaryTextColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          const Icon(
            Icons.verified_user_outlined,
            color: cyan,
            size: 20,
          ),
        ],
      ),
    );
  }

  // =========================================================
  // SECTION TITLE
  // =========================================================

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        title,
        style: TextStyle(
          color: _secondaryTextColor,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  // =========================================================
  // SETTINGS CARD
  // =========================================================

  Widget _settingsCard({
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: _currentCard,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: _borderColor,
        ),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  // =========================================================
  // SWITCH TILE
  // =========================================================

  Widget _switchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool>? onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 12,
      ),
      child: Row(
        children: [
          _tileIcon(icon),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: _textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  subtitle,
                  style: TextStyle(
                    color: _secondaryTextColor,
                    fontSize: 11.5,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),

          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: cyan,
            activeTrackColor:
                cyan.withOpacity(0.25),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // ACTION TILE
  // =========================================================

  Widget _actionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget trailing,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 13,
        ),
        child: Row(
          children: [
            _tileIcon(icon),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: _textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 3),

                  Text(
                    subtitle,
                    style: TextStyle(
                      color: _secondaryTextColor,
                      fontSize: 11.5,
                    ),
                  ),
                ],
              ),
            ),

            trailing,
          ],
        ),
      ),
    );
  }

  // =========================================================
  // ICON
  // =========================================================

  Widget _tileIcon(IconData icon) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: cyan.withOpacity(0.08),
        borderRadius:
            BorderRadius.circular(11),
      ),
      child: const Icon(
        Icons.settings_outlined,
        color: cyan,
        size: 21,
      )
    );

  }

  // =========================================================
  // DIVIDER
  // =========================================================

  Widget _divider() {
    return Divider(
      color: _borderColor,
      height: 1,
      indent: 68,
      endIndent: 14,
    );
  }

  // =========================================================
  // STATUS BADGE
  // =========================================================

  Widget _statusBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: cyan.withOpacity(0.10),
        borderRadius:
            BorderRadius.circular(20),
        border: Border.all(
          color: cyan.withOpacity(0.25),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: cyan,
          fontSize: 9,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.7,
        ),
      ),
    );
  }

  // =========================================================
  // LANGUAGE
  // =========================================================

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: _dialogCardColor,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(18),
          ),
          title: Text(
            'Select Language',
            style: TextStyle(
              color: _textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _languageOption(
                context,
                'English',
                true,
              ),
              _languageOption(
                context,
                'Urdu',
                false,
              ),
              _languageOption(
                context,
                'Roman Urdu',
                false,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _languageOption(
    BuildContext context,
    String title,
    bool selected,
  ) {
    return ListTile(
      onTap: () {
        Navigator.pop(context);

        if (title != 'English') {
          ScaffoldMessenger.of(this.context)
              .showSnackBar(
            SnackBar(
              content: Text(
                '$title language support can be added later.',
              ),
            ),
          );
        }
      },
      leading: Icon(
        selected
            ? Icons.radio_button_checked
            : Icons.radio_button_off,
        color:
            selected ? cyan : _secondaryTextColor,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: _textColor,
        ),
      ),
    );
  }
}

// =============================================================
// INFO PAGE
// =============================================================

class InfoPage extends StatelessWidget {
  final String title;
  final IconData icon;
  final String text;

  const InfoPage({
    super.key,
    required this.title,
    required this.icon,
    required this.text,
  });

  static const Color background = Color(0xFF07131B);
  static const Color card = Color(0xFF0D1B24);
  static const Color cyan = Color(0xFF16C8D8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,

      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          18,
          10,
          18,
          30,
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: card,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: cyan.withOpacity(0.18),
            ),
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: cyan.withOpacity(0.10),
                  borderRadius:
                      BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: cyan,
                  size: 26,
                ),
              ),

              const SizedBox(height: 18),

              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              Text(
                text,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  height: 1.8,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}