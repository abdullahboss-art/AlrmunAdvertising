import 'package:adverting_app/common/admin_user.dart';
import 'package:flutter/material.dart';
// import 'package:adverting_app/User/Login.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen>
    with TickerProviderStateMixin {
  // Entrance animation for the whole content
  late final AnimationController _entranceController;
  late final Animation<double> _fadeIn;
  late final Animation<Offset> _slideUp;

  // Gentle floating animation for the laptop image
  late final AnimationController _floatController;
  late final Animation<double> _floatAnimation;

  // Slow pulsing glow behind the laptop
  late final AnimationController _glowController;

  @override
  void initState() {
    super.initState();

    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();

    _fadeIn = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOut,
    );

    _slideUp = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOutCubic,
    ));

    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: -8, end: 8).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _floatController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff06131C),
              Color(0xff0A1F2C),
              Color(0xff07131B),
            ],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeIn,
            child: SlideTransition(
              position: _slideUp,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),

                    /// Logo — bigger, no glow/shadow behind it.
                    Image.asset(
                      "images/assets/Alrmun_logo.png",
                      width: 130,
                      height: 130,
                      fit: BoxFit.contain,
                    ),

                    const SizedBox(height: 24),

                    /// Heading
                    const Text(
                      "Creative Design",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        height: 1.15,
                      ),
                    ),

                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Color(0xff16C8D8), Color(0xff9FEFF5)],
                      ).createShader(bounds),
                      child: const Text(
                        "Effective Branding",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          height: 1.15,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      "Transforming ideas into\nimpactful designs",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                        height: 1.5,
                      ),
                    ),

                    /// Laptop Section — clean single glow, no stray boxes.
                    Expanded(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // One soft radial glow, centered behind the laptop,
                          // sized relative to the laptop itself so nothing
                          // pokes out to the sides.
                          AnimatedBuilder(
                            animation: _glowController,
                            builder: (context, child) {
                              final scale =
                                  1.0 + (_glowController.value * 0.06);
                              return Transform.scale(
                                scale: scale,
                                child: Container(
                                  width: size.width * .68,
                                  height: size.width * .68,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: RadialGradient(
                                      colors: [
                                        const Color(0xff16C8D8)
                                            .withOpacity(0.20),
                                        const Color(0xff16C8D8)
                                            .withOpacity(0.0),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),

                          // Floating laptop image
                          AnimatedBuilder(
                            animation: _floatAnimation,
                            builder: (context, child) {
                              return Transform.translate(
                                offset: Offset(0, _floatAnimation.value),
                                child: child,
                              );
                            },
                            child: Hero(
                              tag: "laptop",
                              child: Image.asset(
                                "images/assets/Laptop.png",
                                width: size.width * .72,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),

                          // Soft shadow puddle beneath the laptop for grounding
                          Positioned(
                            bottom: 30,
                            child: Container(
                              width: size.width * .42,
                              height: 16,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                gradient: RadialGradient(
                                  colors: [
                                    Colors.black.withOpacity(0.35),
                                    Colors.black.withOpacity(0.0),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// Button
                    SizedBox(
                      width: double.infinity,
                      height: 58,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const RoleSelectionScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff16C8D8),
                          elevation: 10,
                          shadowColor: const Color(0xff16C8D8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Get Started",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(
                              Icons.arrow_forward_rounded,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
