import 'dart:ui';

import 'package:adverting_app/User/Contact.dart';
import 'package:adverting_app/User/Gallery.dart';
import 'package:adverting_app/User/Home.dart';
import 'package:adverting_app/User/Profile.dart';
import 'package:adverting_app/User/Service.dart';
import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatefulWidget {
  final int initialIndex;

  const CustomBottomNavBar({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<CustomBottomNavBar> createState() =>
      _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  late int currentIndex;

  final List<IconData> icons = [
    Icons.home_rounded,
    Icons.dashboard_customize_rounded,
    Icons.photo_library_rounded,
    Icons.contact_mail_rounded,
    Icons.person_outline_rounded,
  ];

  final List<String> titles = [
    "Home",
    "Services",
    "Gallery",
    "Contact Us",
    "Profile",
  ];

  @override
  void initState() {
    super.initState();

    currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const HomeScreen(),
      const ServicesPage(),
      const GalleryPage(),
      const ContactPage(),

      ProfilePage(
        onTabChange: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xff0B0F14),

      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),

      extendBody: true,

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          left: 18,
          right: 18,
          bottom: 14,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),

          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 15,
              sigmaY: 15,
            ),

            child: Container(
              height: 58,

              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.08),

                borderRadius:
                    BorderRadius.circular(24),

                border: Border.all(
                  color: Colors.white12,
                ),
              ),

              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly,

                children: List.generate(
                  icons.length,
                  (index) {
                    final bool selected =
                        currentIndex == index;

                    return InkWell(
                      borderRadius:
                          BorderRadius.circular(18),

                      onTap: () {
                        setState(() {
                          currentIndex = index;
                        });
                      },

                      child: AnimatedContainer(
                        duration:
                            const Duration(
                          milliseconds: 250,
                        ),

                        curve: Curves.easeInOut,

                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),

                        decoration:
                            BoxDecoration(
                          color: selected
                              ? const Color(
                                  0xff18D4D0,
                                ).withOpacity(.15)
                              : Colors.transparent,

                          borderRadius:
                              BorderRadius.circular(16),
                        ),

                        child: Column(
                          mainAxisSize:
                              MainAxisSize.min,

                          mainAxisAlignment:
                              MainAxisAlignment.center,

                          children: [
                            Icon(
                              icons[index],
                              size: 21,

                              color: selected
                                  ? const Color(
                                      0xff18D4D0,
                                    )
                                  : Colors.white54,
                            ),

                            const SizedBox(
                              height: 3,
                            ),

                            AnimatedContainer(
                              duration:
                                  const Duration(
                                milliseconds: 250,
                              ),

                              height: 3,

                              width:
                                  selected ? 16 : 0,

                              decoration:
                                  BoxDecoration(
                                color:
                                    const Color(
                                  0xff18D4D0,
                                ),

                                borderRadius:
                                    BorderRadius.circular(
                                  10,
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
            ),
          ),
        ),
      ),
    );
  }
}