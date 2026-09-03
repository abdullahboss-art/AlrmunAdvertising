import 'package:adverting_app/User/Contacthelp.dart';
import 'package:adverting_app/User/Home.dart';
import 'package:adverting_app/User/contactwiget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  // =========================================================
  // COLORS
  // =========================================================

  static const Color background = Color(0xFF0B0F19);
  static const Color card = Color(0xFF171B24);
  static const Color gold = Color(0xFF36B6BD);

  // =========================================================
  // FORM CONTROLLERS
  // =========================================================

  final TextEditingController nameController =
      TextEditingController();

  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController phoneController =
      TextEditingController();

  final TextEditingController subjectController =
      TextEditingController();

  final TextEditingController messageController =
      TextEditingController();

  // =========================================================
  // FORM STATES
  // =========================================================

  bool isSending = false;
  bool isSubmitted = false;

  // =========================================================
  // VALIDATION ERRORS
  // =========================================================

  String? nameError;
  String? emailError;
  String? phoneError;
  String? subjectError;
  String? messageError;

  // =========================================================
  // DISPOSE
  // =========================================================

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    subjectController.dispose();
    messageController.dispose();

    super.dispose();
  }

  // =========================================================
  // SUBMIT FORM
  // =========================================================

  Future<void> submitForm() async {
    // Clear old errors
    setState(() {
      nameError = null;
      emailError = null;
      phoneError = null;
      subjectError = null;
      messageError = null;
      isSubmitted = false;
    });

    final String name = nameController.text.trim();
    final String email = emailController.text.trim();
    final String phone = phoneController.text.trim();
    final String subject = subjectController.text.trim();
    final String message = messageController.text.trim();

    bool hasError = false;

    // =========================================================
    // NAME VALIDATION
    // =========================================================

    if (name.isEmpty) {
      nameError = 'Please enter your name.';
      hasError = true;
    } else if (name.length < 3) {
      nameError =
          'Name must be at least 3 characters.';
      hasError = true;
    } else if (RegExp(r'[0-9]').hasMatch(name)) {
      nameError =
          'Name should contain letters only.';
      hasError = true;
    }

    // =========================================================
    // EMAIL VALIDATION
    // =========================================================

    if (email.isEmpty) {
      emailError = 'Please enter your email.';
      hasError = true;
    } else if (!RegExp(
      r'^[\w\.-]+@[\w\.-]+\.\w+$',
    ).hasMatch(email)) {
      emailError =
          'Please enter a valid email address.';
      hasError = true;
    }

    // =========================================================
    // PHONE VALIDATION
    // =========================================================

    if (phone.isEmpty) {
      phoneError =
          'Please enter your phone number.';
      hasError = true;
    } else {
      final String phoneDigits =
          phone.replaceAll(RegExp(r'[^0-9]'), '');

      if (phoneDigits.length < 7) {
        phoneError =
            'Please enter a valid phone number.';
        hasError = true;
      } else if (phoneDigits.length > 15) {
        phoneError =
            'Phone number is too long.';
        hasError = true;
      }
    }

    // =========================================================
    // SUBJECT VALIDATION
    // =========================================================

    if (subject.isEmpty) {
      subjectError = 'Please enter a subject.';
      hasError = true;
    } else if (subject.length < 3) {
      subjectError =
          'Subject must be at least 3 characters.';
      hasError = true;
    }

    // =========================================================
    // MESSAGE VALIDATION
    // =========================================================

    if (message.isEmpty) {
      messageError =
          'Please enter your message.';
      hasError = true;
    } else if (message.length < 10) {
      messageError =
          'Message must be at least 10 characters.';
      hasError = true;
    }

    // Update validation errors
    setState(() {});

    // Stop if validation failed
    if (hasError) {
      return;
    }

    // =========================================================
    // START SENDING
    // =========================================================

    setState(() {
      isSending = true;
    });

    try {
      // =======================================================
      // SAVE TO FIRESTORE
      // =======================================================

      await FirebaseFirestore.instance
          .collection('contact_messages')
          .add({
        'name': name,
        'email': email,
        'phone': phone,
        'subject': subject,
        'message': message,
        'status': 'new',
        'createdAt':
            FieldValue.serverTimestamp(),
      });

      if (!mounted) return;

      // =======================================================
      // CLEAR FORM
      // =======================================================

      nameController.clear();
      emailController.clear();
      phoneController.clear();
      subjectController.clear();
      messageController.clear();

      // =======================================================
      // SUCCESS
      // =======================================================

      setState(() {
        isSending = false;
        isSubmitted = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Message submitted successfully!',
          ),
          behavior:
              SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isSending = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Failed to submit message. Please try again.',
          ),
          behavior:
              SnackBarBehavior.floating,
        ),
      );
    }
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,

      body: SafeArea(
        child: SingleChildScrollView(
          physics:
              const BouncingScrollPhysics(),

          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              16,
              12,
              16,
              30,
            ),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                // =====================================================
                // TOP BAR
                // =====================================================

              Row(
  children: [

  



    Image.asset(
      'images/assets/Alrmun_logo.png',
      width: 112,
      height: 70,
      fit: BoxFit.contain,
    ),

    const Spacer(),

    const SizedBox(
      width: 46,
    ),
  ],
),

const SizedBox(height: 24),

// HEADER
                Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [

                          RichText(
                            text:
                                const TextSpan(
                              children: [

                                TextSpan(
                                  text:
                                      'CONTACT ',
                                  style:
                                      TextStyle(
                                    color:
                                        Colors.white,
                                    fontSize: 34,
                                    fontWeight:
                                        FontWeight.w900,
                                    letterSpacing:
                                        -1,
                                  ),
                                ),

                                TextSpan(
                                  text: 'US',
                                  style:
                                      TextStyle(
                                    color: gold,
                                    fontSize: 34,
                                    fontWeight:
                                        FontWeight.w900,
                                    letterSpacing:
                                        -1,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(
                              height: 10),

                          Container(
                            width: 78,
                            height: 3,

                            decoration:
                                BoxDecoration(
                              color: gold,
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                          10),
                            ),
                          ),

                          const SizedBox(
                              height: 14),

                          const Text(
                            "We're here to help and answer any\n"
                            "questions you may have.",

                            style: TextStyle(
                              color:
                                  Colors.white60,
                              fontSize: 14,
                              height: 1.55,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      width: 48,
                      height: 48,

                      decoration:
                          BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(
                                14),

                        border: Border.all(
                          color:
                              gold.withOpacity(
                                  0.45),
                        ),

                        color:
                            const Color(
                                0xFF141922),
                      ),

                      child: const Icon(
                        Icons
                            .headset_mic_rounded,
                        color: gold,
                        size: 25,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                // =====================================================
                // CONTACT CARDS
                // =====================================================

                Row(
                  children: [

                    Expanded(
                      child:
                          ContactWidgets
                              .contactCard(
                        icon:
                            Icons.phone_rounded,
                        title: 'CALL US',
                        value:
                            ContactHelpers
                                .phone,
                        iconColor: gold,
                        onTap:
                            ContactHelpers
                                .callUs,
                      ),
                    ),

                    const SizedBox(width: 8),

                    Expanded(
                      child:
                          ContactWidgets
                              .contactCard(
                        icon:
                            Icons.email_rounded,
                        title: 'EMAIL US',
                        value:
                            ContactHelpers
                                .email,
                        iconColor: gold,
                        onTap:
                            ContactHelpers
                                .emailUs,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // =====================================================
                // LOCATION + WEBSITE
                // =====================================================

                Row(
                  children: [

                    Expanded(
                      child:
                          ContactWidgets
                              .contactCard(
                        icon: Icons
                            .location_on_rounded,
                        title: 'LOCATION',
                        value:
                            'Dubai, UAE',
                        iconColor: gold,
                        onTap:
                            ContactHelpers
                                .openLocation,
                      ),
                    ),

                    const SizedBox(width: 8),

                    Expanded(
                      child:
                          ContactWidgets
                              .contactCard(
                        icon: Icons
                            .language_rounded,
                        title: 'WEBSITE',
                        value:
                            'alrmanadvertising.com',
                        iconColor: gold,
                        onTap:
                            ContactHelpers
                                .openWebsite,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // =====================================================
                // SEND MESSAGE CARD
                // =====================================================

                Container(
                  width: double.infinity,

                  padding:
                      const EdgeInsets.fromLTRB(
                    18,
                    20,
                    18,
                    18,
                  ),

                  decoration:
                      BoxDecoration(
                    color: card,
                    borderRadius:
                        BorderRadius.circular(
                            18),
                    border: Border.all(
                      color: Colors.white
                          .withOpacity(0.08),
                    ),
                  ),

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      RichText(
                        text:
                            const TextSpan(
                          children: [

                            TextSpan(
                              text:
                                  'SEND US A ',
                              style:
                                  TextStyle(
                                color:
                                    Colors.white,
                                fontSize: 16,
                                fontWeight:
                                    FontWeight
                                        .w800,
                              ),
                            ),

                            TextSpan(
                              text: 'MESSAGE',
                              style:
                                  TextStyle(
                                color: gold,
                                fontSize: 16,
                                fontWeight:
                                    FontWeight
                                        .w800,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 8),

                      Container(
                        width: 30,
                        height: 2,
                        color: gold,
                      ),

                      const SizedBox(
                          height: 17),

                      // =================================================
                      // NAME + EMAIL
                      // =================================================

                      Row(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,

                        children: [

                          Expanded(
                            child:
                                ContactWidgets
                                    .inputField(
                              controller:
                                  nameController,
                              hint: 'Your Name',
                              icon: Icons
                                  .person_outline_rounded,
                              errorText:
                                  nameError,
                            ),
                          ),

                          const SizedBox(
                              width: 8),

                          Expanded(
                            child:
                                ContactWidgets
                                    .inputField(
                              controller:
                                  emailController,
                              hint: 'Your Email',
                              icon: Icons
                                  .email_outlined,
                              keyboardType:
                                  TextInputType
                                      .emailAddress,
                              errorText:
                                  emailError,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      // =================================================
                      // PHONE
                      // =================================================

                      ContactWidgets.inputField(
                        controller:
                            phoneController,
                        hint: 'Phone Number',
                        icon:
                            Icons.phone_outlined,
                        keyboardType:
                            TextInputType.phone,
                        errorText: phoneError,
                      ),

                      const SizedBox(height: 8),

                      // =================================================
                      // SUBJECT
                      // =================================================

                      ContactWidgets.inputField(
                        controller:
                            subjectController,
                        hint: 'Subject',
                        icon:
                            Icons.subject_rounded,
                        errorText:
                            subjectError,
                      ),

                      const SizedBox(height: 8),

                      // =================================================
                      // MESSAGE
                      // =================================================

                      ContactWidgets.inputField(
                        controller:
                            messageController,
                        hint: 'Your Message',
                        icon:
                            Icons.edit_outlined,
                        maxLines: 4,
                        errorText:
                            messageError,
                      ),

                      const SizedBox(height: 12),

                      // =================================================
                      // SEND BUTTON
                      // =================================================

                      SizedBox(
                        width: double.infinity,
                        height: 48,

                        child:
                            ElevatedButton.icon(
                          onPressed:
                              isSending
                                  ? null
                                  : submitForm,

                          icon: isSending
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child:
                                      CircularProgressIndicator(
                                    strokeWidth:
                                        2,
                                    color:
                                        Colors.black,
                                  ),
                                )
                              : const Icon(
                                  Icons
                                      .send_rounded,
                                  color:
                                      Colors.black,
                                  size: 19,
                                ),

                          label: Text(
                            isSending
                                ? 'SENDING...'
                                : 'SEND MESSAGE',

                            style:
                                const TextStyle(
                              color:
                                  Colors.black,
                              fontSize: 13,
                              fontWeight:
                                  FontWeight.w800,
                            ),
                          ),

                          style:
                              ElevatedButton
                                  .styleFrom(
                            backgroundColor:
                                gold,

                            disabledBackgroundColor:
                                gold,

                            elevation: 0,

                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                          12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // =====================================================
                // THANK YOU MESSAGE
                // =====================================================

                if (isSubmitted) ...[
                  const SizedBox(height: 12),

                  Container(
                    width: double.infinity,

                    padding:
                        const EdgeInsets.all(15),

                    decoration:
                        BoxDecoration(
                      color:
                          const Color(
                              0xFF102A2D),

                      borderRadius:
                          BorderRadius.circular(
                              16),

                      border: Border.all(
                        color:
                            gold.withOpacity(
                                0.35),
                      ),
                    ),

                    child: Row(
                      children: [

                        Container(
                          width: 42,
                          height: 42,

                          decoration:
                              BoxDecoration(
                            shape:
                                BoxShape.circle,
                            color:
                                gold.withOpacity(
                                    0.15),
                          ),

                          child: const Icon(
                            Icons.check_rounded,
                            color: gold,
                            size: 25,
                          ),
                        ),

                        const SizedBox(
                            width: 12),

                        const Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,

                            children: [

                              Text(
                                'Thank You for Your Message!',
                                style:
                                    TextStyle(
                                  color:
                                      Colors.white,
                                  fontSize: 14,
                                  fontWeight:
                                      FontWeight
                                          .w800,
                                ),
                              ),

                              SizedBox(height: 4),

                              Text(
                                'Your message has been received successfully. '
                                'Our team will get back to you soon.',
                                style:
                                    TextStyle(
                                  color:
                                      Colors.white60,
                                  fontSize: 12,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                const SizedBox(height: 12),

                // =====================================================
                // FEEDBACK CARD
                // =====================================================

                Container(
                  width: double.infinity,

                  padding:
                      const EdgeInsets.all(16),

                  decoration:
                      BoxDecoration(
                    color: card,

                    borderRadius:
                        BorderRadius.circular(
                            17),

                    border: Border.all(
                      color: Colors.white
                          .withOpacity(0.08),
                    ),
                  ),

                  child: Row(
                    children: [

                      Container(
                        width: 48,
                        height: 48,

                        decoration:
                            BoxDecoration(
                          shape:
                              BoxShape.circle,

                          border:
                              Border.all(
                            color:
                                gold.withOpacity(
                                    0.6),
                          ),
                        ),

                        child: const Icon(
                          Icons
                              .verified_rounded,
                          color: gold,
                          size: 27,
                        ),
                      ),

                      const SizedBox(
                          width: 14),

                      const Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,

                          children: [

                            Text(
                              'We value your feedback!',
                              style:
                                  TextStyle(
                                color:
                                    Colors.white,
                                fontSize: 14,
                                fontWeight:
                                    FontWeight
                                        .w800,
                              ),
                            ),

                            SizedBox(height: 4),

                            Text(
                              'Our team will get back to you\n'
                              'as soon as possible.',
                              style:
                                  TextStyle(
                                color:
                                    Colors.white54,
                                fontSize: 12,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                // =====================================================
                // FOLLOW US
                // =====================================================

                const Center(
                  child: Text(
                    'FOLLOW US',

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight:
                          FontWeight.w800,
                      letterSpacing: 1,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // =====================================================
                // SOCIAL ICONS
                // =====================================================

                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center,

                  children: [

                    ContactWidgets
                        .socialImageButton(
                      'images/assets/Whatsepp.png',
                      const Color(0xFF25D366),
                      ContactHelpers
                          .openWhatsApp,
                    ),

                    const SizedBox(width: 10),

                    ContactWidgets
                        .socialImageButton(
                      'images/assets/Instagram.png',
                      const Color(0xFFE1306C),
                      ContactHelpers
                          .openInstagram,
                    ),

                    const SizedBox(width: 10),

                    ContactWidgets
                        .socialImageButton(
                      'images/assets/Linkdin.png',
                      const Color(0xFF0A66C2),
                      ContactHelpers
                          .openLinkedIn,
                    ),

                    const SizedBox(width: 10),

                    ContactWidgets
                        .socialImageButton(
                      'images/assets/Facebook.png',
                      const Color(0xFF1877F2),
                      ContactHelpers
                          .openFacebook,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}