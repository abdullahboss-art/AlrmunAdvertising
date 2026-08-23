import 'package:adverting_app/User/Home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'Home.dart'
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        elevation: 0,
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------------- User Info (real-time) ----------------
              StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  final User? user = snapshot.data;
                  final bool isLoggedIn = user != null;

                  final String name = isLoggedIn
                      ? (user.displayName ?? "User")
                      : "Guest";
                  final String contact = isLoggedIn
                      ? (user.email ?? user.phoneNumber ?? "Not Available")
                      : "Not signed in";
                  final String? photoUrl = user?.photoURL;

                  return Row(
                    children: [
                      CircleAvatar(
                        radius: 32,
                        backgroundColor: Colors.grey.shade800,
                        backgroundImage: (photoUrl != null && photoUrl.isNotEmpty)
                            ? NetworkImage(photoUrl)
                            : null,
                        child: (photoUrl == null || photoUrl.isEmpty)
                            ? const Icon(Icons.person, size: 34, color: Colors.white)
                            : null,
                      ),
                      const SizedBox(width: 14),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                            style: const TextStyle(
                              color: Colors.white60,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 28),

              // ---------------- Menu List ----------------
              _ProfileTile(
                icon: Icons.home_outlined,
                title: "Home",
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              _ProfileTile(
                icon: Icons.payments_outlined,
                title: "My Payment",
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (_) => const MyPaymentPage()));
                },
              ),
              _ProfileTile(
                icon: Icons.notifications_outlined,
                title: "Notification",
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationPage()));
                },
              ),
              _ProfileTile(
                icon: Icons.settings_outlined,
                title: "Setting",
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
                },
              ),
              _ProfileTile(
                icon: Icons.info_outline,
                title: "About Us",
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutUsPage()));
                },
              ),
              _ProfileTile(
                icon: Icons.logout,
                title: "Logout",
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  if (context.mounted) Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------- Reusable list tile ----------------
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
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade800, width: 1),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white70, size: 22),
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
            const Icon(Icons.arrow_forward_ios, color: Colors.white38, size: 14),
          ],
        ),
      ),
    );
  }
}