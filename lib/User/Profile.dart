import 'package:adverting_app/User/AboutUs.dart';
import 'package:adverting_app/User/Login.dart';
import 'package:adverting_app/User/Setting.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatelessWidget {
  final ValueChanged<int>? onTabChange;

  const ProfilePage({
    super.key,
    this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF07131B),

      appBar: AppBar(
        backgroundColor: const Color(0xFF07131B),
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =====================================================
              // USER INFO
              // =====================================================

              StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  final User? user = snapshot.data;
                  final bool isLoggedIn = user != null;

                  final String name = isLoggedIn
                      ? (user.displayName ?? "User")
                      : "Guest";

                  final String contact = isLoggedIn
                      ? (user.email ??
                          user.phoneNumber ??
                          "Not Available")
                      : "Not signed in";

                  final String? photoUrl = user?.photoURL;

                  return Row(
                    children: [
                      CircleAvatar(
                        radius: 32,
                        backgroundColor: Colors.grey.shade800,
                        backgroundImage:
                            photoUrl != null &&
                                    photoUrl.isNotEmpty
                                ? NetworkImage(photoUrl)
                                : null,
                        child:
                            photoUrl == null ||
                                    photoUrl.isEmpty
                                ? const Icon(
                                    Icons.person,
                                    size: 34,
                                    color: Colors.white,
                                  )
                                : null,
                      ),

                      const SizedBox(width: 14),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            const SizedBox(height: 4),

                            Text(
                              contact,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white60,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 28),

              // =====================================================
              // HOME
              // =====================================================

              _ProfileTile(
                icon: Icons.home_outlined,
                title: "Home",
                onTap: () {
                  onTabChange?.call(0);
                },
              ),

             

              _ProfileTile(
                icon: Icons.photo_library_outlined,
                title: "Gallery",
                onTap: () {
                  onTabChange?.call(2);
                },
              ),

              // =====================================================
              // SETTINGS
              // =====================================================

              _ProfileTile(
                icon: Icons.settings_outlined,
                title: "Setting",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SettingsPage(),
                    ),
                  );
                },
              ),

              // =====================================================
              // ABOUT US
              // =====================================================

              _ProfileTile(
                icon: Icons.info_outline,
                title: "About Us",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AboutUsPage(),
                    ),
                  );
                },
              ),

              // =====================================================
              // LOGOUT
              // =====================================================

              _ProfileTile(
  icon: Icons.logout_rounded,
  title: "Logout",
  onTap: () async {
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
),
            ],
          ),
        ),
      ),
    );
  }
}

// =========================================================
// PROFILE TILE
// =========================================================

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ProfileTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF0D1B24),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Colors.white10,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: const Color(0xFF16C8D8),
              size: 22,
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white38,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }
}