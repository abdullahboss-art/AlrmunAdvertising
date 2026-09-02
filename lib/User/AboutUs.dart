
import 'package:flutter/material.dart';
import 'package:adverting_app/User/ServiceDetail.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  // =========================================================
  // COLORS
  // =========================================================

  static const Color background = Color(0xff07131B);
  static const Color card = Color(0xff0D1B24);
  static const Color field = Color(0xff08151D);
  static const Color cyan = Color(0xff16C8D8);
  static const Color lightCyan = Color(0xff9FEFF5);

  // =========================================================
  // ALL SERVICES
  // =========================================================

  static final List<Map<String, String>> services = [
    {
      'title': 'Graphic Design',
      'description':
          'Creative visuals and professional graphic designs for your brand.',
      'image': 'images/assets/Graphic_Deisgn.png',
      'subtitle': '& Animation',
    },
    {
      'title': 'Animation & Media',
      'description':
          'Engaging animation, video editing and professional media production.',
      'image': 'images/assets/Animation & Media_Prodcution.png',
      'subtitle': 'Production',
    },
    {
      'title': '3D Visualization',
      'description':
          'High-quality 3D visualization, modeling and realistic rendering.',
      'image': 'images/assets/3d Visualization.png',
      'subtitle': '& Rendering',
    },
    {
      'title': 'Digital & Offset',
      'description':
          'Professional digital and offset printing for all business needs.',
      'image': 'images/assets/Digital&offset.png',
      'subtitle': 'Printing',
    },
    {
      'title': 'Outdoor Advertising',
      'description':
          'Powerful outdoor advertising through billboards, banners and displays.',
      'image': 'images/assets/Outdoor Advertising.png',
      'subtitle': 'Billboards & Banners',
    },
    {
      'title': 'Flex Printing',
      'description':
          'High-quality flex printing for banners, signs and promotional displays.',
      'image': 'images/assets/Flex Printing.png',
      'subtitle': 'Quality Printing',
    },
    {
      'title': 'Vinyl Printing',
      'description':
          'Premium vinyl graphics for windows, walls, vehicles and branding.',
      'image': 'images/assets/Vinyl Printing.png',
      'subtitle': 'Premium Graphics',
    },
    {
      'title': 'Sign Boards',
      'description':
          'Professional indoor and outdoor sign boards designed for visibility.',
      'image': 'images/assets/Sign Boards.png',
      'subtitle': 'Indoor & Outdoor',
    },
    {
      'title': '3D Letters',
      'description':
          'Premium 3D letters and dimensional branding for businesses.',
      'image': 'images/assets/3D Letters.png',
      'subtitle': '3D Branding',
    },
    {
      'title': 'Business Cards',
      'description':
          'Professional business cards that create a strong first impression.',
      'image': 'images/assets/Business Cards.png',
      'subtitle': 'Professional Printing',
    },
    {
      'title': 'Flyers',
      'description':
          'Creative promotional flyers designed to attract customers.',
      'image': 'images/assets/Flyers.png',
      'subtitle': 'Promotional Printing',
    },
    {
      'title': 'Sticker Printing',
      'description':
          'Custom stickers for branding, packaging, promotion and decoration.',
      'image': 'images/assets/Sticker Printing.png',
      'subtitle': 'Custom Stickers',
    },
  ];

  // =========================================================
  // OPEN SERVICE DETAIL
  // =========================================================

  void _openServiceDetail(
    BuildContext context,
    Map<String, String> service,
  ) {
  void _openServiceDetail(Map<String, String> service) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => ServiceDetail(
        service: service,
      ),
    ),
  );
}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,

      // =====================================================
      // APP BAR
      // =====================================================

      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: Row(
          children: [
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

      // =====================================================
      // BODY
      // =====================================================

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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

              // _buildServicesCard(context),

              const SizedBox(height: 18),

              // _buildMissionCard(),

              const SizedBox(height: 18),

              _buildWhyUsCard(),

              const SizedBox(height: 18),

              // _buildContactCard(),

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
          // LOGO
          Container(
            width: 90,
            height: 90,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.20),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.blue[400]!,
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

  

  Widget _buildWhyUsCard() {
    return _sectionCard(
      icon: Icons.workspace_premium_outlined,
      title: 'Why Choose Alrman?',
      child: Column(
        children: [
          _whyChooseItem(
            icon: Icons.lightbulb_outline_rounded,
            title: 'Creative Ideas',
            description:
                'Fresh, unique and creative concepts designed to make your brand stand out.',
          ),

          const SizedBox(height: 12),

          _whyChooseItem(
            icon: Icons.verified_outlined,
            title: 'Professional Quality',
            description:
                'High-quality designs and advertising solutions with attention to every detail.',
          ),

          const SizedBox(height: 12),

          _whyChooseItem(
            icon: Icons.access_time_rounded,
            title: 'On-Time Delivery',
            description:
                'We value your time and work to deliver projects within the agreed timeline.',
          ),

          const SizedBox(height: 12),

          _whyChooseItem(
            icon: Icons.handshake_outlined,
            title: 'Reliable Support',
            description:
                'Clear communication, dependable service and support throughout your project.',
          ),

          const SizedBox(height: 12),

          _whyChooseItem(
            icon: Icons.trending_up_rounded,
            title: 'Business Focused',
            description:
                'Our solutions are created to strengthen your brand and support business growth.',
          ),
        ],
      ),
    );
  }

  // =========================================================
  // WHY CHOOSE ITEM
  // =========================================================

  Widget _whyChooseItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: field,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: cyan.withOpacity(0.10),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: cyan.withOpacity(0.10),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: cyan.withOpacity(0.15),
              ),
            ),
            child: Icon(
              icon,
              color: cyan,
              size: 23,
            ),
          ),

          const SizedBox(width: 13),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

 

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
}

