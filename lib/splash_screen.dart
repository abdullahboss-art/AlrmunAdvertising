

// import 'dart:async';

// import 'package:flutter/material.dart';

// import 'User/get_started_screen.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   double progress = 0.0;
//   int percentage = 0;

//   @override
//   void initState() {
//     super.initState();

//     Timer.periodic(const Duration(milliseconds: 40), (timer) {
//       setState(() {
//         progress += 0.01;
//         percentage = (progress * 100).toInt();

//         if (progress >= 1) {
//           progress = 1;
//           percentage = 100;
//           timer.cancel();

//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (_) => const GetStartedScreen(),
//             ),
//           );
//         }
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,

//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Color(0xff05111A),
//               Color(0xff0A1D29),
//               Color(0xff07131B),
//             ],
//           ),
//         ),

//         child: SafeArea(
//           child: Column(
//             children: [
//               const Spacer(),

//               // /// Logo Glow
//               // Stack(
//               //   alignment: Alignment.center,
//               //   children: [
//               //     Container(
//               //       width: 180,
//               //       height: 180,
//               //       decoration: BoxDecoration(
//               //         shape: BoxShape.circle,
//               //         boxShadow: [
//               //           BoxShadow(
//               //             color: const Color(0xff16C8D8).withOpacity(.45),
//               //             blurRadius: 120,
//               //             spreadRadius: 25,
//               //           ),
//               //         ],
//               //       ),
//               //     ),

//               //     Image.asset(
//               //       "images/assets/Alrmun_logo.png",
//               //       width: 110,
//               //     ),
//               //   ],
//               // ),

//               /// Logo Glow
// /// Professional Logo Glow
// Stack(
//   alignment: Alignment.center,
//   children: [
//     // Soft white glow behind the logo
//     Container(
//       width: 210,
//       height: 210,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.white.withOpacity(0.28),
//             blurRadius: 65,
//             spreadRadius: 8,
//           ),
//           BoxShadow(
//             color: const Color(0xff16C8D8).withOpacity(0.18),
//             blurRadius: 90,
//             spreadRadius: 5,
//           ),
//         ],
//       ),
//     ),

//     // Logo only — NO white background
//     Image.asset(
//       "images/assets/Alrmun_logo.png",
//       width: 145,
//       height: 145,
//       fit: BoxFit.contain,
//     ),
//   ],
// ),


//               const SizedBox(height: 22),

//               const Text(
//                 "ALRMAN ADVERTISING",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 25,
//                   fontWeight: FontWeight.bold,
//                   letterSpacing: 2,
//                 ),
//               ),

//               const SizedBox(height: 15),

//               const Text(
//                 "Creative Design • Digital Marketing\nBranding • Printing Solutions",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: Colors.white70,
//                   fontSize: 16,
//                   height: 1.7,
//                 ),
//               ),

//               const Spacer(),

//               Text(
//                 "$percentage%",
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),

//               const SizedBox(height: 12),

//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 25),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(20),
//                   child: LinearProgressIndicator(
//                     value: progress,
//                     minHeight: 6,
//                     backgroundColor: Colors.white12,
//                     valueColor: const AlwaysStoppedAnimation(
//                       Color(0xff16C8D8),
//                     ),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 15),

//               const Text(
//                 "Loading...",
//                 style: TextStyle(
//                   color: Colors.white60,
//                   fontSize: 15,
//                 ),
//               ),

//               const SizedBox(height: 25),

//               const Text(
//                 "© 2026 Alrman Advertising",
//                 style: TextStyle(
//                   color: Colors.white38,
//                   fontSize: 12,
//                 ),
//               ),

