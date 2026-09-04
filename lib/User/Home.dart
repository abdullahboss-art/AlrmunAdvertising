import 'dart:async';

import 'package:adverting_app/User/Estimated.dart';
import 'package:adverting_app/User/HomeData.dart';
import 'package:adverting_app/User/HomeWidgets.dart';
import 'package:adverting_app/User/ServiceDetail.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:adverting_app/User/Login.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  bool showAllServices = false;

  // =========================================================
  // WHATSAPP FLOATING ANIMATION
  // =========================================================

  late AnimationController _whatsappAnimationController;
  late Animation<double> _whatsappAnimation;

  // =========================================================
  // CAROUSEL
  // =========================================================

  final PageController _carouselController =
      PageController();

  int _currentSlide = 0;

  Timer? _carouselTimer;

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

    _carouselTimer = Timer.periodic(
      const Duration(seconds: 4),
      (_) {
        _autoSlide();
      },
    );

    // =========================================================
    // WHATSAPP FLOATING ANIMATION
    // =========================================================

    _whatsappAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _whatsappAnimation = Tween<double>(
      begin: -6,
      end: 6,
    ).animate(
      CurvedAnimation(
        parent: _whatsappAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _whatsappAnimationController.repeat(reverse: true);
  }

  // =========================================================
  // AUTO SLIDE
  // =========================================================

  void _autoSlide() {
    if (!mounted) return;

    if (!_carouselController.hasClients) {
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
  }

  // =========================================================
  // NEXT SLIDE
  // =========================================================

  void _nextSlide() {
    if (!_carouselController.hasClients) {
      return;
    }

    int nextPage = _currentSlide + 1;

    if (nextPage >= _carouselItems.length) {
      nextPage = 0;
    }

    _carouselController.animateToPage(
      nextPage,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  // =========================================================
  // DISPOSE
  // =========================================================

  @override
  void dispose() {
    _carouselTimer?.cancel();
    _carouselController.dispose();
    _whatsappAnimationController.dispose();
    super.dispose();
  }

  // =========================================================
  // CAROUSEL
  // =========================================================

  Widget _buildCarousel() {
    return Column(
      children: [
        SizedBox(
          height: 225,

          child: Stack(
            children: [

              // =================================================
              // PAGE VIEW
              // =================================================

              PageView.builder(
                controller: _carouselController,

                itemCount:
                    _carouselItems.length,

                onPageChanged: (index) {
                  if (!mounted) return;

                  setState(() {
                    _currentSlide = index;
                  });
                },

                itemBuilder: (context, index) {
                  final item =
                      _carouselItems[index];

                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),

                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(22),

                      child: Stack(
                        fit: StackFit.expand,

                        children: [

                          // =============================================
                          // BACKGROUND IMAGE
                          // =============================================

                          Image.asset(
                            item['image']!,
                            fit: BoxFit.cover,
                            filterQuality:
                                FilterQuality.high,
                          ),

                          // =============================================
                          // DARK OVERLAY
                          // =============================================

                          Container(
                            color:
                                Colors.black
                                    .withOpacity(.35),
                          ),

                          // =============================================
                          // FULL IMAGE
                          // =============================================

                          Center(
                            child: Image.asset(
                              item['image']!,
                              fit: BoxFit.contain,
                              filterQuality:
                                  FilterQuality.high,
                            ),
                          ),

                          // =============================================
                          // DARK GRADIENT
                          // =============================================

                          Positioned.fill(
                            child: Container(
                              decoration:
                                  BoxDecoration(
                                gradient:
                                    LinearGradient(
                                  begin:
                                      Alignment
                                          .topCenter,
                                  end:
                                      Alignment
                                          .bottomCenter,
                                  colors: [
                                    Colors
                                        .transparent,
                                    Colors.black
                                        .withOpacity(
                                      .20,
                                    ),
                                    Colors.black
                                        .withOpacity(
                                      .92,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          // =============================================
                          // CYAN GLOW
                          // =============================================

                          Positioned(
                            right: -50,
                            top: -50,

                            child: Container(
                              width: 150,
                              height: 150,

                              decoration:
                                  BoxDecoration(
                                shape:
                                    BoxShape.circle,
                                color:
                                    const Color(
                                  0xFF36B6BD,
                                ).withOpacity(.14),
                              ),
                            ),
                          ),

                          // =============================================
                          // CONTENT
                          // =============================================

                          Positioned(
                            left: 20,
                            right: 65,
                            bottom: 18,

                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,

                              children: [

                                // LABEL
                                Container(
                                  padding:
                                      const EdgeInsets
                                          .symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),

                                  decoration:
                                      BoxDecoration(
                                    color:
                                        const Color(
                                      0xFF36B6BD,
                                    ).withOpacity(.18),

                                    borderRadius:
                                        BorderRadius
                                            .circular(
                                      20,
                                    ),

                                    border:
                                        Border.all(
                                      color:
                                          const Color(
                                        0xFF36B6BD,
                                      ).withOpacity(.40),
                                    ),
                                  ),

                                  child: Text(
                                    'ALRMAN ADVERTISING',

                                    style:
                                        GoogleFonts
                                            .poppins(
                                      color:
                                          const Color(
                                        0xFF7DE8ED,
                                      ),
                                      fontSize: 8,
                                      fontWeight:
                                          FontWeight.w700,
                                      letterSpacing:
                                          .8,
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                  height: 7,
                                ),

                                // TITLE
                                Text(
                                  item['title']!,

                                  maxLines: 1,

                                  overflow:
                                      TextOverflow
                                          .ellipsis,

                                  style:
                                      GoogleFonts
                                          .poppins(
                                    color:
                                        Colors.white,
                                    fontSize: 21,
                                    fontWeight:
                                        FontWeight.w800,
                                  ),
                                ),

                                const SizedBox(
                                  height: 3,
                                ),

                                // DESCRIPTION
                                Text(
                                  item['description']!,

                                  maxLines: 2,

                                  overflow:
                                      TextOverflow
                                          .ellipsis,

                                  style:
                                      GoogleFonts
                                          .poppins(
                                    color:
                                        Colors.white70,
                                    fontSize: 10,
                                    height: 1.35,
                                  ),
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

              // =================================================
              // CLICKABLE CAROUSEL ARROW
              // =================================================

              Positioned(
                right: 22,
                bottom: 18,

                child: Material(
                  color: Colors.transparent,

                  child: InkWell(
                    onTap: _nextSlide,

                    borderRadius:
                        BorderRadius.circular(30),

                    child: Container(
                      width: 52,
                      height: 52,

                      decoration:
                          BoxDecoration(
                        color:
                            const Color(
                          0xFF36B6BD,
                        ),

                        shape:
                            BoxShape.circle,

                        border:
                            Border.all(
                          color:
                              Colors.white
                                  .withOpacity(.30),
                          width: 1,
                        ),

                        boxShadow: [
                          BoxShadow(
                            color:
                                const Color(
                              0xFF36B6BD,
                            ).withOpacity(.50),

                            blurRadius: 18,

                            spreadRadius: 2,
                          ),
                        ],
                      ),

                      child: const Icon(
                        Icons
                            .arrow_forward_rounded,

                        color:
                            Colors.black,

                        size: 26,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // =================================================
        // INDICATOR DOTS
        // =================================================

        Row(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: List.generate(
            _carouselItems.length,

            (index) {
              final bool isActive =
                  index == _currentSlide;

              return AnimatedContainer(
                duration:
                    const Duration(
                  milliseconds: 300,
                ),

                margin:
                    const EdgeInsets.symmetric(
                  horizontal: 3,
                ),

                width:
                    isActive ? 22 : 6,

                height: 6,

                decoration:
                    BoxDecoration(
                  color: isActive
                      ? const Color(
                          0xFF36B6BD,
                        )
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
        backgroundColor:
            const Color(0xFF07131B),

        shape:
            RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(18),
        ),

        title: Text(
          isLoggedIn
              ? "Profile"
              : "You're not signed in",

          style:
              GoogleFonts.poppins(
            color:
                Colors.white,
            fontWeight:
                FontWeight.w600,
          ),
        ),

        content: Column(
          mainAxisSize:
              MainAxisSize.min,

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            // =============================================
            // PROFILE IMAGE
            // =============================================

            Center(
              child: CircleAvatar(
                radius: 35,

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

            const SizedBox(
              height: 20,
            ),

            // =============================================
            // LOGGED IN
            // =============================================

            if (isLoggedIn) ...[
              Text(
                "Name",

                style:
                    GoogleFonts.poppins(
                  color:
                      Colors.white54,
                  fontSize: 11,
                ),
              ),

              const SizedBox(
                height: 3,
              ),

              Text(
                user.displayName ??
                    "No Name",

                style:
                    GoogleFonts.poppins(
                  color:
                      Colors.white,
                  fontSize: 14,
                  fontWeight:
                      FontWeight.w500,
                ),
              ),

              const SizedBox(
                height: 12,
              ),

              Text(
                "Email",

                style:
                    GoogleFonts.poppins(
                  color:
                      Colors.white54,
                  fontSize: 11,
                ),
              ),

              const SizedBox(
                height: 3,
              ),

              Text(
                user.email ??
                    "Not Available",

                style:
                    GoogleFonts.poppins(
                  color:
                      Colors.white70,
                  fontSize: 13,
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              // =============================================
              // LOGOUT
              // =============================================

              SizedBox(
                width:
                    double.infinity,

                child:
                    ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.red,

                    padding:
                        const EdgeInsets.symmetric(
                      vertical: 12,
                    ),

                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                        12,
                      ),
                    ),
                  ),

                  onPressed: () async {
                    await FirebaseAuth
                        .instance
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

                  child:
                      Text(
                    "Logout",

                    style:
                        GoogleFonts.poppins(
                      color:
                          Colors.white,

                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ]

            // =============================================
            // NOT LOGGED IN
            // =============================================

            else ...[
              Text(
                "Login to see your profile, orders and more.",

                style:
                    GoogleFonts.poppins(
                  color:
                      Colors.white70,
                  fontSize: 13,
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              // =============================================
              // LOGIN
              // =============================================

              SizedBox(
                width:
                    double.infinity,

                child:
                    ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.amber,

                    padding:
                        const EdgeInsets.symmetric(
                      vertical: 12,
                    ),

                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                        12,
                      ),
                    ),
                  ),

                  onPressed: () {
                    Navigator.pop(
                      context,
                    );

                    Navigator.push(
                      context,

                      MaterialPageRoute(
                        builder: (_) =>
                            const LoginPage(),
                      ),
                    );
                  },

                  child:
                      Text(
                    "Login",

                    style:
                        GoogleFonts.poppins(
                      color:
                          Colors.black,

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
  // WHATSAPP
  // =========================================================

  Future<void> _openWhatsApp() async {
    // Replace this with your WhatsApp number.
    // Country code ke sath, + sign aur spaces ke baghair.
    const String phoneNumber = '971527898516';

    const String message =
        'Hello Alrman Advertising, I would like to know more about your services.';

    final Uri whatsappUrl = Uri.parse(
      'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}',
    );

    try {
      if (await canLaunchUrl(whatsappUrl)) {
        await launchUrl(
          whatsappUrl,
          mode: LaunchMode.externalApplication,
        );
      }
    } catch (e) {
      debugPrint('WhatsApp Error: $e');
    }
  }

  // =========================================================
  // FLOATING WHATSAPP ICON
  // =========================================================

  Widget _buildWhatsAppFloatingButton() {
    return AnimatedBuilder(
      animation: _whatsappAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _whatsappAnimation.value),
          child: child,
        );
      },
      child: GestureDetector(
        onTap: _openWhatsApp,
        child: Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF25D366),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF25D366).withOpacity(0.45),
                blurRadius: 18,
                spreadRadius: 2,
              ),
            ],
            border: Border.all(
              color: Colors.white.withOpacity(0.20),
              width: 1,
            ),
          ),
          child: const Center(
            child: FaIcon(
              FontAwesomeIcons.whatsapp,
              color: Colors.white,
              size: 31,
            ),
          ),
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
        builder: (_) =>
            ServiceDetail(
          service: service,
        ),
      ),
    );
  }

  // =========================================================
  // BOTTOM NAVIGATION
  // =========================================================

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration:
          BoxDecoration(
        color:
            const Color(0xFF07131B),

        border:
            Border(
          top:
              BorderSide(
            color:
                Colors.white
                    .withOpacity(.06),

            width: 1,
          ),
        ),

        boxShadow: [
          BoxShadow(
            color:
                Colors.black
                    .withOpacity(.30),

            blurRadius:
                15,

            offset:
                const Offset(
              0,
              -4,
            ),
          ),
        ],
      ),

      child:
          SafeArea(
        top: false,

        child:
            SizedBox(
          height: 65,

          child:
              Row(
            mainAxisAlignment:
                MainAxisAlignment
                    .spaceAround,

            children: [

              // =============================================
              // HOME
              // =============================================

              _bottomNavItem(
                icon:
                    Icons.home_rounded,

                title:
                    "Home",

                selected:
                    true,

                onTap: () {
                  // Already on Home
                },
              ),

              // =============================================
              // SERVICES
              // =============================================

              _bottomNavItem(
                icon:
                    Icons.grid_view_rounded,

                title:
                    "Services",

                selected:
                    false,

                onTap: () {
                  setState(() {
                    showAllServices = true;
                  });
                },
              ),

              // =============================================
              // PORTFOLIO
              // =============================================

              _bottomNavItem(
                icon:
                    Icons.photo_library_rounded,

                title:
                    "Portfolio",

                selected:
                    false,

                onTap: () {
                  // Portfolio page yahan add kar sakte hain
                },
              ),

              // =============================================
              // PROFILE
              // =============================================

              _bottomNavItem(
                icon:
                    Icons.person_rounded,

                title:
                    "Profile",

                selected:
                    false,

                onTap: () {
                  final User? user =
                      FirebaseAuth
                          .instance
                          .currentUser;

                  _showProfileDialog(
                    user,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================================
  // BOTTOM NAV ITEM
  // =========================================================

  Widget _bottomNavItem({
    required IconData icon,
    required String title,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap:
          onTap,

      borderRadius:
          BorderRadius.circular(
        15,
      ),

      child:
          SizedBox(
        width: 70,
        height: 60,

        child:
            Column(
          mainAxisAlignment:
              MainAxisAlignment
                  .center,

          children: [

            Icon(
              icon,

              size: 23,

              color:
                  selected
                      ? const Color(
                          0xFF36B6BD,
                        )
                      : Colors.white54,
            ),

            const SizedBox(
              height: 3,
            ),

            Text(
              title,

              style:
                  GoogleFonts.poppins(
                color:
                    selected
                        ? const Color(
                            0xFF36B6BD,
                          )
                        : Colors.white54,

                fontSize:
                    10,

                fontWeight:
                    selected
                        ? FontWeight.w600
                        : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(
    BuildContext context,
  ) {
    // =========================================================
    // SERVICES DISPLAY LOGIC
    // =========================================================

    final List<Map<String, String>>
        displayedServices =
            showAllServices
                ? HomeData.services
                : HomeData.services.sublist(
                    0,
                    HomeData.services.length >
                            6
                        ? 6
                        : HomeData
                            .services
                            .length,
                  );

    return Scaffold(
      backgroundColor:
          HomeWidgets.background,

      // =======================================================
      // BODY
      // =======================================================

      body:
          SafeArea(
        child:
            Stack(
          children: [
            SingleChildScrollView(
              physics:
                  const BouncingScrollPhysics(),

              child:
              Column(
            crossAxisAlignment:
                CrossAxisAlignment
                    .start,

            children: [

              // =================================================
              // TOP BAR
              // =================================================

              Padding(
                padding:
                    const EdgeInsets
                        .symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),

                child:
                    Row(
                  children: [

                    // =============================================
                    // LOGO
                    // =============================================

                    Image.asset(
                      'images/assets/Alrmun_logo.png',

                      height:
                          64,

                      fit:
                          BoxFit.contain,
                    ),

                    const Spacer(),

                    // =============================================
                    // PROFILE
                    // =============================================

                    StreamBuilder<User?>(
                      stream:
                          FirebaseAuth
                              .instance
                              .authStateChanges(),

                      builder:
                          (
                        context,
                        snapshot,
                      ) {
                        final User? user =
                            snapshot.data;

                        final bool
                            isLoggedIn =
                            user != null;

                        return GestureDetector(
                          onTap:
                              () =>
                                  _showProfileDialog(
                            user,
                          ),

                          child:
                              Container(
                            decoration:
                                BoxDecoration(
                              shape:
                                  BoxShape
                                      .circle,

                              border:
                                  Border.all(
                                color:
                                    HomeWidgets
                                        .accent
                                        .withOpacity(
                                  .35,
                                ),

                                width:
                                    1,
                              ),
                            ),

                            child:
                                CircleAvatar(
                              radius:
                                  20,

                              backgroundColor:
                                  Colors
                                      .grey
                                      .shade800,

                              backgroundImage:
                                  (
                                        isLoggedIn &&
                                        user.photoURL !=
                                            null &&
                                        user.photoURL!
                                            .isNotEmpty
                                    )
                                      ? NetworkImage(
                                          user.photoURL!,
                                        )
                                      : null,

                              child:
                                  (
                                        !isLoggedIn ||
                                        user.photoURL ==
                                            null ||
                                        user.photoURL!
                                            .isEmpty
                                    )
                                      ? const Icon(
                                          Icons
                                              .person,

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

              const SizedBox(
                height: 8,
              ),

              // =================================================
              // BRANDING
              // =================================================

              Padding(
                padding:
                    const EdgeInsets
                        .symmetric(
                  horizontal: 16,
                ),

                child:
                    Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                  children: [

                    Text(
                      "ALRMAN ADVERTISING",

                      style:
                          GoogleFonts.poppins(
                        color:
                            Colors.white,

                        fontSize:
                            24,

                        fontWeight:
                            FontWeight.w800,

                        letterSpacing:
                            .8,
                      ),
                    ),

                    const SizedBox(
                      height: 2,
                    ),

                    Text(
                      "Creative Ideas. Powerful Advertising.",

                      style:
                          GoogleFonts.poppins(
                        color:
                            HomeWidgets
                                .accent,

                        fontSize:
                            12,

                        fontWeight:
                            FontWeight.w500,

                        letterSpacing:
                            .3,
                      ),
                    ),

                    const SizedBox(
                      height: 18,
                    ),

                    // =============================================
                    // ESTIMATE BUTTON
                    // =============================================

                    SizedBox(
                      width:
                          double.infinity,

                      height:
                          54,

                      child:
                          Container(
                        decoration:
                            BoxDecoration(
                          gradient:
                              const LinearGradient(
                            colors: [
                              Color(
                                0xFF16C8D8,
                              ),
                              Color(
                                0xFF0EA5B7,
                              ),
                            ],
                          ),

                          borderRadius:
                              BorderRadius
                                  .circular(
                            15,
                          ),

                          boxShadow: [
                            BoxShadow(
                              color:
                                  HomeWidgets
                                      .accent
                                      .withOpacity(
                                .20,
                              ),

                              blurRadius:
                                  14,

                              offset:
                                  const Offset(
                                0,
                                5,
                              ),
                            ),
                          ],
                        ),

                        child:
                            Material(
                          color:
                              Colors.transparent,

                          child:
                              InkWell(
                            onTap:
                                _openEstimate,

                            borderRadius:
                                BorderRadius
                                    .circular(
                              15,
                            ),

                            child:
                                Row(
                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .center,

                              children: [

                                const Icon(
                                  Icons
                                      .request_quote_rounded,

                                  color:
                                      Colors.black,

                                  size:
                                      21,
                                ),

                                const SizedBox(
                                  width:
                                      9,
                                ),

                                Text(
                                  "Get Your Free Estimate",

                                  style:
                                      GoogleFonts
                                          .poppins(
                                    color:
                                        Colors.black,

                                    fontSize:
                                        15,

                                    fontWeight:
                                        FontWeight.w700,
                                  ),
                                ),

                                const SizedBox(
                                  width:
                                      8,
                                ),

                                const Icon(
                                  Icons
                                      .arrow_forward_rounded,

                                  color:
                                      Colors.black,

                                  size:
                                      20,
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

              const SizedBox(
                height: 24,
              ),

              _buildCarousel(),

              const SizedBox(
                height: 12,
              ),

              // =================================================
              // SERVICES HEADER
              // =================================================

              HomeWidgets.sectionHeader(
                title:
                    "Services",

                subtitle:
                    "Everything your brand needs",

                buttonText:
                    showAllServices
                        ? "Show Less"
                        : "See All",

                showLess:
                    showAllServices,

                onButtonTap:
                    () {
                  setState(() {
                    showAllServices =
                        !showAllServices;
                  });
                },
              ),

              const SizedBox(
                height: 14,
              ),

              // =================================================
              // SERVICES GRID
              // =================================================

              HomeWidgets.servicesGrid(
                services:
                    displayedServices,

                onTap:
                    _openServiceDetail,
              ),

              const SizedBox(
                height: 35,
              ),
              ],
            ),
          ),

          // =====================================================
          // FLOATING WHATSAPP
          // =====================================================

          Positioned(
            right: 18,
            bottom: 20,
            child: _buildWhatsAppFloatingButton(),
          ),
        ],
      ),

          )
    );
  }
}