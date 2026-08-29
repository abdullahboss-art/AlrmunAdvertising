import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Chatbox.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'alrman_theme_widgets.dart';

// =========================================================================
// CONFIG
// =========================================================================

const String kWebsiteUrl = 'https://www.alrmanadvertising.com';
const String kOfficeAddress = 'Dubai, United Arab Emirates';

const String kFacebookUrl =
    'https://facebook.com/alrmanadvertising';

const String kInstagramUrl =
    'https://instagram.com/alrmanadvertising';

const String kLinkedInUrl =
    'https://linkedin.com/company/alrmanadvertising';

const String kYoutubeUrl =
    'https://youtube.com/@alrmanadvertising';

// =========================================================================
// PAGE — CONTACT US
// =========================================================================

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: const AlrmanTopBar(
        title: 'CONTACT US',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          20,
          26,
          20,
          30,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 480,
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.stretch,
              children: [
                const _ContactDetailsCard(),

                const SizedBox(height: 20),

                // const _ContactForm(),

                const SizedBox(height: 20),

           SizedBox(
  width: double.infinity,
  child: ElevatedButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ChatPage(),
        ),
      );
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.cyan,
      padding: const EdgeInsets.symmetric(
        vertical: 16,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      elevation: 0,
    ),
    child: const Text(
      'Send Message',
      style: TextStyle(
        fontSize: 14.5,
        fontWeight: FontWeight.w800,
        color: Color(0xFF04222A),
      ),
    ),
  ),
),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// =========================================================================
// CONTACT FORM
// =========================================================================

class _ContactForm extends StatefulWidget {
  const _ContactForm();

  @override
  State<_ContactForm> createState() =>
      _ContactFormState();
}

