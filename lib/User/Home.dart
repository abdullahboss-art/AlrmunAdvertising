
import 'package:adverting_app/User/Estimated.dart';
import 'package:adverting_app/User/ServiceDetail.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:adverting_app/User/Login.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // =========================================================
  // SERVICES
  // =========================================================

  final List<Map<String, String>> services = [
    {
      'title': 'Graphic Design',
      'image': 'images/assets/Graphic_Deisgn.png',
      'subtitle': '& Animation',
    },
    {
      'title': 'Animation & Media',
      'image': 'images/assets/Animation & Media_Prodcution.png',
      'subtitle': 'Production',
    },
    {
      'title': '3D Visualization',
      'image': 'images/assets/3d Visualization.png',
      'subtitle': '& Rendering',
    },
    {
      'title': 'Digital & Offset',
      'image': 'images/assets/Digital&offset.png',
      'subtitle': 'Printing',
    },
    {
      'title': 'Outdoor Advertising',
      'image': 'images/assets/Outdoor Advertising.png',
      'subtitle': 'Billboards & Banners',
    },
    {
      'title': 'Flex Printing',
      'image': 'images/assets/Flex Printing.png',
      'subtitle': 'Quality Printing',
    },
    {
      'title': 'Vinyl Printing',
      'image': 'images/assets/Vinyl Printing.png',
      'subtitle': 'Premium Graphics',
    },
    {
      'title': 'Sign Boards',
      'image': 'images/assets/Sign Boards.png',
      'subtitle': 'Indoor & Outdoor',
    },
    {
      'title': '3D Letters',
      'image': 'images/assets/3D Letters.png',
      'subtitle': '3D Branding',
    },
    {
      'title': 'Business Cards',
      'image': 'images/assets/Business Cards.png',
      'subtitle': 'Professional Printing',
    },
    {
      'title': 'Branding',
      'image': 'images/assets/Branding.jpg',
      'subtitle': 'Complete Brand Identity',
    },
    {
  'title': 'Events & Exhibition',
  'image': 'images/assets/Events & Exhibition.webp',
  'subtitle': 'Stand Design',
},
   
  ];



  bool showAllServices = false;


  void _showProfileDialog(User? user) {
    final bool isLoggedIn = user != null;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Color(0xFF07131B),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        title: Text(
          isLoggedIn ? "Profile" : "You're not signed in",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // PROFILE IMAGE
            Center(
              child: CircleAvatar(
                radius: 35,
                backgroundColor: Colors.grey.shade800,
                backgroundImage: (isLoggedIn &&
                        user.photoURL != null &&
                        user.photoURL!.isNotEmpty)
                    ? NetworkImage(user.photoURL!)
                    : null,
                child: (!isLoggedIn ||
                        user.photoURL == null ||
                        user.photoURL!.isEmpty)
                    ? const Icon(
                        Icons.person,
                        size: 35,
                        color: Colors.white,
                      )
                    : null,
              ),
            ),

            const SizedBox(height: 20),

            // =================================================
            // LOGGED IN
            // =================================================

            if (isLoggedIn) ...[
              Text(
                "Name",
                style: GoogleFonts.poppins(
                  color: Colors.white54,
                  fontSize: 11,
                ),
              ),

              const SizedBox(height: 3),

              Text(
                user.displayName ?? "No Name",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                "Email",
                style: GoogleFonts.poppins(
                  color: Colors.white54,
                  fontSize: 11,
                ),
              ),

              const SizedBox(height: 3),

              Text(
                user.email ?? "Not Available",
                style: GoogleFonts.poppins(
                  color: Colors.white70,
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 20),

              // LOGOUT
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();

                    if (!context.mounted) return;

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LoginPage(),
                      ),
                      (route) => false,
                    );
                  },
                  child: Text(
                    "Logout",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ]

            // =================================================
            // NOT LOGGED IN
            // =================================================

            else ...[
              Text(
                "Login to see your profile, orders and more.",
                style: GoogleFonts.poppins(
                  color: Colors.white70,
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 20),

              // LOGIN
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LoginPage(),
                      ),
                    );
                  },
                  child: Text(
                    "Login",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // =========================================================
  // ESTIMATE PAGE
  // =========================================================

  void _openEstimate() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AdvertisingEstimatePage(),
      ),
    );
  }

  // =========================================================
  // SERVICE DETAIL PAGE
  // =========================================================

  void _openServiceDetail(Map<String, String> service) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ServiceDetail(
          service: service, serviceName: service['title'] ?? '',
        ),
      ),
    );
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // =================================================
              // TOP BAR
              // =================================================

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [

                    // LOGO
                    Image.asset(
                      'images/assets/Alrmun_logo.png',
                      height: 64,
                      fit: BoxFit.contain,
                    ),

                    const Spacer(),

                    // PROFILE
                    StreamBuilder<User?>(
                      stream: FirebaseAuth.instance.authStateChanges(),
                      builder: (context, snapshot) {
                        final User? user = snapshot.data;
                        final bool isLoggedIn = user != null;

                        return GestureDetector(
                          onTap: () => _showProfileDialog(user),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFF16C8D8)
                                    .withOpacity(0.35),
                                width: 1,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor:
                                  Colors.grey.shade800,
                              backgroundImage:
                                  (isLoggedIn &&
                                          user.photoURL != null &&
                                          user.photoURL!.isNotEmpty)
                                      ? NetworkImage(
                                          user.photoURL!,
                                        )
                                      : null,
                              child: (!isLoggedIn ||
                                      user.photoURL == null ||
                                      user.photoURL!.isEmpty)
                                  ? const Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    )
                                  : null,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 4),

              // =================================================
              // BRAND BANNER
              // =================================================

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 15,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17),
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xFF10252B),
                        Color(0xFF111111),
                      ],
                    ),
                    border: Border.all(
                      color: const Color(0xFF16C8D8)
                          .withOpacity(0.20),
                    ),
                  ),
                  child: Row(
                    children: [

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [

                            Text(
                              "Bring Your Ideas To Life",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                              ),
                            ),

                            const SizedBox(height: 4),

                            Text(
                              "Creative advertising solutions for your brand.",
                              style: GoogleFonts.poppins(
                                color: Colors.white54,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF16C8D8)
                              .withOpacity(0.10),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.auto_awesome,
                          color: Color(0xFF16C8D8),
                          size: 22,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // =================================================
              // SERVICES HEADER
              // =================================================

              Padding(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  25,
                  16,
                  0,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [

                          Text(
                            "Our Services",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 2),

                          Text(
                            "Everything your brand needs",
                            style: GoogleFonts.poppins(
                              color: Colors.white54,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // =================================================
                    // SEE ALL / SHOW LESS
                    // =================================================

                    InkWell(
                      onTap: () {
                        setState(() {
                          showAllServices = !showAllServices;
                        });
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          children: [

                            Text(
                              showAllServices
                                  ? "Show Less"
                                  : "See All",
                              style: GoogleFonts.poppins(
                                color: const Color(0xFF16C8D8),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            const SizedBox(width: 4),

                            Icon(
                              showAllServices
                                  ? Icons.keyboard_arrow_up_rounded
                                  : Icons.arrow_forward_ios_rounded,
                              color: const Color(0xFF16C8D8),
                              size: 14,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // =================================================
              // SERVICES GRID
              // =================================================

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(),

                  itemCount: showAllServices
                      ? services.length
                      : (services.length > 4
                          ? 4
                          : services.length),

                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.85,
                  ),

                  itemBuilder: (context, index) {
                    final service = services[index];

                    // =================================================
                    // SERVICE CARD
                    // =================================================

                    return InkWell(
                      borderRadius: BorderRadius.circular(16),

                      // IMPORTANT:
                      // Complete service map pass hoga
                      onTap: () {
                        _openServiceDetail(service);
                      },

                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A1A1A),
                          borderRadius:
                              BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white
                                .withOpacity(0.10),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black
                                  .withOpacity(0.25),
                              blurRadius: 8,
                              offset:
                                  const Offset(0, 4),
                            ),
                          ],
                        ),

                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [

                            // =================================================
                            // IMAGE
                            // =================================================

                            Expanded(
                              child: Stack(
                                children: [

                                  ClipRRect(
                                    borderRadius:
                                        const BorderRadius.only(
                                      topLeft:
                                          Radius.circular(16),
                                      topRight:
                                          Radius.circular(16),
                                    ),

                                    child: Image.asset(
                                      service['image']!,
                                      width:
                                          double.infinity,
                                      height:
                                          double.infinity,
                                      fit: BoxFit.cover,

                                      // Optional error handling
                                      errorBuilder:
                                          (context, error,
                                              stackTrace) {
                                        return Container(
                                          color:
                                              const Color(
                                                  0xFF151515),
                                          child: const Center(
                                            child: Icon(
                                              Icons
                                                  .image_not_supported_outlined,
                                              color:
                                                  Colors.white38,
                                              size: 35,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),

                                  // =================================================
                                  // SMALL ARROW ICON
                                  // =================================================

                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Container(
                                      padding:
                                          const EdgeInsets.all(
                                              6),
                                      decoration:
                                          BoxDecoration(
                                        color: Colors.black
                                            .withOpacity(0.55),
                                        shape:
                                            BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons
                                            .arrow_outward_rounded,
                                        color:
                                            Color(0xFF16C8D8),
                                        size: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // =================================================
                            // TITLE + SUBTITLE
                            // =================================================

                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(
                                10,
                                9,
                                8,
                                9,
                              ),
                              child: Row(
                                children: [

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                      children: [

                                        Text(
                                          service['title']!,
                                          maxLines: 1,
                                          overflow:
                                              TextOverflow
                                                  .ellipsis,
                                          style:
                                              GoogleFonts
                                                  .poppins(
                                            color:
                                                Colors.white,
                                            fontSize: 12.5,
                                            fontWeight:
                                                FontWeight
                                                    .w600,
                                          ),
                                        ),

                                        const SizedBox(
                                            height: 2),

                                        Text(
                                          service['subtitle']!,
                                          maxLines: 1,
                                          overflow:
                                              TextOverflow
                                                  .ellipsis,
                                          style:
                                              GoogleFonts
                                                  .poppins(
                                            color:
                                                Colors.white54,
                                            fontSize: 9,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const Icon(
                                    Icons
                                        .arrow_forward_rounded,
                                    color:
                                        Color(0xFF16C8D8),
                                    size: 17,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // =================================================
              // SPACE
              // =================================================

              const SizedBox(height: 28),

              // =================================================
              // GET ESTIMATE BUTTON
              // =================================================

              const SizedBox(height: 18),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: StatefulBuilder(
                  builder: (context, setButtonState) {
                    bool isHovered = false;

                    return MouseRegion(
                      cursor: SystemMouseCursors.click,

                      onEnter: (_) {
                        setButtonState(() {
                          isHovered = true;
                        });
                      },

                      onExit: (_) {
                        setButtonState(() {
                          isHovered = false;
                        });
                      },

                      child: AnimatedContainer(
                        duration:
                            const Duration(milliseconds: 250),
                        curve: Curves.easeInOut,

                        width: double.infinity,
                        height: 60,

                        decoration: BoxDecoration(
                          color: isHovered
                              ? const Color(0xFF16C8D8)
                              : Colors.black,
                          borderRadius:
                              BorderRadius.circular(16),
                          border: Border.all(
                            color:
                                const Color(0xFF16C8D8),
                            width: 1.2,
                          ),
                          boxShadow: isHovered
                              ? [
                                  BoxShadow(
                                    color:
                                        const Color(
                                      0xFF16C8D8,
                                    ).withOpacity(0.30),
                                    blurRadius: 18,
                                    spreadRadius: 1,
                                    offset:
                                        const Offset(0, 5),
                                  ),
                                ]
                              : [],
                        ),

                        child: Material(
                          color: Colors.transparent,

                          child: InkWell(
                            onTap: _openEstimate,
                            borderRadius:
                                BorderRadius.circular(16),

                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.center,
                              children: [

                                Icon(
                                  Icons
                                      .request_quote_rounded,
                                  size: 21,
                                  color: isHovered
                                      ? Colors.black
                                      : Colors.white,
                                ),

                                const SizedBox(width: 9),

                                Text(
                                  "Get Your Free Estimate",
                                  style:
                                      GoogleFonts.poppins(
                                    color: isHovered
                                        ? Colors.black
                                        : Colors.white,
                                    fontSize: 15,
                                    fontWeight:
                                        FontWeight.w700,
                                  ),
                                ),

                                const SizedBox(width: 9),

                                Icon(
                                  Icons
                                      .arrow_forward_rounded,
                                  size: 20,
                                  color: isHovered
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // =================================================
              // BOTTOM SPACE
              // =================================================

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

