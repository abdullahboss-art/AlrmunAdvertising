import 'package:adverting_app/User/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  bool loading = false;
  bool obscurePassword = true;
  bool agreedToTerms = false;

  // Simple built-in country code list — no extra package required.
  final List<Map<String, String>> _countryCodes = const [
    {"flag": "🇵🇰", "code": "+92", "name": "Pakistan"},
    {"flag": "🇮🇳", "code": "+91", "name": "India"},
    {"flag": "🇺🇸", "code": "+1", "name": "United States"},
    {"flag": "🇬🇧", "code": "+44", "name": "United Kingdom"},
    {"flag": "🇦🇪", "code": "+971", "name": "UAE"},
    {"flag": "🇸🇦", "code": "+966", "name": "Saudi Arabia"},
  ];
  late Map<String, String> _selectedCountry = _countryCodes[0];

  void showAlertDialog({
    required String title,
    required String message,
    bool isSuccess = false,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.grey.shade900,
          title: Row(
            children: [
              Icon(
                isSuccess ? Icons.check_circle : Icons.error,
                color: isSuccess ? Colors.teal : Colors.red,
                size: 30,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          content: Text(
            message,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
              height: 1.5,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (isSuccess) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginPage()),
                  );
                }
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.teal,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: const Text(
                "OK",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  void _pickCountryCode() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey.shade900,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _countryCodes.length,
            itemBuilder: (context, index) {
              final country = _countryCodes[index];
              return ListTile(
                leading: Text(country["flag"]!,
                    style: const TextStyle(fontSize: 22)),
                title: Text(
                  "${country["name"]} (${country["code"]})",
                  style: const TextStyle(color: Colors.white),
                ),
                onTap: () {
                  setState(() => _selectedCountry = country);
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }

  Future<void> signupUser() async {
    if (!_formKey.currentState!.validate()) return;

    if (!agreedToTerms) {
      showAlertDialog(
        title: "Almost there!",
        message: "Please agree to the Terms & Conditions and Privacy Policy to continue.",
        isSuccess: false,
      );
      return;
    }

    try {
      setState(() => loading = true);

      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      await userCredential.user?.updateDisplayName(fullNameController.text.trim());
      await userCredential.user?.reload();

      // 👉 If you're saving extra profile data (full name, phone) to
      // Firestore/Realtime DB, do it here using userCredential.user!.uid,
      // e.g. fullNameController.text.trim() and
      // "${_selectedCountry["code"]}${phoneController.text.trim()}".

      setState(() => loading = false);

      if (mounted) {
        showAlertDialog(
          title: "Account Created!",
          message: "Welcome, ${fullNameController.text.trim()} 🎉",
          isSuccess: true,
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() => loading = false);

      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = "An account already exists with this email.\nPlease login instead.";
          break;
        case 'invalid-email':
          errorMessage = "Email address is not valid.";
          break;
        case 'weak-password':
          errorMessage = "Password is too weak.\nUse at least 6 characters.";
          break;
        default:
          errorMessage = e.message ?? "Signup failed. Please try again.";
      }

      if (mounted) {
        showAlertDialog(title: "Signup Failed", message: errorMessage, isSuccess: false);
      }
    } catch (e) {
      setState(() => loading = false);
      if (mounted) {
        showAlertDialog(
          title: "Error",
          message: "Something went wrong.\nPlease try again later.",
          isSuccess: false,
        );
      }
    }
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  InputDecoration _fieldDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white38, fontSize: 14),
      prefixIcon: Icon(icon, color: Colors.white38, size: 20),
      filled: true,
      fillColor: Colors.grey.shade900,
      contentPadding: const EdgeInsets.symmetric(vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.white12),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.white12),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.teal),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 20),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  padding: EdgeInsets.zero,
                  alignment: Alignment.centerLeft,
                ),
                const SizedBox(height: 8),
                const Text(
                  "Create Account",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  "Let's get started",
                  style: TextStyle(color: Colors.white54, fontSize: 15),
                ),

                _label("Full Name"),
                TextFormField(
                  controller: fullNameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: _fieldDecoration("Enter full name", Icons.person_outline),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter your full name";
                    }
                    return null;
                  },
                ),

                _label("Email Address"),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(color: Colors.white),
                  decoration: _fieldDecoration("Enter email address", Icons.email_outlined),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter email";
                    }
                    if (!value.contains("@")) {
                      return "Enter valid email";
                    }
                    return null;
                  },
                ),

                _label("Phone Number"),
                Row(
                  children: [
                    InkWell(
                      onTap: _pickCountryCode,
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        height: 54,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade900,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(_selectedCountry["flag"]!,
                                style: const TextStyle(fontSize: 18)),
                            const SizedBox(width: 6),
                            Text(
                              _selectedCountry["code"]!,
                              style: const TextStyle(color: Colors.white, fontSize: 14),
                            ),
                            const Icon(Icons.keyboard_arrow_down,
                                color: Colors.white54, size: 18),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        style: const TextStyle(color: Colors.white),
                        decoration: _fieldDecoration("Enter phone number", Icons.phone_outlined),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter phone number";
                          }
                          if (value.trim().length < 7) {
                            return "Enter a valid phone number";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),

                _label("Password"),
                TextFormField(
                  controller: passwordController,
                  obscureText: obscurePassword,
                  style: const TextStyle(color: Colors.white),
                  decoration: _fieldDecoration("Enter password", Icons.lock_outline).copyWith(
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscurePassword ? Icons.visibility_off : Icons.visibility,
                        color: Colors.white38,
                        size: 20,
                      ),
                      onPressed: () => setState(() => obscurePassword = !obscurePassword),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter password";
                    }
                    if (value.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 24,
                      width: 24,
                      child: Checkbox(
                        value: agreedToTerms,
                        activeColor: Colors.teal,
                        checkColor: Colors.black,
                        side: const BorderSide(color: Colors.white38),
                        onChanged: (value) =>
                            setState(() => agreedToTerms = value ?? false),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: RichText(
                          text: const TextSpan(
                            style: TextStyle(color: Colors.white54, fontSize: 13, height: 1.4),
                            children: [
                              TextSpan(text: "I agree to the "),
                              TextSpan(
                                text: "Terms & Conditions",
                                style: TextStyle(color: Colors.teal, fontWeight: FontWeight.w600),
                              ),
                              TextSpan(text: "\nand "),
                              TextSpan(
                                text: "Privacy Policy",
                                style: TextStyle(color: Colors.teal, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 26),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: loading ? null : signupUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: loading
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.5,
                            ),
                          )
                        : const Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 20),
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: "Already have an account?  ",
                            style: TextStyle(color: Colors.white54, fontSize: 14),
                          ),
                          TextSpan(
                            text: "Login",
                            style: TextStyle(
                              color: Colors.teal,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}