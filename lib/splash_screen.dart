
import 'dart:async';
import 'dart:math';

import 'package:adverting_app/User/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'User/get_started_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _glowController;
  late AnimationController _backgroundController;

  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<double> _glow;

  Timer? _progressTimer;

  double progress = 0.0;
  int percentage = 0;

  @override
  void initState() {
    super.initState();

    // ============================================================
    // LOGO ENTRANCE
    // ============================================================

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _logoScale = Tween<double>(
      begin: 0.75,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: Curves.easeOutBack,
      ),
    );

    _logoOpacity = CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeOut,
    );

    // ============================================================
    // LOGO GLOW
    // ============================================================

    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);

    _glow = Tween<double>(
      begin: 0.85,
      end: 1.10,
    ).animate(
      CurvedAnimation(
        parent: _glowController,
        curve: Curves.easeInOut,
      ),
    );

    // ============================================================
    // BACKGROUND ANIMATION
    // ============================================================

    _backgroundController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    // ============================================================
    // START
    // ============================================================

    _startSplash();
  }

  // ============================================================
  // START SPLASH
  // ============================================================

  Future<void> _startSplash() async {
    _logoController.forward();

    // Logo ko thora time do
    await Future.delayed(
      const Duration(milliseconds: 700),
    );

    if (!mounted) return;

    _startProgress();
  }

  // ============================================================
  // PROGRESS 0 -> 100
  // ============================================================

  void _startProgress() {
    int currentPercentage = 0;

    _progressTimer = Timer.periodic(
      const Duration(milliseconds: 55),
      (timer) {
        if (!mounted) {
          timer.cancel();
          return;
        }

        currentPercentage++;

        setState(() {
          percentage = currentPercentage;
          progress = currentPercentage / 100;
        });

        // ========================================================
        // 100% REACHED
        // ========================================================

        if (currentPercentage >= 100) {
          timer.cancel();

          // 100% ko screen par clearly show hone do
          Future.delayed(
            const Duration(milliseconds: 1000),
            () {
              if (!mounted) return;

              _goNext();
            },
          );
        }
      },
    );
  }

  // ============================================================
  // NEXT SCREEN
  // ============================================================

  // void _goNext() {
  //   if (!mounted) return;

  //   Navigator.pushReplacement(
  //     context,
  //     PageRouteBuilder(
  //       transitionDuration: const Duration(milliseconds: 600),
  //       pageBuilder: (_, animation, __) {
  //         return const GetStartedScreen();
  //       },
  //       transitionsBuilder: (_, animation, __, child) {
  //         return FadeTransition(
  //           opacity: CurvedAnimation(
  //             parent: animation,
  //             curve: Curves.easeInOut,
  //           ),
  //           child: child,
  //         );
  //       },
  //     ),
  //   );
  // }


