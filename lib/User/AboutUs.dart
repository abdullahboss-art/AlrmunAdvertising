import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  static const Color background = Color(0xff07131B);
  static const Color card = Color(0xff0D1B24);
  static const Color field = Color(0xff08151D);
  static const Color cyan = Color(0xff16C8D8);
  static const Color lightCyan = Color(0xff9FEFF5);

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
        title: Row(
          children: [
            // Image.asset(
            //   'images/assets/Alrmun_logo.png',
            //   height: 38,
            //   width: 38,
            //   fit: BoxFit.contain,
            // ),
            const SizedBox(width: 10),
            const Text(
              'About Us',
              style: TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            18,
            10,
            18,
            30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHero(),
              const SizedBox(height: 18),
              _buildAboutCard(),
              const SizedBox(height: 18),
              _buildServicesCard(),
              const SizedBox(height: 18),
              _buildMissionCard(),
              const SizedBox(height: 18),
              _buildWhyUsCard(),
              const SizedBox(height: 18),
              _buildContactCard(),
              const SizedBox(height: 25),
              const Center(
                child: Text(
                  '© 2026 Alrman Advertising',
                  style: TextStyle(
                    color: Colors.white38,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================================
  // HERO
  // =========================================================

  Widget _buildHero() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            cyan.withOpacity(0.15),
            card,
          ],
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: cyan.withOpacity(0.30),
        ),
        boxShadow: [
          BoxShadow(
            color: cyan.withOpacity(0.06),
            blurRadius: 25,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 90,
            height: 90,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.20),
              shape: BoxShape.circle,
              border: Border.all(
                color: cyan.withOpacity(0.35),
              ),
            ),
            child: Image.asset(
              'images/assets/Alrmun_logo.png',
              fit: BoxFit.contain,
            ),
          ),

          const SizedBox(height: 18),

          const Text(
            'ALRMAN ADVERTISING',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.5,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Creativity That Builds Brands',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: cyan,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.4,
            ),
          ),

          const SizedBox(height: 14),

          const Text(
            'Creative design, branding, digital marketing, '
            'printing and visual solutions for businesses '
            'that want to stand out.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 13.5,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // ABOUT
  // =========================================================

  Widget _buildAboutCard() {
    return _sectionCard(
      icon: Icons.auto_awesome_rounded,
      title: 'Who We Are',
      child: const Text(
        'At Alrman Advertising, we turn ideas into powerful '
        'visual experiences that help businesses stand out, '
        'connect with their audience, and grow with confidence.\n\n'
        'We combine creativity, modern design and professional '
        'advertising solutions to bring every project to life.',
        style: TextStyle(
          color: Colors.white70,
          fontSize: 14,
          height: 1.7,
        ),
      ),
    );
  }

  // =========================================================
  // SERVICES
  // =========================================================

  Widget _buildServicesCard() {
    final services = [
      (
        Icons.palette_outlined,
        'Graphic Design',
        'Creative visuals and professional designs.'
      ),
      (
        Icons.movie_creation_outlined,
        'Animation & Media',
        'Engaging animation and media production.'
      ),
      (
        Icons.view_in_ar_outlined,
        '3D Visualization',
        'High-quality 3D visualization and rendering.'
      ),
      (
        Icons.print_outlined,
        'Digital & Offset Printing',
        'Reliable and professional printing solutions.'
      ),
      (
        Icons.campaign_outlined,
        'Digital Marketing',
        'Creative strategies to grow your brand online.'
      ),
      (
        Icons.business_outlined,
        'Branding',
        'Memorable identities built around your business.'
      ),
    ];

    return _sectionCard(
      icon: Icons.design_services_outlined,
      title: 'What We Do',
      child: Column(
        children: services.map((service) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _serviceItem(
              icon: service.$1,
              title: service.$2,
              description: service.$3,
            ),
          );
        }).toList(),
      ),
    );
  }

  // =========================================================
  // MISSION
  // =========================================================

  Widget _buildMissionCard() {
    return _sectionCard(
      icon: Icons.flag_outlined,
      title: 'Our Mission',
      child: const Text(
        'Our mission is to help businesses transform their '
        'ideas into memorable brands through creative design, '
        'modern technology and professional advertising '
        'solutions.\n\n'
        'We focus on creating work that is not only beautiful, '
        'but also meaningful and effective for your business.',
        style: TextStyle(
          color: Colors.white70,
          fontSize: 14,
          height: 1.7,
        ),
      ),
    );
  }

  // =========================================================
  // WHY CHOOSE US
  // =========================================================

  Widget _buildWhyUsCard() {
    return _sectionCard(
      icon: Icons.workspace_premium_outlined,
      title: 'Why Choose Alrman?',
      child: Column(
        children: [
          _feature(
            Icons.lightbulb_outline,
            'Creative',
            'Fresh ideas and unique solutions for every project.',
          ),
          _feature(
            Icons.verified_outlined,
            'Professional',
            'High-quality work with attention to detail.',
          ),
          _feature(
            Icons.handshake_outlined,
            'Reliable',
            'Clear communication and dependable service.',
          ),
          _feature(
            Icons.trending_up_rounded,
            'Business Focused',
            'Solutions designed around your brand and goals.',
          ),
        ],
      ),
    );
  }

  // =========================================================
  // CONTACT / CTA
  // =========================================================

  Widget _buildContactCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xff102B34),
            Color(0xff0D1B24),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: cyan.withOpacity(0.30),
        ),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.rocket_launch_outlined,
            color: cyan,
            size: 34,
          ),

          const SizedBox(height: 12),

          const Text(
            "Let's Create Something Great",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Have an idea, project or business that needs '
            'a creative touch? Let Alrman Advertising bring '
            'your vision to life.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white60,
              fontSize: 13.5,
              height: 1.6,
            ),
          ),

          const SizedBox(height: 18),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: 13,
              horizontal: 16,
            ),
            decoration: BoxDecoration(
              color: cyan.withOpacity(0.08),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: cyan.withOpacity(0.25),
              ),
            ),
            child: const Text(
              'Creative Design • Digital Marketing\n'
              'Branding • Printing Solutions',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: lightCyan,
                fontSize: 13,
                height: 1.6,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // COMMON SECTION CARD
  // =========================================================

  Widget _sectionCard({
    required IconData icon,
    required String title,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white.withOpacity(0.08),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: cyan.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: cyan,
                  size: 21,
                ),
              ),

              const SizedBox(width: 11),

              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          child,
        ],
      ),
    );
  }

  // =========================================================
  // SERVICE ITEM
  // =========================================================

  Widget _serviceItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: field,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: Colors.white.withOpacity(0.06),
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
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 11.5,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // FEATURE
  // =========================================================

  Widget _feature(
    IconData icon,
    String title,
    String description,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: cyan.withOpacity(0.10),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(
              icon,
              color: cyan,
              size: 19,
            ),
          ),

          const SizedBox(width: 11),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}