//               const SizedBox(height: 25),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

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
  // Overall progress (0 -> 1)
  late final AnimationController _progressController;
  late final Animation<double> _progressAnimation;

  // Logo pulse / breathing animation
  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnimation;

  // Logo entrance (scale + fade)
  late final AnimationController _entranceController;
  late final Animation<double> _entranceScale;
  late final Animation<double> _entranceFade;

  // Text fade-in (slightly delayed)
  late final AnimationController _textController;
  late final Animation<double> _textFade;
  late final Animation<Offset> _textSlide;

  // Floating background blobs
  late final AnimationController _bgController;

  int percentage = 0;

  @override
  void initState() {
    super.initState();

    // Logo entrance: pops in with a soft overshoot
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _entranceScale = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.elasticOut,
    );
    _entranceFade = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0, 0.6, curve: Curves.easeOut),
    );

    // Continuous gentle pulse/glow around the logo
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.92, end: 1.08).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Text slides up + fades in after logo appears
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _textFade = CurvedAnimation(parent: _textController, curve: Curves.easeOut);
    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeOutCubic));

    // Slow rotating/floating background blobs for depth
    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();

    // Real progress bar, smooth animated (not stepwise setState spam)
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    );
    _progressAnimation = CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeInOutCubic,
    )..addListener(() {
        setState(() {
          percentage = (_progressAnimation.value * 100).toInt();
        });
      });

    _progressController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _goNext();
      }
    });

    _startSequence();
  }

  Future<void> _startSequence() async {
    _entranceController.forward();
    await Future.delayed(const Duration(milliseconds: 350));
    if (!mounted) return;
    _textController.forward();
    await Future.delayed(const Duration(milliseconds: 150));
    if (!mounted) return;
    _progressController.forward();
  }

  void _goNext() {
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (_, animation, __) => const GetStartedScreen(),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  void dispose() {
    _progressController.dispose();
    _pulseController.dispose();
    _entranceController.dispose();
    _textController.dispose();
    _bgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Base gradient background
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff05111A),
                  Color(0xff0A1D29),
                  Color(0xff07131B),
                ],
              ),
            ),
          ),

          // Floating glowing blobs for a modern "alive" background
          AnimatedBuilder(
            animation: _bgController,
            builder: (context, child) {
              return CustomPaint(
                size: Size.infinite,
                painter: _FloatingBlobsPainter(_bgController.value),
              );
            },
          ),

          SafeArea(
            child: Column(
              children: [
                const Spacer(),

                /// Animated Logo with pulsing glow
                ScaleTransition(
                  scale: _entranceScale,
                  child: FadeTransition(
                    opacity: _entranceFade,
                    child: AnimatedBuilder(
                      animation: _pulseAnimation,
                      builder: (context, child) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            // Outer soft glow, breathing
                            Container(
                              width: 220 * _pulseAnimation.value,
                              height: 220 * _pulseAnimation.value,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xff16C8D8)
                                        .withOpacity(0.22),
                                    blurRadius: 90,
                                    spreadRadius: 15,
                                  ),
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.10),
                                    blurRadius: 60,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                            ),

                            // Thin rotating ring accent
                            RotationTransition(
                              turns: _bgController,
                              child: Container(
                                width: 165,
                                height: 165,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(0xff16C8D8)
                                        .withOpacity(0.35),
                                    width: 1.4,
                                  ),
                                ),
                                child: CustomPaint(
                                  painter: _DashedRingPainter(),
                                ),
                              ),
                            ),

                            // Logo itself
                            Image.asset(
                              "images/assets/Alrmun_logo.png",
                              width: 130,
                              height: 130,
                              fit: BoxFit.contain,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 26),

                /// Title + subtitle, slide + fade in
                FadeTransition(
                  opacity: _textFade,
                  child: SlideTransition(
                    position: _textSlide,
                    child: Column(
                      children: [
                        ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [Colors.white, Color(0xff9FEFF5)],
                          ).createShader(bounds),
                          child: const Text(
                            "ALRMAN ADVERTISING",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          "Creative Design • Digital Marketing\nBranding • Printing Solutions",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                            height: 1.7,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const Spacer(),

                /// Percentage + glowing progress bar
                FadeTransition(
                  opacity: _textFade,
                  child: Column(
                    children: [
                      Text(
                        "$percentage%",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Container(
                          height: 8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white12,
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xff16C8D8)
                                    .withOpacity(0.35),
                                blurRadius: 10,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                return Stack(
                                  children: [
                                    AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 100),
                                      width: constraints.maxWidth *
                                          _progressAnimation.value,
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xff16C8D8),
                                            Color(0xff5EF0E0),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        "Loading...",
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                const Text(
                  "© 2026 Alrman Advertising",
                  style: TextStyle(
                    color: Colors.white38,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 25),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Paints a few soft, slowly drifting glowing blobs in the background
/// to give the splash screen depth and movement.
class _FloatingBlobsPainter extends CustomPainter {
  final double t; // 0 -> 1 looping animation value

  _FloatingBlobsPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final blobs = [
      _Blob(
        colorHex: 0xff16C8D8,
        baseAlignment: const Alignment(-0.8, -0.7),
        radius: 140,
        speed: 1.0,
      ),
      _Blob(
        colorHex: 0xff16C8D8,
        baseAlignment: const Alignment(0.9, 0.6),
        radius: 170,
        speed: 0.6,
      ),
      _Blob(
        colorHex: 0xff5EF0E0,
        baseAlignment: const Alignment(0.7, -0.9),
        radius: 110,
        speed: 1.4,
      ),
    ];

    for (final blob in blobs) {
      final angle = 2 * pi * t * blob.speed;
      final dx = cos(angle) * 30;
      final dy = sin(angle) * 30;

      final center = Offset(
        (blob.baseAlignment.x + 1) / 2 * size.width + dx,
        (blob.baseAlignment.y + 1) / 2 * size.height + dy,
      );

      final paint = Paint()
        ..shader = RadialGradient(
          colors: [
            Color(blob.colorHex).withOpacity(0.10),
            Color(blob.colorHex).withOpacity(0.0),
          ],
        ).createShader(Rect.fromCircle(center: center, radius: blob.radius));

      canvas.drawCircle(center, blob.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _FloatingBlobsPainter oldDelegate) =>
      oldDelegate.t != t;
}

class _Blob {
  final int colorHex;
  final Alignment baseAlignment;
  final double radius;
  final double speed;

  _Blob({
    required this.colorHex,
    required this.baseAlignment,
    required this.radius,
    required this.speed,
  });
}

/// Simple dashed ring drawn around the logo for a subtle tech/premium feel.
class _DashedRingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xff16C8D8).withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6
      ..strokeCap = StrokeCap.round;

    const dashCount = 28;
    const dashWidth = 6.0;
    final radius = size.width / 2;
    final center = Offset(size.width / 2, size.height / 2);

    for (int i = 0; i < dashCount; i++) {
      final startAngle = (2 * pi / dashCount) * i;
      final endAngle = startAngle + (dashWidth / radius);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        endAngle - startAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}