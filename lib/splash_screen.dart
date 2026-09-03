import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'User/get_started_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // ================================================================
  // ANIMATION CONTROLLERS
  // ================================================================

  late AnimationController _logoController;
  late AnimationController _glowController;
  late AnimationController _backgroundController;
  late AnimationController _lineController;
  late AnimationController _frameController;

  // ================================================================
  // ANIMATIONS
  // ================================================================

  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;

  late Animation<double> _glow;

  late Animation<double> _lineGrow;

  late Animation<double> _frameScale;
  late Animation<double> _frameOpacity;

  Timer? _progressTimer;

  double progress = 0.0;
  int percentage = 0;

  // ================================================================
  // COLORS
  // ================================================================

  static const Color kAccent = Color(0xFF16C8D8);
  static const Color kAccent2 = Color(0xFF5EF0E0);

  // ================================================================
  // INIT
  // ================================================================

  @override
  void initState() {
    super.initState();

    // ================================================================
    // LOGO ANIMATION
    // ================================================================

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _logoScale = Tween<double>(
      begin: 0.65,
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

    // ================================================================
    // LED SCREEN / FRAME ANIMATION
    //
    // Pehle frame bohat thin hoga
    // Phir center se full screen banegi
    // ================================================================

    _frameController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 950),
    );

    _frameScale = Tween<double>(
      begin: 0.02,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _frameController,
        curve: Curves.easeOutCubic,
      ),
    );

    _frameOpacity = CurvedAnimation(
      parent: _frameController,
      curve: const Interval(
        0.0,
        0.35,
        curve: Curves.easeOut,
      ),
    );

    // ================================================================
    // GLOW
    // ================================================================

    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _glow = Tween<double>(
      begin: 0.85,
      end: 1.10,
    ).animate(
      CurvedAnimation(
        parent: _glowController,
        curve: Curves.easeInOut,
      ),
    );

    // ================================================================
    // CONNECTOR LINE
    // ================================================================

    _lineController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );

    _lineGrow = CurvedAnimation(
      parent: _lineController,
      curve: Curves.easeOut,
    );

    // ================================================================
    // BACKGROUND
    // ================================================================

    _backgroundController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    // ================================================================
    // START SPLASH
    // ================================================================

    _startSplash();
  }

  // ================================================================
  // SPLASH ANIMATION SEQUENCE
  // ================================================================

  Future<void> _startSplash() async {
    // --------------------------------------------------------------
    // STEP 1
    // Pehle sirf logo appear hoga
    // --------------------------------------------------------------

    await _logoController.forward();

    if (!mounted) return;

    // --------------------------------------------------------------
    // Logo ko thora hold karte hain
    // --------------------------------------------------------------

    await Future.delayed(
      const Duration(milliseconds: 500),
    );

    if (!mounted) return;

    // --------------------------------------------------------------
    // STEP 2
    // LED SCREEN FRAME BUILD
    // --------------------------------------------------------------

    await _frameController.forward();

    if (!mounted) return;

    // --------------------------------------------------------------
    // STEP 3
    // Frame complete hone ke baad glow start
    // --------------------------------------------------------------

    _glowController.repeat(reverse: true);

    // --------------------------------------------------------------
    // STEP 4
    // Connector line
    // --------------------------------------------------------------

    await Future.delayed(
      const Duration(milliseconds: 100),
    );

    if (!mounted) return;

    _lineController.forward();

    // --------------------------------------------------------------
    // STEP 5
    // Small pause
    // --------------------------------------------------------------

    await Future.delayed(
      const Duration(milliseconds: 350),
    );

    if (!mounted) return;

    // --------------------------------------------------------------
    // STEP 6
    // START LOADING
    // --------------------------------------------------------------

    _startProgress();
  }

  // ================================================================
  // PROGRESS 0 -> 100
  // ================================================================

  void _startProgress() {
    int currentPercentage = 0;

    _progressTimer = Timer.periodic(
      const Duration(milliseconds: 45),
      (timer) {
        if (!mounted) {
          timer.cancel();
          return;
        }

        currentPercentage++;

        if (currentPercentage > 100) {
          currentPercentage = 100;
        }

        setState(() {
          percentage = currentPercentage;
          progress = currentPercentage / 100;
        });

        // ------------------------------------------------------------
        // 100%
        // ------------------------------------------------------------

        if (currentPercentage >= 100) {
          timer.cancel();

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

  // ================================================================
  // NEXT SCREEN
  // ================================================================

  void _goNext() {
    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(
          milliseconds: 650,
        ),
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

  // ================================================================
  // DISPOSE
  // ================================================================

  @override
  void dispose() {
    _progressTimer?.cancel();

    _logoController.dispose();
    _glowController.dispose();
    _backgroundController.dispose();
    _lineController.dispose();
    _frameController.dispose();

    super.dispose();
  }

  // ================================================================
  // UI
  // ================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050B10),
      body: Stack(
        children: [
          // ==========================================================
          // BACKGROUND GRADIENT
          // ==========================================================

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

          // ==========================================================
          // MOVING BACKGROUND LIGHT
          // ==========================================================

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

          // ==========================================================
          // MAIN CONTENT
          // ==========================================================

          SafeArea(
            child: Column(
              children: [
                const Spacer(flex: 3),

                // ====================================================
                // LOGO + LED SCREEN
                // ====================================================

                SizedBox(
                  width: 340,
                  height: 165,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // ==================================================
                      // LED SCREEN / FRAME
                      //
                      // YE LOGO KE BAAD APPEAR HOGA
                      // ==================================================

                      AnimatedBuilder(
                        animation: Listenable.merge([
                          _frameController,
                          _glowController,
                        ]),
                        builder: (context, child) {
                          final bool frameCompleted =
                              _frameController.isCompleted;

                          final double glowValue =
                              frameCompleted ? _glow.value : 1.0;

                          return Opacity(
                            opacity: _frameOpacity.value,
                            child: Transform.scale(
                              scale: _frameScale.value,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  // ====================================
                                  // OUTER GLOW
                                  // ====================================

                                  Container(
                                    width: 340 * glowValue,
                                    height: 165 * glowValue,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              kAccent.withOpacity(0.30),
                                          blurRadius: 55,
                                          spreadRadius: 3,
                                        ),
                                      ],
                                    ),
                                  ),

                                  // ====================================
                                  // OUTER FRAME
                                  // ====================================

                                  Container(
                                    width: 318,
                                    height: 165,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(5),
                                      border: Border.all(
                                        color:
                                            kAccent.withOpacity(0.30),
                                        width: 1,
                                      ),
                                    ),
                                  ),

                                  // ====================================
                                  // MAIN LED SCREEN
                                  // ====================================

                                  Container(
                                    width: 300,
                                    height: 165,
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF03080D)
                                          .withOpacity(0.75),
                                      border: Border.all(
                                        color:
                                            kAccent.withOpacity(0.60),
                                        width: 1.4,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              kAccent.withOpacity(0.15),
                                          blurRadius: 15,
                                        ),
                                      ],
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color:
                                              kAccent.withOpacity(0.90),
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                  ),

                                  // ====================================
                                  // INNER SCREEN GLOW
                                  // ====================================

                                  Container(
                                    width: 286,
                                    height: 151,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color:
                                            kAccent.withOpacity(0.18),
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),

                      // ==================================================
                      // LOGO
                      //
                      // YE SABSE PEHLE APPEAR HOGA
                      // ==================================================

                      FadeTransition(
                        opacity: _logoOpacity,
                        child: ScaleTransition(
                          scale: _logoScale,
                          child: SizedBox(
                            width: 190,
                            height: 110,
                            child: Image.asset(
                              "images/assets/Alrmun_logo.png",
                              fit: BoxFit.contain,
                              errorBuilder:
                                  (context, error, stackTrace) {
                                return const Icon(
                                  Icons.image_not_supported_outlined,
                                  color: kAccent,
                                  size: 42,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // ====================================================
                // CONNECTOR LINE
                // ====================================================

                AnimatedBuilder(
                  animation: _lineGrow,
                  builder: (context, child) {
                    return Column(
                      children: [
                        Container(
                          width: 1.6,
                          height: 34 * _lineGrow.value,
                          color: kAccent.withOpacity(0.80),
                        ),
                        Opacity(
                          opacity: _lineGrow.value,
                          child: Container(
                            width: 120,
                            height: 1.6,
                            color: kAccent.withOpacity(0.80),
                          ),
                        ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 26),

                // ====================================================
                // BRANDING
                // ====================================================

                FadeTransition(
                  opacity: _logoOpacity,
                  child: Column(
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: "ADVERTISING",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 2.4,
                              ),
                            ),
                            TextSpan(
                              text: "  •  ",
                              style: TextStyle(
                                color: kAccent,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextSpan(
                              text: "PRINTING",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 2.4,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        "CREATIVE SOLUTIONS",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white38,
                          fontSize: 11,
                          letterSpacing: 2.5,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(flex: 3),

                // ====================================================
                // LOADING BAR
                // ====================================================

                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 60),
                  child: Column(
                    children: [
                      // ==============================================
                      // PROGRESS BAR
                      // ==============================================

                      Container(
                        width: double.infinity,
                        height: 3,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          borderRadius:
                              BorderRadius.circular(20),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: progress,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  kAccent,
                                  kAccent2,
                                ],
                              ),
                              borderRadius:
                                  BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      kAccent.withOpacity(0.50),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // ==============================================
                      // PERCENTAGE
                      // ==============================================

                      Text(
                        "$percentage%",
                        style: const TextStyle(
                          color: Colors.white38,
                          fontSize: 11,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w500,
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
                    color: Colors.white24,
                    fontSize: 10,
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
// PREMIUM ANIMATED BACKGROUND
// ==================================================================

class _PremiumBackgroundPainter extends CustomPainter {
  final double t;

  _PremiumBackgroundPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final time = t * 2 * pi;

    // ==============================================================
    // TOP LIGHT
    // ==============================================================

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

    // ==============================================================
    // BOTTOM LIGHT
    // ==============================================================

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