import 'package:flutter/material.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF06131A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1C24),
        elevation: 0,
        title: const Text(
          'Admin Dashboard',
          style: TextStyle(
            color: Color(0xFFEAF4F6),
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: const Center(
        child: Text(
          'Admin Dashboard',
          style: TextStyle(
            color: Color(0xFFEAF4F6),
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}