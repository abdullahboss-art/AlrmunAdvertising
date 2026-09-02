import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeWidgets {
  // =========================================================
  // COLORS
  // =========================================================

  static const Color background = Color(0xFF0B0F19);
  static const Color card = Color(0xFF171717);
  static const Color accent = Color(0xFF36B6BD);
  static const Color accentDark = Color(0xFF2A8F95);

  // =========================================================
  // SECTION HEADER
  // =========================================================

  static Widget sectionHeader({
    required String title,
    required String subtitle,
    required String buttonText,
    required VoidCallback onButtonTap,
    bool showLess = false,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        16,
        28,
        16,
        0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 5,
                  height: 28,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        accent,
                        accentDark,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          letterSpacing: .2,
                        ),
                      ),

                      const SizedBox(height: 1),

                      Text(
                        subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          color: Colors.white54,
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          // =========================================================
          // SEE ALL / SHOW LESS
          // =========================================================

          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(11),
              onTap: onButtonTap,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: accent.withOpacity(.08),
                  borderRadius: BorderRadius.circular(11),
                  border: Border.all(
                    color: accent.withOpacity(.22),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      buttonText,
                      style: GoogleFonts.poppins(
                        color: accent,
                        fontSize: 10.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(width: 4),

                    Icon(
                      showLess
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.arrow_forward_rounded,
                      color: accent,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // SERVICE GRID
  // =========================================================

  static Widget servicesGrid({
    required List<Map<String, String>> services,
    required Function(Map<String, String>) onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),

        itemCount: services.length,

        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: .85,
        ),

        // =========================================================
        // ITEM BUILDER
        // =========================================================

        itemBuilder: (context, index) {
          final service = services[index];

          return serviceCard(
            service: service,

            // IMPORTANT:
            // Card click -> HomeScreen ka onTap
            // -> ServiceDetail page
            onTap: () {
              onTap(service);
            },
          );
        },
      ),
    );
  }

  // =========================================================
  // SERVICE CARD
  // =========================================================

  static Widget serviceCard({
    required Map<String, String> service,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,

      child: InkWell(
        borderRadius: BorderRadius.circular(17),

        // =========================================================
        // CARD CLICK
        // =========================================================

        onTap: onTap,

        child: Container(
          decoration: BoxDecoration(
            color: card,

            borderRadius: BorderRadius.circular(17),

            border: Border.all(
              color: Colors.white.withOpacity(.09),
            ),

            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.28),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              // =====================================================
              // IMAGE
              // =====================================================

              Expanded(
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.only(
                        topLeft: Radius.circular(17),
                        topRight: Radius.circular(17),
                      ),

                      child: Image.asset(
                        service['image'] ?? '',

                        width: double.infinity,
                        height: double.infinity,

                        fit: BoxFit.cover,

                        errorBuilder:
                            (context, error, stackTrace) {
                          return Container(
                            color:
                                const Color(0xFF151515),

                            child: const Center(
                              child: Icon(
                                Icons
                                    .image_not_supported_outlined,
                                color: Colors.white38,
                                size: 34,
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    // =================================================
                    // IMAGE DARK OVERLAY
                    // =================================================

                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient:
                              LinearGradient(
                            begin:
                                Alignment.topCenter,
                            end:
                                Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black
                                  .withOpacity(.35),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // =================================================
                    // TOP ARROW
                    // =================================================

                    Positioned(
                      top: 9,
                      right: 9,

                      child: Container(
                        width: 31,
                        height: 31,

                        decoration: BoxDecoration(
                          color: Colors.black
                              .withOpacity(.60),

                          shape: BoxShape.circle,

                          border: Border.all(
                            color: Colors.white
                                .withOpacity(.12),
                          ),
                        ),

                        child: const Icon(
                          Icons.arrow_outward_rounded,
                          color: accent,
                          size: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // =====================================================
              // CARD TEXT
              // =====================================================

              Padding(
                padding:
                    const EdgeInsets.fromLTRB(
                  10,
                  9,
                  8,
                  9,
                ),

                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [
                          // =================================================
                          // SERVICE TITLE
                          // =================================================

                          Text(
                            service['title'] ?? '',

                            maxLines: 2,

                            overflow:
                                TextOverflow.ellipsis,

                            style:
                                GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 12.5,
                              fontWeight:
                                  FontWeight.w600,
                              height: 1.15,
                            ),
                          ),

                          const SizedBox(height: 2),

                          // =================================================
                          // SERVICE SUBTITLE
                          // =================================================

                          Text(
                            service['subtitle'] ?? '',

                            maxLines: 1,

                            overflow:
                                TextOverflow.ellipsis,

                            style:
                                GoogleFonts.poppins(
                              color: Colors.white54,
                              fontSize: 9,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 5),

                    // =================================================
                    // ARROW
                    // =================================================

                    const Icon(
                      Icons.arrow_forward_rounded,
                      color: accent,
                      size: 17,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================================
  // PORTFOLIO GRID
  // =========================================================

  static Widget portfolioGrid({
    required List<Map<String, dynamic>> projects,
    required Function(Map<String, dynamic>) onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics:
            const NeverScrollableScrollPhysics(),

        itemCount: projects.length,

        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: .86,
        ),

        itemBuilder: (context, index) {
          final project = projects[index];

          return portfolioCard(
            project: project,

            onTap: () {
              onTap(project);
            },
          );
        },
      ),
    );
  }

  // =========================================================
  // PORTFOLIO CARD
  // =========================================================

  static Widget portfolioCard({
    required Map<String, dynamic> project,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,

      child: InkWell(
        borderRadius: BorderRadius.circular(17),

        onTap: onTap,

        child: Container(
          decoration: BoxDecoration(
            color: card,

            borderRadius: BorderRadius.circular(17),

            border: Border.all(
              color: Colors.white.withOpacity(.09),
            ),

            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.28),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),

          child: ClipRRect(
            borderRadius:
                BorderRadius.circular(17),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                // =================================================
                // IMAGE
                // =================================================

                Expanded(
                  child: Stack(
                    fit: StackFit.expand,

                    children: [
                      Image.asset(
                        project['image'],
                        fit: BoxFit.cover,

                        errorBuilder:
                            (context, error, stackTrace) {
                          return Container(
                            color:
                                const Color(0xFF151515),

                            child: const Center(
                              child: Icon(
                                Icons
                                    .image_not_supported_outlined,
                                color: Colors.white38,
                                size: 35,
                              ),
                            ),
                          );
                        },
                      ),

                      // =================================================
                      // GRADIENT
                      // =================================================

                      Positioned.fill(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient:
                                LinearGradient(
                              begin:
                                  Alignment.topCenter,
                              end:
                                  Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black
                                    .withOpacity(.72),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // =================================================
                      // CATEGORY
                      // =================================================

                      Positioned(
                        top: 9,
                        left: 9,

                        child: Container(
                          padding:
                              const EdgeInsets
                                  .symmetric(
                            horizontal: 9,
                            vertical: 5,
                          ),

                          decoration:
                              BoxDecoration(
                            color: accent,

                            borderRadius:
                                BorderRadius.circular(
                              20,
                            ),
                          ),

                          child: Text(
                            project['category'] ?? '',

                            style:
                                GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 9,
                              fontWeight:
                                  FontWeight.w700,
                            ),
                          ),
                        ),
                      ),

                      // =================================================
                      // VIEW ICON
                      // =================================================

                      Positioned(
                        top: 9,
                        right: 9,

                        child: Container(
                          width: 30,
                          height: 30,

                          decoration:
                              BoxDecoration(
                            color: Colors.black
                                .withOpacity(.60),

                            shape: BoxShape.circle,

                            border: Border.all(
                              color: Colors.white
                                  .withOpacity(.15),
                            ),
                          ),

                          child: const Icon(
                            Icons.visibility_rounded,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                      ),

                      // =================================================
                      // TITLE ON IMAGE
                      // =================================================

                      Positioned(
                        left: 10,
                        right: 10,
                        bottom: 10,

                        child: Text(
                          project['title'] ?? '',

                          maxLines: 2,

                          overflow:
                              TextOverflow.ellipsis,

                          style:
                              GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight:
                                FontWeight.w700,
                            height: 1.25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // =================================================
                // BOTTOM INFO
                // =================================================

                Padding(
                  padding:
                      const EdgeInsets.fromLTRB(
                    10,
                    8,
                    8,
                    9,
                  ),

                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'View Project',

                          style:
                              GoogleFonts.poppins(
                            color: Colors.white54,
                            fontSize: 9,
                            fontWeight:
                                FontWeight.w500,
                          ),
                        ),
                      ),

                      const Icon(
                        Icons.arrow_forward_rounded,
                        color: accent,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // =========================================================
  // PORTFOLIO INTRO
  // =========================================================

  static Widget portfolioIntro() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        16,
        8,
        16,
        0,
      ),

      child: Container(
        width: double.infinity,

        padding: const EdgeInsets.all(13),

        decoration: BoxDecoration(
          color: accent.withOpacity(.045),

          borderRadius:
              BorderRadius.circular(14),

          border: Border.all(
            color: accent.withOpacity(.10),
          ),
        ),

        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,

              decoration: BoxDecoration(
                color: accent.withOpacity(.10),
                shape: BoxShape.circle,
              ),

              child: const Icon(
                Icons.auto_awesome_rounded,
                color: accent,
                size: 19,
              ),
            ),

            const SizedBox(width: 10),

            // Future text can be added here.
          ],
        ),
      ),
    );
  }
}