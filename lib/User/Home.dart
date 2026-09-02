
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

                    if (!context.mounted) {
                      return;
                    }

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
            ] else ...[
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
  // ESTIMATE
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
  // SERVICE DETAIL
  // =========================================================

  void _openServiceDetail(
    Map<String, String> service,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ServiceDetail(
          service: service,
          serviceName: service['title'] ?? '',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // =========================================================
    // SERVICES DISPLAY LOGIC
    // =========================================================

    final displayedServices =
        showAllServices
            ? HomeData.services
            : HomeData.services.take(6).toList();

    // final portfolioProjects =
    //     GalleryData.projects.take(4).toList();

    return Scaffold(
      backgroundColor: HomeWidgets.background,

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
                      stream:
                          FirebaseAuth
                              .instance
                              .authStateChanges(),

                      builder: (context, snapshot) {
                        final User? user = snapshot.data;

                        final bool isLoggedIn = user != null;

                        return GestureDetector(
                          onTap: () =>
                              _showProfileDialog(user),

                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: HomeWidgets.accent
                                    .withOpacity(.35),
                                width: 1,
                              ),
                            ),

                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor:
                                  Colors.grey.shade800,

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

              const SizedBox(height: 8),

              // =================================================
              // BRANDING
              // =================================================

              Padding(
                padding: const EdgeInsets.symmetric(
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
                        fontWeight: FontWeight.w800,
                        letterSpacing: .8,
                      ),
                    ),

                    const SizedBox(height: 2),

                    Text(
                      "Creative Ideas. Powerful Advertising.",
                      style: GoogleFonts.poppins(
                        color: HomeWidgets.accent,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        letterSpacing: .3,
                      ),
                    ),

                    const SizedBox(height: 18),

                    // ESTIMATE BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 54,

                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF16C8D8),
                              Color(0xFF0EA5B7),
                            ],
                          ),

                          borderRadius:
                              BorderRadius.circular(15),

                          boxShadow: [
                            BoxShadow(
                              color: HomeWidgets.accent
                                  .withOpacity(.20),
                              blurRadius: 14,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),

                        child: Material(
                          color: Colors.transparent,

                          child: InkWell(
                            onTap: _openEstimate,

                            borderRadius:
                                BorderRadius.circular(15),

                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.center,

                              children: [
                                const Icon(
                                  Icons
                                      .request_quote_rounded,
                                  color: Colors.black,
                                  size: 21,
                                ),

                                const SizedBox(width: 9),

                                Text(
                                  "Get Your Free Estimate",
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight:
                                        FontWeight.w700,
                                  ),
                                ),

                                const SizedBox(width: 8),

                                const Icon(
                                  Icons
                                      .arrow_forward_rounded,
                                  color: Colors.black,
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
              // SERVICES HEADER
              // =================================================

             HomeWidgets.sectionHeader(
  title: "Services",
  subtitle: "Everything your brand needs",
  buttonText: showAllServices ? "Show Less" : "See All",
  showLess: showAllServices,
  onButtonTap: () {
    setState(() {
      showAllServices = !showAllServices;
    });
  },
),

              const SizedBox(height: 14),

              // =================================================
              // SERVICES
              // =================================================

              HomeWidgets.servicesGrid(
                services: displayedServices,
                onTap: _openServiceDetail,
              ),

              // HomeWidgets.portfolioIntro(),

              // const SizedBox(height: 14),

              // HomeWidgets.portfolioGrid(
              //   projects: portfolioProjects,
              //   onTap:
              //       _openPortfolioProject,
              // ),

              const SizedBox(height: 35),
            ],
          ),
        ),
      ),
    );
  }
}