void _goNext() {
  if (!mounted) return;

  // final user = FirebaseAuth.instance.currentUser;

  Navigator.pushReplacement(
    context,
    PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 600),
      pageBuilder: (_, animation, __) {
        

        return const GetStartedScreen();
      },
      transitionsBuilder: (_, animation, __, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    ),

  );
}
  @override
  void dispose() {
    _progressTimer?.cancel();

    _logoController.dispose();
    _glowController.dispose();
    _backgroundController.dispose();

    super.dispose();
  }

  // ============================================================
  // UI
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050B10),

      body: Stack(
        children: [
          // ========================================================
          // BACKGROUND
          // ========================================================

          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF03080D),
                  Color(0xFF07141C),
                  Color(0xFF081A22),
                  Color(0xFF03080D),
                ],
              ),
            ),
          ),

          // ========================================================
          // MOVING LIGHT
          // ========================================================

          AnimatedBuilder(
            animation: _backgroundController,
            builder: (context, child) {
              return CustomPaint(
                size: Size.infinite,
                painter: _PremiumBackgroundPainter(
                  _backgroundController.value,
                ),
              );
            },
          ),

          // ========================================================
          // MAIN CONTENT
          // ========================================================

          SafeArea(
            child: Column(
              children: [
                const Spacer(flex: 3),

                // ====================================================
                // LOGO
                // ====================================================

                // FadeTransition(
                //   opacity: _logoOpacity,
                //   child: ScaleTransition(
                //     scale: _logoScale,
                //     child: AnimatedBuilder(
                //       animation: _glow,
                //       builder: (context, child) {
                //         return Stack(
                //           alignment: Alignment.center,
                //           children: [
                //             // Glow
                //             Container(
                //               width: 190 * _glow.value,
                //               height: 190 * _glow.value,
                //               decoration: BoxDecoration(
                //                 shape: BoxShape.circle,
                //                 boxShadow: [
                //                   BoxShadow(
                //                     color: const Color(0xFF16C8D8)
                //                         .withOpacity(0.18),
                //                     blurRadius: 90,
                //                     spreadRadius: 15,
                //                   ),
                //                 ],
                //               ),
                //             ),

                //             // Inner circle
                //             Container(
                //               width: 145,
                //               height: 145,
                //               decoration: BoxDecoration(
                //                 shape: BoxShape.circle,
                //                 color: const Color(0xFF16C8D8)
                //                     .withOpacity(0.025),
                //                 border: Border.all(
                //                   color: const Color(0xFF16C8D8)
                //                       .withOpacity(0.15),
                //                   width: 1,
                //                 ),
                //               ),
                //             ),

                //             // Logo
                //             Image.asset(
                //               "images/assets/Alrmun_logo.png",
                //               width: 125,
                //               height: 125,
                //               fit: BoxFit.contain,
                //             ),
                //           ],
                //         );
                //       },
                //     ),
                //   ),
                // ),

FadeTransition(
  opacity: _logoOpacity,
  child: ScaleTransition(
    scale: _logoScale,
    child: AnimatedBuilder(
      animation: _glow,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            // Soft Glow — background circle/border removed
            Container(
              width: 210 * _glow.value,
              height: 210 * _glow.value,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                // boxShadow: [
                //   BoxShadow(
                //     color: const Color(0xFF16C8D8).withOpacity(0.20),
                //     blurRadius: 85,
                //     spreadRadius: 8,
                //   ),
                // ],
              ),
            ),

            // Logo — larger and no background/border
            Image.asset(
              "images/assets/Alrmun_logo.png",
              width: 155,
              height: 155,
              fit: BoxFit.contain,
            ),
          ],
        );
      },
    ),
  ),
),


                const SizedBox(height: 32),

                // ====================================================
                // BRAND NAME
                // ====================================================

                FadeTransition(
                  opacity: _logoOpacity,
                  child: Column(
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) {
                          return const LinearGradient(
                            colors: [
                              Colors.white,
                              Color(0xFF9FEFF5),
                            ],
                          ).createShader(bounds);
                        },
                        child: const Text(
                          "ALRMAN ADVERTISING",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2.4,
                          ),
                        ),
                      ),

                      const SizedBox(height: 13),

                      const Text(
                        "Creative Design • Digital Marketing",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          letterSpacing: 0.4,
                        ),
                      ),

                      const SizedBox(height: 5),

                      const Text(
                        "Branding • Printing Solutions",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 13,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(flex: 3),

                // ====================================================
                // LOADING
                // ====================================================

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    children: [
                      // Percentage + Loading
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "LOADING",
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 11,
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          Text(
                            "$percentage%",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      // =================================================
                      // PROGRESS BAR
                      // =================================================

                      Container(
                        width: double.infinity,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.07),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: progress,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF16C8D8),
                                  Color(0xFF5EF0E0),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF16C8D8)
                                      .withOpacity(0.45),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      const Text(
                        "Preparing your experience...",
                        style: TextStyle(
                          color: Colors.white38,
                          fontSize: 11,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 35),

                // ====================================================
                // COPYRIGHT
                // ====================================================

                const Text(
                  "© 2026 Alrman Advertising",
                  style: TextStyle(
                    color: Colors.white30,
                    fontSize: 11,
                    letterSpacing: 0.5,
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==================================================================
// PREMIUM BACKGROUND
// ==================================================================

class _PremiumBackgroundPainter extends CustomPainter {
  final double t;

  _PremiumBackgroundPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final time = t * 2 * pi;

    // TOP LIGHT
    final topCenter = Offset(
      size.width * 0.12 + cos(time) * 35,
      size.height * 0.18 + sin(time) * 30,
    );

    final topPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFF16C8D8).withOpacity(0.10),
          const Color(0xFF16C8D8).withOpacity(0.0),
        ],
      ).createShader(
        Rect.fromCircle(
          center: topCenter,
          radius: 210,
        ),
      );

    canvas.drawCircle(
      topCenter,
      210,
      topPaint,
    );

    // BOTTOM LIGHT
    final bottomCenter = Offset(
      size.width * 0.88 + sin(time * 0.7) * 40,
      size.height * 0.78 + cos(time * 0.7) * 35,
    );

    final bottomPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFF5EF0E0).withOpacity(0.07),
          const Color(0xFF5EF0E0).withOpacity(0.0),
        ],
      ).createShader(
        Rect.fromCircle(
          center: bottomCenter,
          radius: 230,
        ),
      );

    canvas.drawCircle(
      bottomCenter,
      230,
      bottomPaint,
    );
  }

  @override
  bool shouldRepaint(
    covariant _PremiumBackgroundPainter oldDelegate,
  ) {
    return oldDelegate.t != t;
  }
}
