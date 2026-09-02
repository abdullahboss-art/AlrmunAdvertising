
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:adverting_app/User/Buttomnav.dart';
import 'package:adverting_app/User/Login.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen>
    with TickerProviderStateMixin {


  late final AnimationController _entranceController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  late final AnimationController _zoomController;
  late final Animation<double> _zoomAnimation;

  Timer? _autoPlayTimer;

  int _activePage = 0;



  // static const Color bgDark = Color(0xFF06131C);
  static const Color accent = Color(0xFF16C8D8);
  static const Color accentLight = Color(0xFF9FEFF5);

  // ============================================================
  // BACKGROUND IMAGES
  // ============================================================

  static const List<String> _images = [
    "images/assets/GetStarted1.png",
    "images/assets/GetStarted2.png",
    "images/assets/GetStarted3.png",
  ];


  static const List<String> _titles = [
    "Build Your",
    "Make It",
    "Grow With",
  ];

  static const List<String> _highlightTitles = [
    "Brand.",
    "Memorable.",
    "Impact.",
  ];

  // ============================================================
  // DESCRIPTIONS
  // ============================================================

  static const List<String> _descriptions = [
    "We create modern digital experiences\nthat make your business stand out.",
    "Turn your ideas into a powerful\nvisual identity.",
    "Powerful design and branding that\nhelp your business move forward.",
  ];

  // ============================================================
  // FALLBACK ICONS
  // ============================================================

  static const List<IconData> _fallbackIcons = [
    Icons.brush_rounded,
    Icons.auto_awesome_rounded,
    Icons.trending_up_rounded,
  ];

  // ============================================================
  // INIT STATE
  // ============================================================

  @override
  void initState() {
    super.initState();

    // ==========================================================
    // ENTRANCE ANIMATION
    // ==========================================================

    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();

    _fadeAnimation = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: Curves.easeOutCubic,
      ),
    );

    // ==========================================================
    // BACKGROUND ZOOM
    // ==========================================================

    _zoomController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat(reverse: true);

    _zoomAnimation = Tween<double>(
      begin: 1.0,
      end: 1.06,
    ).animate(
      CurvedAnimation(
        parent: _zoomController,
        curve: Curves.easeInOut,
      ),
    );

    // ==========================================================
    // AUTO PLAY
    // ==========================================================

    _startAutoPlay();
  }

  // ============================================================
  // AUTO PLAY
  // ============================================================

  void _startAutoPlay() {
    _autoPlayTimer?.cancel();

    _autoPlayTimer = Timer.periodic(
      const Duration(seconds: 5),
      (_) {
        if (!mounted) return;

        setState(() {
          _activePage = (_activePage + 1) % _images.length;
        });
      },
    );
  }

  // ============================================================
  // NEXT PAGE
  // ============================================================

  void _nextPage() {
    if (!mounted) return;

    setState(() {
      _activePage = (_activePage + 1) % _images.length;
    });

    _startAutoPlay();
  }



  void _selectPage(int index) {
    if (!mounted) return;

    setState(() {
      _activePage = index;
    });

    _startAutoPlay();
  }



  void _handleGetStarted() {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // --------------------------------------------------------
      // USER ALREADY LOGGED IN
      // --------------------------------------------------------

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const CustomBottomNavBar(),
        ),
      );
    } else {
      // --------------------------------------------------------
      // USER NOT LOGGED IN
      // --------------------------------------------------------

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginPage(),
        ),
      );
    }
  }


  @override
  void dispose() {
    _entranceController.dispose();
    _zoomController.dispose();
    _autoPlayTimer?.cancel();

    super.dispose();
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: bgDark,

      body: Stack(
        fit: StackFit.expand,
        children: [
         

          _buildFullScreenBackground(),

        

          _buildBackgroundGlow(),


          SafeArea(
            child: FadeTransition(
              opacity: _fadeAnimation,

              child: SlideTransition(
                position: _slideAnimation,

                child: Column(
                  children: [
                    _buildTopBar(),

                    Expanded(
                      child: _buildMainContent(),
                    ),

                    _buildGetStartedButton(),

                    const SizedBox(height: 12),

                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Text(
                        "Let's build something great together 🚀",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // FULL SCREEN BACKGROUND
  // ============================================================

  Widget _buildFullScreenBackground() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 900),
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,

      child: AnimatedBuilder(
        key: ValueKey(_activePage),
        animation: _zoomAnimation,

        builder: (context, child) {
          return Transform.scale(
            scale: _zoomAnimation.value,

            child: Image.asset(
              _images[_activePage],
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,

              errorBuilder: (
                context,
                error,
                stackTrace,
              ) {
                return Container(
                  width: double.infinity,
                  height: double.infinity,

                  // decoration: const BoxDecoration(
                  //   gradient: LinearGradient(
                  //     begin: Alignment.topLeft,
                  //     end: Alignment.bottomRight,
                  //     // colors: [
                  //     //   bgDark,
                  //     //   Color(0xFF0C2530),
                  //     // ],
                  //   ),
                  // ),

                  child: Center(
                    child: Icon(
                      _fallbackIcons[
                          _activePage % _fallbackIcons.length],
                      size: 100,
                      color: accent.withOpacity(0.35),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  // ============================================================
  // DARK OVERLAY
  // ============================================================

  

  // ============================================================
  // BACKGROUND GLOW
  // ============================================================

  Widget _buildBackgroundGlow() {
    return Stack(
      children: [
        Positioned(
          top: -100,
          right: -100,

          child: Container(
            width: 300,
            height: 300,

            decoration: BoxDecoration(
              shape: BoxShape.circle,

              gradient: RadialGradient(
                colors: [
                  accent.withOpacity(0.18),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),

        Positioned(
          bottom: -150,
          left: -120,

          child: Container(
            width: 320,
            height: 320,

            decoration: BoxDecoration(
              shape: BoxShape.circle,

              gradient: RadialGradient(
                colors: [
                  accent.withOpacity(0.12),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // TOP BAR
  // ============================================================

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        22,
        12,
        22,
        8,
      ),

      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,

        children: [
          // ------------------------------------------------------
          // LOGO
          // ------------------------------------------------------

          Container(
            width: 160,
            height: 160,
            padding: const EdgeInsets.all(4),


            child: Image.asset(
              "images/assets/Alrmun_logo.png",
              height: 60,
              width: 60,
              fit: BoxFit.contain,

              errorBuilder: (
                context,
                error,
                stackTrace,
              ) {
                return Container(
               
                );
              },
            ),
          ),

          // ------------------------------------------------------
          // EXPLORE
          // ------------------------------------------------------

          // TextButton(
          //   onPressed: () {
          //     // Explore action
          //   },

          //   style: TextButton.styleFrom(
          //     padding: const EdgeInsets.symmetric(
          //       horizontal: 4,
          //       vertical: 6,
          //     ),
          //   ),

          //   child: Container(
          //     padding: const EdgeInsets.symmetric(
          //       horizontal: 11,
          //       vertical: 7,
          //     ),

          //     decoration: BoxDecoration(
          //       color:
          //           Colors.black.withOpacity(0.25),

          //       borderRadius:
          //           BorderRadius.circular(20),

          //       border: Border.all(
          //         color:
          //             Colors.white.withOpacity(0.12),
          //       ),
          //     ),

          //     child: const Row(
          //       children: [
          //         Text(
          //           "Explore",
          //           style: TextStyle(
          //             color: Colors.white,
          //             fontSize: 13,
          //             fontWeight:
          //                 FontWeight.w500,
          //           ),
          //         ),

          //         SizedBox(width: 5),

          //         Icon(
          //           Icons.arrow_forward_ios_rounded,
          //           color: accent,
          //           size: 11,
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  // ============================================================
  // MAIN CONTENT
  // ============================================================

  Widget _buildMainContent() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        24,
        20,
        24,
        20,
      ),

      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.end,

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          // ------------------------------------------------------
          // SMALL LABEL
          // ------------------------------------------------------

          Row(
            children: [
              Container(
                width: 32,
                height: 3,

                decoration: BoxDecoration(
                  color: accent,

                  borderRadius:
                      BorderRadius.circular(20),

                  boxShadow: [
                    BoxShadow(
                      color:
                          accent.withOpacity(0.7),
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 9),

              const Text(
                "ALRMUN STUDIO",

                style: TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight:
                      FontWeight.w600,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // ------------------------------------------------------
          // TITLE
          // ------------------------------------------------------

          AnimatedSwitcher(
            duration:
                const Duration(milliseconds: 500),

            switchInCurve:
                Curves.easeOut,

            switchOutCurve:
                Curves.easeIn,

            child: Column(
              key: ValueKey(_activePage),

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  _titles[_activePage],

                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight:
                        FontWeight.w800,
                    height: 0.98,
                    letterSpacing: -0.8,
                  ),
                ),

                ShaderMask(
                  shaderCallback: (bounds) {
                    return const LinearGradient(
                      colors: [
                        accent,
                        accentLight,
                      ],
                    ).createShader(bounds);
                  },

                  child: Text(
                    _highlightTitles[_activePage],

                    style:
                        const TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight:
                          FontWeight.w800,
                      height: 0.98,
                      letterSpacing: -0.8,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // ------------------------------------------------------
          // DESCRIPTION
          // ------------------------------------------------------

          AnimatedSwitcher(
            duration:
                const Duration(milliseconds: 400),

            child: Text(
              _descriptions[_activePage],

              key: ValueKey(
                "description_$_activePage",
              ),

              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
                height: 1.55,
                fontWeight:
                    FontWeight.w400,
              ),
            ),
          ),

          const SizedBox(height: 22),

          // ------------------------------------------------------
          // SLIDER
          // ------------------------------------------------------

          Row(
            children: [
              Row(
                children: List.generate(
                  _images.length,
                  (index) {
                    final bool active =
                        index == _activePage;

                    return GestureDetector(
                      onTap: () =>
                          _selectPage(index),

                      child: AnimatedContainer(
                        duration:
                            const Duration(
                          milliseconds: 300,
                        ),

                        curve:
                            Curves.easeOut,

                        margin:
                            const EdgeInsets.only(
                          right: 7,
                        ),

                        width:
                            active ? 28 : 8,

                        height: 7,

                        decoration:
                            BoxDecoration(
                          color: active
                              ? accent
                              : Colors.white30,

                          borderRadius:
                              BorderRadius.circular(
                            20,
                          ),

                          boxShadow: active
                              ? [
                                  BoxShadow(
                                    color:
                                        accent.withOpacity(
                                      0.55,
                                    ),
                                    blurRadius: 10,
                                  ),
                                ]
                              : null,
                        ),
                      ),
                    );
                  },
                ),
              ),

              const Spacer(),

              // --------------------------------------------------
              // NEXT
              // --------------------------------------------------

              GestureDetector(
                onTap: _nextPage,

                child: Container(
                  width: 50,
                  height: 50,

                  decoration:
                      BoxDecoration(
                    color: accent,
                    shape: BoxShape.circle,

                    boxShadow: [
                      BoxShadow(
                        color:
                            accent.withOpacity(
                          0.40,
                        ),
                        blurRadius: 20,
                        spreadRadius: 1,
                      ),
                    ],
                  ),

                  child: const Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // GET STARTED BUTTON
  // ============================================================

 Widget _buildGetStartedButton() {
  return Padding(
    padding: const EdgeInsets.fromLTRB(
      18,
      4,
      18,
      0,
    ),
    child: SizedBox(
      width: double.infinity,
      height: 57,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),

          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              accent,
              accentLight,
            ],
          ),

          boxShadow: [
            BoxShadow(
              color: accent.withOpacity(0.35),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),

        child: ElevatedButton(
          onPressed: _handleGetStarted,

          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF36B6BD),

            foregroundColor: Colors.white,

            shadowColor: Colors.transparent,

            elevation: 0,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(17),
            ),
          ),

          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Text(
                "Get Started",

                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                ),
              ),

              SizedBox(width: 12),

              // White Round Arrow Button
             CircleAvatar(
  radius: 19,
  backgroundColor: Colors.white,
  child: const Icon(
    Icons.arrow_forward_rounded,
    color: Color(0xFF36B6BD),
    size: 25,
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

