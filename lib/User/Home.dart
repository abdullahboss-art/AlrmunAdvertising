
import 'package:adverting_app/User/Estimated.dart';
import 'package:adverting_app/User/HomeData.dart';
import 'package:adverting_app/User/HomeWidgets.dart';
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
  bool showAllServices = false;

  // =========================================================
  // CAROUSEL
  // =========================================================

  final PageController _carouselController = PageController();

  int _currentSlide = 0;

  final List<Map<String, String>> _carouselItems = [
    {
      'title': 'Graphic & Web Design',
      'description':
          'Creative designs and modern websites that make your brand stand out.',
      'image': 'images/assets/gallery2.png',
    },
    {
      'title': 'Promotional Gifts',
      'description':
          'Branded gifts that help your business stay memorable.',
      'image': 'images/assets/gallery8.png',
    },
    {
      'title': 'Printing & Branding',
      'description':
          'Professional printing and branding solutions for your business.',
      'image': 'images/assets/gallery5.png',
    },
    {
      'title': 'Digital Marketing',
      'description':
          'Reach your audience with powerful digital marketing strategies.',
      'image': 'images/assets/gallery3.png',
    },
    {
      'title': 'Outdoor Advertising',
      'description':
          'Get noticed with impactful outdoor advertising and signage.',
      'image': 'images/assets/gallery4.png',
    },
  ];

  // =========================================================
  // INIT STATE
  // =========================================================

  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 4),
      _autoSlide,
    );
  }

  // =========================================================
  // AUTO SLIDE
  // =========================================================

  void _autoSlide() {
    if (!mounted) return;

    if (!_carouselController.hasClients) {
      Future.delayed(
        const Duration(seconds: 4),
        _autoSlide,
      );
      return;
    }

    int nextPage = _currentSlide + 1;

    if (nextPage >= _carouselItems.length) {
      nextPage = 0;
    }

    _carouselController.animateToPage(
      nextPage,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
    );

    Future.delayed(
      const Duration(seconds: 4),
      _autoSlide,
    );
  }

  // =========================================================
  // DISPOSE
  // =========================================================

  @override
  void dispose() {
    _carouselController.dispose();
    super.dispose();
  }

  // =========================================================
  // CAROUSEL WIDGET
  // =========================================================

  Widget _buildCarousel() {
    return Column(
      children: [
        SizedBox(
          height: 225,
          child: PageView.builder(
            controller: _carouselController,
            itemCount: _carouselItems.length,
            onPageChanged: (index) {
              setState(() {
                _currentSlide = index;
              });
            },
            itemBuilder: (context, index) {
              final item = _carouselItems[index];

              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [

                      // =================================================
                      // BLURRED / FILLED BACKGROUND
                      // =================================================

                      Image.asset(
                        item['image']!,
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                      ),

                      // Dark transparent layer
                      Container(
                        color: Colors.black.withOpacity(.35),
                      ),

                      // =================================================
                      // FULL IMAGE - NO CROP
                      // =================================================

                      Center(
                        child: Image.asset(
                          item['image']!,
                          fit: BoxFit.contain,
                          filterQuality: FilterQuality.high,
                        ),
                      ),

                      // =================================================
                      // DARK GRADIENT
                      // =================================================

                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(.20),
                                Colors.black.withOpacity(.92),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // =================================================
                      // CYAN GLOW
                      // =================================================

                      Positioned(
                        right: -50,
                        top: -50,
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(
                              0xFF36B6BD,
                            ).withOpacity(.14),
                          ),
                        ),
                      ),

                      // =================================================
                      // CONTENT
                      // =================================================

                      Positioned(
                        left: 20,
                        right: 65,
                        bottom: 18,
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [

                            // =================================================
                            // LABEL
                            // =================================================

                            Container(
                              padding:
                                  const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(
                                  0xFF36B6BD,
                                ).withOpacity(.18),
                                borderRadius:
                                    BorderRadius.circular(20),
                                border: Border.all(
                                  color: const Color(
                                    0xFF36B6BD,
                                  ).withOpacity(.40),
                                ),
                              ),
                              child: Text(
                                'ALRMAN ADVERTISING',
                                style: GoogleFonts.poppins(
                                  color: const Color(
                                    0xFF7DE8ED,
                                  ),
                                  fontSize: 8,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: .8,
                                ),
                              ),
                            ),

                            const SizedBox(height: 7),

                            // =================================================
                            // TITLE
                            // =================================================

                            Text(
                              item['title']!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 21,
                                fontWeight: FontWeight.w800,
                              ),
                            ),

                            const SizedBox(height: 3),

                            // =================================================
                            // DESCRIPTION
                            // =================================================

                            Text(
                              item['description']!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                color: Colors.white70,
                                fontSize: 10,
                                height: 1.35,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // =================================================
                      // ARROW BUTTON
                      // =================================================

                      Positioned(
                        right: 16,
                        bottom: 20,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFF36B6BD,
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: const Color(
                                  0xFF36B6BD,
                                ).withOpacity(.35),
                                blurRadius: 12,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.black,
                            size: 21,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 12),

        // =========================================================
        // INDICATOR DOTS
        // =========================================================

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _carouselItems.length,
            (index) {
              final bool isActive =
                  index == _currentSlide;

              return AnimatedContainer(
                duration:
                    const Duration(milliseconds: 300),
                margin:
                    const EdgeInsets.symmetric(
                  horizontal: 3,
                ),
                width: isActive ? 22 : 6,
                height: 6,
                decoration: BoxDecoration(
                  color: isActive
                      ? const Color(0xFF36B6BD)
                      : Colors.white24,
                  borderRadius:
                      BorderRadius.circular(10),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // =========================================================
  // PROFILE DIALOG
  // =========================================================

  void _showProfileDialog(User? user) {
    final bool isLoggedIn = user != null;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF07131B),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        title: Text(
          isLoggedIn
              ? "Profile"
              : "You're not signed in",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            // =================================================
            // PROFILE IMAGE
            // =================================================

            Center(
              child: CircleAvatar(
                radius: 35,
                backgroundColor:
                    Colors.grey.shade800,
                backgroundImage:
                    (isLoggedIn &&
                            user.photoURL != null &&
                            user.photoURL!.isNotEmpty)
                        ? NetworkImage(user.photoURL!)
                        : null,
                child:
                    (!isLoggedIn ||
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

              // =================================================
              // LOGOUT
              // =================================================

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding:
                        const EdgeInsets.symmetric(
                      vertical: 12,
                    ),
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    await FirebaseAuth.instance
                        .signOut();

                    if (!context.mounted) {
                      return;
                    }

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const LoginPage(),
                      ),
                      (route) => false,
                    );
                  },
                  child: Text(
                    "Logout",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight:
                          FontWeight.w600,
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

              // =================================================
              // LOGIN
              // =================================================

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    padding:
                        const EdgeInsets.symmetric(
                      vertical: 12,
                    ),
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const LoginPage(),
                      ),
                    );
                  },
                  child: Text(
                    "Login",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight:
                          FontWeight.w600,
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
  // ESTIMATE
  // =========================================================

  void _openEstimate() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const AdvertisingEstimatePage(),
      ),
    );
  }

  // =========================================================
  // SERVICE DETAIL
  // =========================================================

  void _openServiceDetail(
    Map<String, String> service,
  ) {
    final String serviceTitle =
        service['title'] ?? 'Service';

    debugPrint(
      "SERVICE CLICKED: $serviceTitle",
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ServiceDetail(
          service: service,
        ),
      ),
    );
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {

    // =========================================================
    // SERVICES DISPLAY LOGIC
    // =========================================================

    final List<Map<String, String>>
        displayedServices =
        showAllServices
            ? HomeData.services
            : HomeData.services.sublist(
                0,
                HomeData.services.length > 6
                    ? 6
                    : HomeData.services.length,
              );

    return Scaffold(
      backgroundColor:
          HomeWidgets.background,

      body: SafeArea(
        child: SingleChildScrollView(
          physics:
              const BouncingScrollPhysics(),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              // =================================================
              // TOP BAR
              // =================================================

              Padding(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [

                    // =================================================
                    // LOGO
                    // =================================================

                    Image.asset(
                      'images/assets/Alrmun_logo.png',
                      height: 64,
                      fit: BoxFit.contain,
                    ),

                    const Spacer(),

                    // =================================================
                    // PROFILE
                    // =================================================

                    StreamBuilder<User?>(
                      stream: FirebaseAuth.instance
                          .authStateChanges(),
                      builder:
                          (context, snapshot) {

                        final User? user =
                            snapshot.data;

                        final bool isLoggedIn =
                            user != null;

                        return GestureDetector(
                          onTap: () =>
                              _showProfileDialog(
                            user,
                          ),
                          child: Container(
                            decoration:
                                BoxDecoration(
                              shape:
                                  BoxShape.circle,
                              border:
                                  Border.all(
                                color: HomeWidgets
                                    .accent
                                    .withOpacity(.35),
                                width: 1,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor:
                                  Colors
                                      .grey
                                      .shade800,
                              backgroundImage:
                                  (isLoggedIn &&
                                          user.photoURL !=
                                              null &&
                                          user.photoURL!
                                              .isNotEmpty)
                                      ? NetworkImage(
                                          user.photoURL!,
                                        )
                                      : null,
                              child:
                                  (!isLoggedIn ||
                                          user.photoURL ==
                                              null ||
                                          user.photoURL!
                                              .isEmpty)
                                      ? const Icon(
                                          Icons.person,
                                          color:
                                              Colors.white,
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

              const SizedBox(height: 8),

              // =================================================
              // BRANDING
              // =================================================

              Padding(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [

                    Text(
                      "ALRMAN ADVERTISING",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight:
                            FontWeight.w800,
                        letterSpacing: .8,
                      ),
                    ),

                    const SizedBox(height: 2),

                    Text(
                      "Creative Ideas. Powerful Advertising.",
                      style: GoogleFonts.poppins(
                        color:
                            HomeWidgets.accent,
                        fontSize: 12,
                        fontWeight:
                            FontWeight.w500,
                        letterSpacing: .3,
                      ),
                    ),

                    const SizedBox(height: 18),

                    // =================================================
                    // ESTIMATE BUTTON
                    // =================================================

                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: Container(
                        decoration:
                            BoxDecoration(
                          gradient:
                              const LinearGradient(
                            colors: [
                              Color(0xFF16C8D8),
                              Color(0xFF0EA5B7),
                            ],
                          ),
                          borderRadius:
                              BorderRadius.circular(
                            15,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: HomeWidgets
                                  .accent
                                  .withOpacity(.20),
                              blurRadius: 14,
                              offset:
                                  const Offset(
                                0,
                                5,
                              ),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap:
                                _openEstimate,
                            borderRadius:
                                BorderRadius.circular(
                              15,
                            ),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .center,
                              children: [

                                const Icon(
                                  Icons
                                      .request_quote_rounded,
                                  color:
                                      Colors.black,
                                  size: 21,
                                ),

                                const SizedBox(
                                    width: 9),

                                Text(
                                  "Get Your Free Estimate",
                                  style:
                                      GoogleFonts
                                          .poppins(
                                    color:
                                        Colors.black,
                                    fontSize: 15,
                                    fontWeight:
                                        FontWeight
                                            .w700,
                                  ),
                                ),

                                const SizedBox(
                                    width: 8),

                                const Icon(
                                  Icons
                                      .arrow_forward_rounded,
                                  color:
                                      Colors.black,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // =================================================
              // CAROUSEL
              // =================================================

              const SizedBox(height: 24),

              _buildCarousel(),

              const SizedBox(height: 12),

              // =================================================
              // SERVICES HEADER
              // =================================================

              HomeWidgets.sectionHeader(
                title: "Services",
                subtitle:
                    "Everything your brand needs",
                buttonText:
                    showAllServices
                        ? "Show Less"
                        : "See All",
                showLess:
                    showAllServices,
                onButtonTap: () {
                  setState(() {
                    showAllServices =
                        !showAllServices;
                  });
                },
              ),

              const SizedBox(height: 14),

              // =================================================
              // SERVICES GRID
              // =================================================

              HomeWidgets.servicesGrid(
                services:
                    displayedServices,
                onTap:
                    _openServiceDetail,
              ),

              const SizedBox(height: 35),
            ],
          ),
        ),
      ),
    );
  }
}

