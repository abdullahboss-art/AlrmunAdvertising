import 'package:adverting_app/admin/adminDashboard.dart';
import 'package:flutter/material.dart';


class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final _formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;
  bool obscurePassword = true;

  Future<void> loginAdmin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (!mounted) return;

    if (username == "admin" && password == "admin") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const AdminHomePage(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xFFE53935),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: const Text(
            "Invalid username or password",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF06131A),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 30,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ------------------------------------------------
                  // HEADER
                  // ------------------------------------------------
                  const Text(
                    "Admin Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    "Login to access the admin dashboard",
                    style: TextStyle(
                      color: Color(0xFF71808C),
                      fontSize: 11.5,
                    ),
                  ),

                  const SizedBox(height: 28),

                  // ------------------------------------------------
                  // USERNAME LABEL
                  // ------------------------------------------------
                  const Text(
                    "Username",
                    style: TextStyle(
                      color: Color(0xFFDCE4E8),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // ------------------------------------------------
                  // USERNAME FIELD
                  // ------------------------------------------------
                  TextFormField(
                    controller: usernameController,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                    cursorColor: const Color(0xFF16B7C9),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: "Enter username",
                      hintStyle: const TextStyle(
                        color: Color(0xFF53636E),
                        fontSize: 11.5,
                      ),
                      prefixIcon: const Icon(
                        Icons.person_outline_rounded,
                        color: Color(0xFF71808C),
                        size: 17,
                      ),
                      filled: true,
                      fillColor: const Color(0xFF0B1C24),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 13,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color(0xFF1A303A),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color(0xFF1A303A),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color(0xFF16B7C9),
                          width: 1.2,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Colors.redAccent,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Username is required";
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 18),

                  // ------------------------------------------------
                  // PASSWORD LABEL
                  // ------------------------------------------------
                  const Text(
                    "Password",
                    style: TextStyle(
                      color: Color(0xFFDCE4E8),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // ------------------------------------------------
                  // PASSWORD FIELD
                  // ------------------------------------------------
                  TextFormField(
                    controller: passwordController,
                    obscureText: obscurePassword,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                    cursorColor: const Color(0xFF16B7C9),
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => loginAdmin(),
                    decoration: InputDecoration(
                      hintText: "Enter password",
                      hintStyle: const TextStyle(
                        color: Color(0xFF53636E),
                        fontSize: 11.5,
                      ),
                      prefixIcon: const Icon(
                        Icons.lock_outline_rounded,
                        color: Color(0xFF71808C),
                        size: 17,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscurePassword = !obscurePassword;
                          });
                        },
                        icon: Icon(
                          obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: const Color(0xFF71808C),
                          size: 17,
                        ),
                      ),
                      filled: true,
                      fillColor: const Color(0xFF0B1C24),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 13,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color(0xFF1A303A),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color(0xFF1A303A),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color(0xFF16B7C9),
                          width: 1.2,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Colors.redAccent,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Password is required";
                      }

                      return null;
                    },
                  ),

                  // ------------------------------------------------
                  // FORGOT PASSWORD
                  // ------------------------------------------------
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // Forgot password action
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.only(
                          top: 4,
                          bottom: 4,
                        ),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: Color(0xFF16B7C9),
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  // ------------------------------------------------
                  // LOGIN BUTTON
                  // ------------------------------------------------
                  SizedBox(
                    width: double.infinity,
                    height: 42,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : loginAdmin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF16B7C9),
                        disabledBackgroundColor:
                            const Color(0xFF16B7C9).withOpacity(0.5),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      child: isLoading
                          ? const SizedBox(
                              height: 17,
                              width: 17,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(
                                  Color(0xFF05242A),
                                ),
                              ),
                            )
                          : const Text(
                              "Login",
                              style: TextStyle(
                                color: Color(0xFF05242A),
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}