  import 'package:adverting_app/User/Estimated.dart';
  import 'package:flutter/material.dart';
  import 'package:firebase_auth/firebase_auth.dart';
  import 'package:google_fonts/google_fonts.dart';
  import 'Service.dart';
  import 'package:adverting_app/User/Login.dart';

  class HomeScreen extends StatefulWidget {
    const HomeScreen({super.key});

    @override
    State<HomeScreen> createState() => _HomeScreenState();
  }

  class _HomeScreenState extends State<HomeScreen> {
    // Services list
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
    ];

    // ---------------- Profile Dialog ----------------
    void _showProfileDialog(User? user) {
      final bool isLoggedIn = user != null;

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          backgroundColor: const Color.fromARGB(255, 11, 17, 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: Text(
            isLoggedIn ? "Profile" : "You're not signed in",
            style: const TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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

              if (isLoggedIn) ...[
                Text(
                  "Name : ${user.displayName ?? "No Name"}",
                  style: const TextStyle(color: Colors.white),
                ),

                const SizedBox(height: 8),

                Text(
                  "Email : ${user.email ?? "Not Available"}",
                  style: const TextStyle(color: Colors.white70),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
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
                    child: const Text(
                      "Logout",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ] else ...[
                const Text(
                  "Login to see your profile, orders and more.",
                  style: TextStyle(color: Colors.white70),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                    ),
                    onPressed: () {
                      Navigator.pop(context);

                      // Login screen yahan add kar sakte ho
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      );
    }

    // ---------------- Direct Estimate Page ----------------
    void _openEstimate() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AdvertisingEstimatePage(),
        ),
      );
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: const Color(0xFF0D0D0D),

        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // ---------------- Top Bar: Logo Left + Profile Right ----------------
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [

                      // Logo - Left Corner
                      Image.asset(
                        'images/assets/Alrmun_logo.png',
                        height: 64,
                        fit: BoxFit.contain,
                      ),

                      const Spacer(),

                      // Profile - Right Side
                      StreamBuilder<User?>(
                        stream: FirebaseAuth.instance.authStateChanges(),
                        builder: (context, snapshot) {
                          final User? user = snapshot.data;
                          final bool isLoggedIn = user != null;

                          return GestureDetector(
                            onTap: () => _showProfileDialog(user),
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.grey.shade800,

                              backgroundImage:
                                  (isLoggedIn &&
                                          user.photoURL != null &&
                                          user.photoURL!.isNotEmpty)
                                      ? NetworkImage(user.photoURL!)
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
                          );
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 8),

                // ---------------- Our Services ----------------
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Our Services",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ServicesPage(),
                            ),
                          );
                        },    
                        child: const Text(
                          "View All",
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // ---------------- Services Grid ----------------
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: services.length,

                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      childAspectRatio: 0.85,
                    ),

                    itemBuilder: (context, index) {
                      final service = services[index];

                      return InkWell(
                        borderRadius: BorderRadius.circular(16),

                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ServicesPage(),
                            ),
                          );
                        },

                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A1A1A),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.grey.shade800,
                              width: 1,
                            ),
                          ),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              // Service Image
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  ),

                                  child: Image.asset(
                                    service['image']!,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                              // Service Title
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                                child: Text(
                                  service['title']!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
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

                const SizedBox(height: 28),

                // ---------------- Get Estimate Button ----------------

                const SizedBox(height: 18),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: StatefulBuilder(
                    builder: (context, setState) {
                      bool isHovered = false;

                      return MouseRegion(
                        cursor: SystemMouseCursors.click,

                        onEnter: (_) {
                          setState(() {
                            isHovered = true;
                          });
                        },

                        onExit: (_) {
                          setState(() {
                            isHovered = false;
                          });
                        },

                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,

                          width: double.infinity,
                          height: 62,

                          decoration: BoxDecoration(
                            color: isHovered
                                ? const Color(0xFF16C8D8)
                                : Colors.black,

                            borderRadius: BorderRadius.circular(16),

                            border: Border.all(
                              color: const Color(0xFF16C8D8),
                              width: 1.2,
                            ),

                            boxShadow: isHovered
                                ? [
                                    BoxShadow(
                                      color: const Color(0xFF16C8D8)
                                          .withOpacity(0.35),
                                      blurRadius: 20,
                                      spreadRadius: 1,
                                      offset: const Offset(0, 5),
                                    ),
                                  ]
                                : [],
                          ),

                          child: Material(
                            color: Colors.transparent,

                            child: InkWell(
                              // DIRECT PAGE OPEN
                              onTap: _openEstimate,

                              borderRadius: BorderRadius.circular(16),

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  Icon(
                                    Icons.request_quote_rounded,
                                    size: 22,
                                    color: isHovered
                                        ? Colors.black
                                        : Colors.white,
                                  ),

                                  const SizedBox(width: 10),

                                  Text(
                                    "Get Your Free Estimate",
                                    style: TextStyle(
                                      color: isHovered
                                          ? Colors.black
                                          : Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.2,
                                    ),
                                  ),

                                  const SizedBox(width: 10),

                                  Icon(
                                    Icons.arrow_forward_rounded,
                                    size: 21,
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

                const SizedBox(height: 35),
              ],
            ),
          ),
        ),
      );
    }
  }