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
  late AnimationController _lineController;
  late AnimationController _frameController;

  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<double> _glow;
  late Animation<double> _lineGrow;
  late Animation<double> _frameScale;
  late Animation<double> _frameOpacity;

  Timer? _progressTimer;

  double progress = 0.0;
  int percentage = 0;

  static const Color kAccent = Color(0xFF16C8D8);
  static const Color kAccent2 = Color(0xFF5EF0E0);

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
    // FRAME (SCREEN) BUILD ANIMATION — pehle logo, phir screen banti hai
    // ============================================================

    _frameController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );

    _frameScale = Tween<double>(
      begin: 0.035,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _frameController,
        curve: Curves.easeOutCubic,
      ),
    );

    _frameOpacity = CurvedAnimation(
      parent: _frameController,
      curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
    );

    // ============================================================
    // LOGO GLOW
    // ============================================================

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

    // ============================================================
    // CONNECTOR LINE (box -> divider) GROW ANIMATION
    // ============================================================

    _lineController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _lineGrow = CurvedAnimation(
      parent: _lineController,
      curve: Curves.easeOut,
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
    // Step 1: Pehle sirf LOGO dikhta hai
    await _logoController.forward();

    if (!mounted) return;

    // Logo ko thora time do screen par settle hone ke liye
    await Future.delayed(
      const Duration(milliseconds: 350),
    );

    if (!mounted) return;

    // Step 2: Ab uske around SCREEN (frame) banti hai
    await _frameController.forward();

    if (!mounted) return;

    // Frame ban gaya, ab glow pulse shuru
    _glowController.repeat(reverse: true);

    _lineController.forward();

    await Future.delayed(
      const Duration(milliseconds: 300),
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
      const Duration(milliseconds: 45),
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
    _lineController.dispose();
    _frameController.dispose();

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
                // LOGO — pehle akela dikhta hai
                // FRAME/SCREEN — uske baad logo ke around ban ke aati hai
                // ====================================================

                SizedBox(
                  width: 340,
                  height: 200,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // -----------------------------------------------
                      // STEP 2: Screen/frame apne aap build hoti hai
                      // (jaise TV/LED screen ON hoti hai — pehle patli
                      // line, phir puri height tak khulti hai)
                      // -----------------------------------------------
                      AnimatedBuilder(
                        animation: Listenable.merge(
                          [_frameController, _glow],
                        ),
                        builder: (context, child) {
                          return Opacity(
                            opacity: _frameOpacity.value,
                            child: Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()
                                ..scale(1.0, _frameScale.value),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  // Outer soft glow (glow shuru hoti hai
                                  // sirf jab frame ban chuka ho)
                                  Container(
                                    width: 340 *
                                        (_frameController.isCompleted
                                            ? _glow.value
                                            : 1.0),
                                    height: 200 *
                                        (_frameController.isCompleted
                                            ? _glow.value
                                            : 1.0),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(6),
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              kAccent.withOpacity(0.35),
                                          blurRadius: 60,
                                          spreadRadius: 4,
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Framed box (double border)
                                  Container(
                                    width: 300,
                                    height: 165,
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF03080D)
                                          .withOpacity(0.6),
                                      border: Border.all(
                                        color: kAccent.withOpacity(0.55),
                                        width: 1.4,
                                      ),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: kAccent.withOpacity(0.9),
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),

                      // -----------------------------------------------
                      // STEP 1: Sirf logo, sabse pehle dikhta hai
                      // -----------------------------------------------
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
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // ====================================================
                // CONNECTOR LINE (T shape growing down from box)
                // ====================================================

                AnimatedBuilder(
                  animation: _lineGrow,
                  builder: (context, child) {
                    return Column(
                      children: [
                        Container(
                          width: 1.6,
                          height: 34 * _lineGrow.value,
                          color: kAccent.withOpacity(0.8),
                        ),
                        Opacity(
                          opacity: _lineGrow.value,
                          child: Container(
                            width: 120,
                            height: 1.6,
                            color: kAccent.withOpacity(0.8),
                          ),
                        ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 26),

                // ====================================================
                // BRAND NAME
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
                // LOADING
                // ====================================================

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: Column(
                    children: [
                      // =================================================
                      // PROGRESS BAR
                      // =================================================

                      Container(
                        width: double.infinity,
                        height: 3,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: progress,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [kAccent, kAccent2],
                              ),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: kAccent.withOpacity(0.5),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

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