class _ContactFormState extends State<_ContactForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController =
      TextEditingController();

  final TextEditingController _emailController =
      TextEditingController();

  final TextEditingController _messageController =
      TextEditingController();

  bool _isSending = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  // =========================================================================
  // SUBMIT FORM
  // =========================================================================

  Future<void> _submitForm() async {
  if (!_formKey.currentState!.validate()) {
    return;
  }

  setState(() {
    _isSending = true;
  });

  final String name = _nameController.text.trim();
  final String email = _emailController.text.trim();
  final String message = _messageController.text.trim();

  try {
    await FirebaseFirestore.instance
        .collection('contact_messages')
        .add({
      'name': name,
      'email': email,
      'message': message,
      'status': 'new',
      'createdAt': FieldValue.serverTimestamp(),
    });

    if (!mounted) return;

    setState(() {
      _isSending = false;
    });

    _nameController.clear();
    _emailController.clear();
    _messageController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Message submitted successfully!',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  } catch (e) {
    if (!mounted) return;

    setState(() {
      _isSending = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Failed to submit message: $e',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
  // =========================================================================
  // INPUT DECORATION
  // =========================================================================

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: AppColors.textDim,
        fontSize: 13,
      ),
      prefixIcon: Icon(
        icon,
        color: AppColors.cyan,
        size: 19,
      ),
      filled: true,
      fillColor: AppColors.bg,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: AppColors.border,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: AppColors.border,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: AppColors.cyan,
          width: 1.3,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Colors.redAccent,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Colors.redAccent,
          width: 1.3,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 15,
      ),
    );
  }

  // =========================================================================
  // FORM UI
  // =========================================================================

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        22,
        24,
        22,
        26,
      ),
      decoration: BoxDecoration(
        color: AppColors.panel,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.border,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Text(
              'Send Us a Message',
              style: TextStyle(
                color: AppColors.text,
                fontSize: 19,
                fontWeight: FontWeight.w800,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              'Fill out the form and we will get back to you.',
              style: TextStyle(
                color: AppColors.textDim,
                fontSize: 12.5,
              ),
            ),

            const SizedBox(height: 22),

            // NAME
            TextFormField(
              controller: _nameController,
              style: const TextStyle(
                color: AppColors.text,
                fontSize: 13.5,
              ),
              decoration: _inputDecoration(
                hint: 'Enter your name',
                icon: Icons.person_outline_rounded,
              ),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),

            const SizedBox(height: 15),

            // EMAIL
            TextFormField(
              controller: _emailController,
              keyboardType:
                  TextInputType.emailAddress,
              style: const TextStyle(
                color: AppColors.text,
                fontSize: 13.5,
              ),
              decoration: _inputDecoration(
                hint: 'Enter your email',
                icon: Icons.email_outlined,
              ),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return 'Please enter your email';
                }

                final emailRegex = RegExp(
                  r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                );

                if (!emailRegex.hasMatch(
                  value.trim(),
                )) {
                  return 'Please enter a valid email';
                }

                return null;
              },
            ),

            const SizedBox(height: 15),

            // MESSAGE
            TextFormField(
              controller: _messageController,
              maxLines: 5,
              style: const TextStyle(
                color: AppColors.text,
                fontSize: 13.5,
              ),
              decoration: _inputDecoration(
                hint: 'Write your message...',
                icon: Icons.message_outlined,
              ),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return 'Please enter your message';
                }

                return null;
              },
            ),

            const SizedBox(height: 20),

            // SUBMIT BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed:
                    _isSending
                        ? null
                        : _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      AppColors.cyan,
                  foregroundColor:
                      const Color(0xFF04222A),
                  padding:
                      const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                child: _isSending
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child:
                            CircularProgressIndicator(
                          strokeWidth: 2,
                          color:
                              Color(0xFF04222A),
                        ),
                      )
                    : const Text(
                        'Submit Message',
                        style: TextStyle(
                          fontSize: 14.5,
                          fontWeight:
                              FontWeight.w800,
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

// =========================================================================
// CONTACT DETAILS + SOCIAL ICONS CARD
// =========================================================================

class _ContactDetailsCard
    extends StatelessWidget {
  const _ContactDetailsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        22,
        24,
        22,
        26,
      ),
      decoration: BoxDecoration(
        color: AppColors.panel,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.border,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Text(
            'Contact Us',
            style: TextStyle(
              color: AppColors.text,
              fontSize: 19,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 4),

          const Text(
            'We are here to help you',
            style: TextStyle(
              color: AppColors.textDim,
              fontSize: 12.5,
            ),
          ),

          const SizedBox(height: 22),

          _DetailRow(
            icon: Icons.call_rounded,
            iconColor: AppColors.call,
            title: kPhoneNumber,
            subtitle: 'Call us anytime',
            onTap: callNow,
          ),

          const SizedBox(height: 16),

          _DetailRow(
            icon: Icons.email_rounded,
            iconColor: AppColors.email,
            title: kEmailAddress,
            subtitle: 'Drop us an email',
            onTap: sendEmail,
          ),

          const SizedBox(height: 16),

          _DetailRow(
            icon: Icons.language_rounded,
            iconColor: AppColors.cyan,
            title: kWebsiteUrl.replaceFirst(
              'https://',
              '',
            ),
            subtitle: 'Visit our website',
            onTap: () =>
                launchUrlSafely(kWebsiteUrl),
          ),

          const SizedBox(height: 16),

          _DetailRow(
            icon: Icons.location_on_rounded,
            iconColor: AppColors.gold,
            title: kOfficeAddress,
            subtitle: 'Our office location',
            onTap: () => launchUrlSafely(
              'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(kOfficeAddress)}',
            ),
          ),

          const SizedBox(height: 28),

          const Center(
            child: Text(
              'Follow Us',
              style: TextStyle(
                color: AppColors.text,
                fontSize: 13.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          const SizedBox(height: 14),

          const _SocialIconsRow(),
        ],
      ),
    );
  }
}

// =========================================================================
// DETAIL ROW
// =========================================================================

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _DetailRow({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 4,
        ),
        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.center,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: iconColor.withOpacity(0.14),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 19,
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.text,
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 2),

                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: AppColors.textDim,
                      fontSize: 11.5,
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

// =========================================================================
// SOCIAL ICONS ROW
// =========================================================================

class _SocialIconsRow
    extends StatelessWidget {
  const _SocialIconsRow();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 12,
      runSpacing: 10,
      children: [
        _SocialCircle(
          icon: FontAwesomeIcons.facebookF,
          color: const Color(0xFF1877F2),
          onTap: () =>
              launchUrlSafely(kFacebookUrl),
        ),

        _SocialCircle(
          icon: FontAwesomeIcons.instagram,
          color: const Color(0xFFE1306C),
          onTap: () =>
              launchUrlSafely(kInstagramUrl),
        ),

        _SocialCircle(
          icon: FontAwesomeIcons.linkedinIn,
          color: const Color(0xFF0A66C2),
          onTap: () =>
              launchUrlSafely(kLinkedInUrl),
        ),

        _SocialCircle(
          icon: FontAwesomeIcons.whatsapp,
          color: AppColors.whatsapp,
          onTap: openWhatsApp,
        ),

        _SocialCircle(
          icon: FontAwesomeIcons.youtube,
          color: const Color(0xFFFF0000),
          onTap: () =>
              launchUrlSafely(kYoutubeUrl),
        ),
      ],
    );
  }
}

// =========================================================================
// SOCIAL CIRCLE
// =========================================================================

class _SocialCircle
    extends StatelessWidget {
  final FaIconData icon;
  final Color color;
  final VoidCallback onTap;

  const _SocialCircle({
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.35),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: FaIcon(
          icon,
          color: Colors.white,
          size: 17,
        ),
      ),
    );
  }
}

// =========================================================================
// SEND MESSAGE BUTTON
// =========================================================================

class _StartChatButton extends StatelessWidget {
  final VoidCallback onTap;

  const _StartChatButton({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: const Icon(
          Icons.chat_bubble_outline_rounded,
          size: 20,
        ),
        label: const Text(
          'Start a Conversation',
          style: TextStyle(
            fontSize: 14.5,
            fontWeight: FontWeight.w800,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.cyan,
          foregroundColor: const Color(0xFF04222A),
          padding: const EdgeInsets.symmetric(
            vertical: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 0,
        ),
      ),
    );
  }
}