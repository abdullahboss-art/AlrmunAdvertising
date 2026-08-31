
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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ServiceDetail(
          service: service, serviceName: '',
        ),
      ),
    );
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

              _buildServicesCard(context),

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

  Widget _buildServicesCard(BuildContext context) {
    return _sectionCard(
      icon: Icons.design_services_outlined,
      title: 'What We Do',
      child: Column(
        children: services.map((service) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _serviceItem(
              context: context,
              icon: _getServiceIcon(service['title']!),
              title: service['title']!,
              description: service['description']!,
              service: service,
            ),
          );
        }).toList(),
      ),
    );
  }

  // =========================================================
  // SERVICE ICONS
  // =========================================================

  IconData _getServiceIcon(String title) {
    switch (title) {
      case 'Graphic Design':
        return Icons.palette_outlined;

      case 'Animation & Media':
        return Icons.movie_creation_outlined;

      case '3D Visualization':
        return Icons.view_in_ar_outlined;

      case 'Digital & Offset':
        return Icons.print_outlined;

      case 'Outdoor Advertising':
        return Icons.campaign_outlined;

      case 'Flex Printing':
        return Icons.local_print_shop_outlined;

      case 'Vinyl Printing':
        return Icons.layers_outlined;

      case 'Sign Boards':
        return Icons.signpost_outlined;

      case '3D Letters':
        return Icons.text_fields_rounded;

      case 'Business Cards':
        return Icons.badge_outlined;

      case 'Flyers':
        return Icons.description_outlined;

      case 'Sticker Printing':
        return Icons.sticky_note_2_outlined;

      default:
        return Icons.design_services_outlined;
    }
  }

  // =========================================================
  // MISSION
  // =========================================================

  // Widget _buildMissionCard() {
  //   return _sectionCard(
  //     icon: Icons.flag_outlined,
  //     title: 'Our Mission',
  //     child: const Text(
  //       'Our mission is to help businesses transform their '
  //       'ideas into memorable brands through creative design, '
  //       'modern technology and professional advertising '
  //       'solutions.\n\n'
  //       'We focus on creating work that is not only beautiful, '
  //       'but also meaningful and effective for your business.',
  //       style: TextStyle(
  //         color: Colors.white70,
  //         fontSize: 14,
  //         height: 1.7,
  //       ),
  //     ),
  //   );
  // }

  // =========================================================
  // WHY CHOOSE ALRMAN
  // =========================================================

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

  // =========================================================
  // CONTACT / CTA
  // =========================================================

  // Widget _buildContactCard() {
  //   return Container(
  //     width: double.infinity,
  //     padding: const EdgeInsets.all(20),
  //     decoration: BoxDecoration(
  //       gradient: const LinearGradient(
  //         begin: Alignment.topLeft,
  //         end: Alignment.bottomRight,
  //         colors: [
  //           Color(0xff102B34),
  //           Color(0xff0D1B24),
  //         ],
  //       ),
  //       borderRadius: BorderRadius.circular(20),
  //       border: Border.all(
  //         color: cyan.withOpacity(0.30),
  //       ),
  //     ),
  //     child: Column(
  //       children: [
  //         const Icon(
  //           Icons.rocket_launch_outlined,
  //           color: cyan,
  //           size: 34,
  //         ),

  //         const SizedBox(height: 12),

  //         const Text(
  //           "Let's Create Something Great",
  //           textAlign: TextAlign.center,
  //           style: TextStyle(
  //             color: Colors.white,
  //             fontSize: 19,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),

  //         const SizedBox(height: 8),

  //         const Text(
  //           'Have an idea, project or business that needs '
  //           'a creative touch? Let Alrman Advertising bring '
  //           'your vision to life.',
  //           textAlign: TextAlign.center,
  //           style: TextStyle(
  //             color: Colors.white60,
  //             fontSize: 13.5,
  //             height: 1.6,
  //           ),
  //         ),

  //         const SizedBox(height: 18),

  //         Container(
  //           width: double.infinity,
  //           padding: const EdgeInsets.symmetric(
  //             vertical: 13,
  //             horizontal: 16,
  //           ),
  //           decoration: BoxDecoration(
  //             color: cyan.withOpacity(0.08),
  //             borderRadius: BorderRadius.circular(14),
  //             border: Border.all(
  //               color: cyan.withOpacity(0.25),
  //             ),
  //           ),
  //           child: const Text(
  //             'Creative Design • Digital Marketing\n'
  //             'Branding • Printing Solutions',
  //             textAlign: TextAlign.center,
  //             style: TextStyle(
  //               color: lightCyan,
  //               fontSize: 13,
  //               height: 1.6,
  //               fontWeight: FontWeight.w500,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

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
  // CLICKABLE SERVICE ITEM
  // =========================================================

  Widget _serviceItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
    required Map<String, String> service,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(13),

        // ===================================================
        // OPEN CORRECT SERVICE DETAIL
        // ===================================================

        onTap: () {
          _openServiceDetail(context, service);
        },

        child: Container(
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
              // =================================================
              // ICON
              // =================================================

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

              // =================================================
              // TITLE + DESCRIPTION
              // =================================================

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 11.5,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // =================================================
              // ARROW
              // =================================================

              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white38,
                size: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

