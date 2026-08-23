// import 'package:flutter/material.dart';

// import 'Home.dart';
// import 'Service.dart';
// import 'project_detail_page.dart';

// class GalleryPage extends StatefulWidget {
//   const GalleryPage({super.key});

//   @override
//   State<GalleryPage> createState() => _GalleryPageState();
// }

// class _GalleryPageState extends State<GalleryPage> {
//   static const Color bg = Color(0xFF0D0D0D);
//   static const Color card = Color(0xFF171717);
//   static const Color accent = Color(0xFF2FBEA6);

//   final List<String> filters = [
//     "All",
//     "Design",
//     "Print",
//     "Signage",
//     "3D",
//   ];

//   String selectedFilter = "All";

//   // ===============================================================
//   // PROJECTS
//   // ===============================================================

//   final List<Map<String, dynamic>> projects = [
//     {
//       "image": "images/assets/gallery1.png",
//       "category": "Design",
//       "title": "Alrmani Office Branding",
//       "description":
//           "Complete office branding including reception signage, wall graphics, directional signs and frosted glass branding.",
//       "services": [
//         "Signage",
//         "Branding",
//         "Printing",
//       ],
//       "facebookUrl":
//           "https://web.facebook.com/profile.php?id=100083316963554",
//       "instagramUsername": "alrmanadvertising",
//     },
//     {
//       "image": "images/assets/gallery2.png",
//       "category": "Print",
//       "title": "Business Card Printing",
//       "description":
//           "Premium finish business cards designed to create a professional and memorable brand identity.",
//       "services": [
//         "Printing",
//         "Branding",
//       ],
//       "facebookUrl":
//           "https://web.facebook.com/profile.php?id=100083316963554",
//       "instagramUsername": "alrmanadvertising",
//     },
//     {
//       "image": "images/assets/gallery3.png",
//       "category": "Signage",
//       "title": "Retail Shop Signage",
//       "description":
//           "Outdoor illuminated signage with premium acrylic lettering designed to give the retail space a strong visual identity.",
//       "services": [
//         "Signage",
//         "Acrylic",
//         "Installation",
//       ],
//       "facebookUrl":
//           "https://web.facebook.com/profile.php?id=100083316963554",
//       "instagramUsername": "alrmanadvertising",
//     },
//     {
//       "image": "images/assets/gallery4.png",
//       "category": "3D",
//       "title": "3D Logo Wall Display",
//       "description":
//           "Premium 3D LED backlit logo designed for a modern corporate reception and professional brand presentation.",
//       "services": [
//         "3D",
//         "LED",
//         "Signage",
//       ],
//       "facebookUrl":
//           "https://web.facebook.com/profile.php?id=100083316963554",
//       "instagramUsername": "alrmanadvertising",
//     },
//     {
//       "image": "images/assets/gallery5.png",
//       "category": "Design",
//       "title": "Brand Identity Design",
//       "description":
//           "Complete brand identity design including logo concepts, visual direction and brand guidelines.",
//       "services": [
//         "Branding",
//         "Graphic Design",
//         "Logo Design",
//       ],
//       "facebookUrl":
//           "https://web.facebook.com/profile.php?id=100083316963554",
//       "instagramUsername": "alrmanadvertising",
//     },
//     {
//       "image": "images/assets/gallery6.png",
//       "category": "Signage",
//       "title": "Directional Signage Set",
//       "description":
//           "Professional wayfinding and directional signage created for an office complex to improve navigation and presentation.",
//       "services": [
//         "Signage",
//         "Wayfinding",
//         "Printing",
//       ],
//       "facebookUrl":
//           "https://web.facebook.com/profile.php?id=100083316963554",
//       "instagramUsername": "alrmanadvertising",
//     },
//     {
//       "image": "images/assets/gallery7.png",
//       "category": "Print",
//       "title": "Brochure Printing",
//       "description":
//           "Creative tri-fold brochure design and high-quality printing created for a professional product launch.",
//       "services": [
//         "Printing",
//         "Graphic Design",
//       ],
//       "facebookUrl":
//           "https://web.facebook.com/profile.php?id=100083316963554",
//       "instagramUsername": "alrmanadvertising",
//     },
//     {
//       "image": "images/assets/gallery8.png",
//       "category": "3D",
//       "title": "3D Interior Mockup",
//       "description":
//           "Photorealistic 3D interior visualization created to present the complete concept before execution.",
//       "services": [
//         "3D Visualization",
//         "Interior Design",
//       ],
//       "facebookUrl":
//           "https://web.facebook.com/profile.php?id=100083316963554",
//       "instagramUsername": "alrmanadvertising",
//     },
//   ];

//   // ===============================================================
//   // OPEN FULL IMAGE
//   // ===============================================================

//   void _openFullImage(String imagePath) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (_) {
//           return FullScreenImagePage(
//             imagePath: imagePath,
//           );
//         },
//       ),
//     );
//   }

//   // ===============================================================
//   // BUILD
//   // ===============================================================

//   @override
//   Widget build(BuildContext context) {
//     final filteredProjects = selectedFilter == "All"
//         ? projects
//         : projects
//             .where(
//               (project) => project["category"] == selectedFilter,
//             )
//             .toList();

//     return Scaffold(
//       backgroundColor: bg,

//       body: SafeArea(
//         child: CustomScrollView(
//           physics: const BouncingScrollPhysics(),
//           slivers: [
//             // ========================================================
//             // HEADER
//             // ========================================================

//             SliverToBoxAdapter(
//               child: Padding(
//                 padding: const EdgeInsets.fromLTRB(
//                   18,
//                   15,
//                   18,
//                   0,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // ------------------------------------------------
//                     // TOP BAR
//                     // ------------------------------------------------

//                     Row(
//                       children: [
//                         InkWell(
//                           borderRadius: BorderRadius.circular(12),
//                           onTap: () {
//                             if (Navigator.canPop(context)) {
//                               Navigator.pop(context);
//                             } else {
//                               Navigator.pushReplacement(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (_) => const HomeScreen(),
//                                 ),
//                               );
//                             }
//                           },
//                           child: Container(
//                             width: 42,
//                             height: 42,
//                             decoration: BoxDecoration(
//                               color: card,
//                               borderRadius: BorderRadius.circular(12),
//                               border: Border.all(
//                                 color: Colors.white.withOpacity(0.06),
//                               ),
//                             ),
//                             child: const Icon(
//                               Icons.arrow_back_ios_new,
//                               color: Colors.white,
//                               size: 17,
//                             ),
//                           ),
//                         ),

//                         const SizedBox(width: 14),

//                         const Text(
//                           "Gallery",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 27,
//                             fontWeight: FontWeight.w800,
//                           ),
//                         ),
//                       ],
//                     ),

//                     const SizedBox(height: 26),

//                     // ------------------------------------------------
//                     // SECTION TITLE
//                     // ------------------------------------------------

//                     Row(
//                       children: [
//                         Container(
//                           width: 4,
//                           height: 24,
//                           decoration: BoxDecoration(
//                             color: accent,
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),

//                         const SizedBox(width: 10),

//                         const Text(
//                           "Our Completed Projects",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 18,
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                       ],
//                     ),

//                     const SizedBox(height: 15),

//                     // ------------------------------------------------
//                     // FILTERS
//                     // ------------------------------------------------

//                     SizedBox(
//                       height: 40,
//                       child: ListView.separated(
//                         scrollDirection: Axis.horizontal,
//                         physics: const BouncingScrollPhysics(),
//                         itemCount: filters.length,

//                         separatorBuilder: (_, __) {
//                           return const SizedBox(width: 9);
//                         },

//                         itemBuilder: (context, index) {
//                           final filter = filters[index];

//                           final isSelected =
//                               selectedFilter == filter;

//                           return GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 selectedFilter = filter;
//                               });
//                             },

//                             child: AnimatedContainer(
//                               duration: const Duration(
//                                 milliseconds: 200,
//                               ),

//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 17,
//                               ),

//                               alignment: Alignment.center,

//                               decoration: BoxDecoration(
//                                 color: isSelected
//                                     ? accent
//                                     : card,

//                                 borderRadius:
//                                     BorderRadius.circular(22),

//                                 border: Border.all(
//                                   color: isSelected
//                                       ? accent
//                                       : Colors.white
//                                           .withOpacity(0.07),
//                                 ),
//                               ),

//                               child: Text(
//                                 filter,
//                                 style: TextStyle(
//                                   color: isSelected
//                                       ? Colors.white
//                                       : Colors.white60,

//                                   fontSize: 13,

//                                   fontWeight:
//                                       FontWeight.w600,
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),

//                     const SizedBox(height: 22),
//                   ],
//                 ),
//               ),
//             ),

//             // ========================================================
//             // PROJECT GRID
//             // ========================================================

//             if (filteredProjects.isEmpty)
//               const SliverFillRemaining(
//                 hasScrollBody: false,

//                 child: Center(
//                   child: Text(
//                     "No projects found.",
//                     style: TextStyle(
//                       color: Colors.white54,
//                       fontSize: 14,
//                     ),
//                   ),
//                 ),
//               )
//             else
//               SliverPadding(
//                 padding: const EdgeInsets.fromLTRB(
//                   18,
//                   0,
//                   18,
//                   30,
//                 ),

//                 sliver: SliverGrid(
//                   delegate: SliverChildBuilderDelegate(
//                     (context, index) {
//                       final project =
//                           filteredProjects[index];

//                       return _projectCard(
//                         context,
//                         project,
//                       );
//                     },

//                     childCount:
//                         filteredProjects.length,
//                   ),

//                   gridDelegate:
//                       const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,

//                     crossAxisSpacing: 13,

//                     mainAxisSpacing: 15,

//                     childAspectRatio: 0.82,
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ===============================================================
//   // PROJECT CARD
//   // ===============================================================

//   Widget _projectCard(
//     BuildContext context,
//     Map<String, dynamic> project,
//   ) {
//     return Container(
//       decoration: BoxDecoration(
//         color: card,

//         borderRadius: BorderRadius.circular(18),

//         border: Border.all(
//           color: Colors.white.withOpacity(0.06),
//         ),
//       ),

//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(18),

//         child: Column(
//           crossAxisAlignment:
//               CrossAxisAlignment.start,

//           children: [
//             // ======================================================
//             // IMAGE
//             // ======================================================

//             Expanded(
//               child: _GalleryImage(
//                 imagePath: project["image"],
//                 category: project["category"],

//                 // Image par click
//                 // Full screen image open
//                 onTap: () {
//                   _openFullImage(
//                     project["image"],
//                   );
//                 },
//               ),
//             ),

//             // ======================================================
//             // CARD TEXT
//             // ======================================================

//             GestureDetector(
//               onTap: () {
//                 // Text/card area par click
//                 // Project Details open

//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) =>
//                         ProjectDetailPage(
//                       title: project["title"],

//                       category:
//                           project["category"],

//                       imageUrl:
//                           project["image"],

//                       description:
//                           project["description"],

//                       services:
//                           List<String>.from(
//                         project["services"],
//                       ),

//                       facebookUrl:
//                           project["facebookUrl"],

//                       instagramUsername:
//                           project[
//                               "instagramUsername"],
//                     ),
//                   ),
//                 );
//               },

//               child: Container(
//                 width: double.infinity,

//                 color: Colors.transparent,

//                 padding: const EdgeInsets.fromLTRB(
//                   12,
//                   11,
//                   10,
//                   12,
//                 ),

//                 child: Column(
//                   crossAxisAlignment:
//                       CrossAxisAlignment.start,

//                   children: [
//                     // ------------------------------------------------
//                     // TITLE
//                     // ------------------------------------------------

//                     Text(
//                       project["title"],

//                       maxLines: 1,

//                       overflow:
//                           TextOverflow.ellipsis,

//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 13,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),

//                     const SizedBox(height: 5),

//                     // ------------------------------------------------
//                     // DESCRIPTION
//                     // ------------------------------------------------

//                     Text(
//                       project["description"],

//                       maxLines: 2,

//                       overflow:
//                           TextOverflow.ellipsis,

//                       style: const TextStyle(
//                         color: Colors.white54,
//                         fontSize: 10.5,
//                         height: 1.35,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // ===================================================================
// // GALLERY IMAGE
// // ===================================================================

// class _GalleryImage extends StatefulWidget {
//   final String imagePath;
//   final String category;
//   final VoidCallback onTap;

//   const _GalleryImage({
//     required this.imagePath,
//     required this.category,
//     required this.onTap,
//   });

//   @override
//   State<_GalleryImage> createState() =>
//       _GalleryImageState();
// }

// class _GalleryImageState
//     extends State<_GalleryImage> {
//   bool _isHovering = false;

//   static const Color accent =
//       Color(0xFF2FBEA6);

//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       cursor: SystemMouseCursors.click,

//       // ============================================================
//       // MOUSE ENTER
//       // ============================================================

//       onEnter: (_) {
//         setState(() {
//           _isHovering = true;
//         });
//       },

//       // ============================================================
//       // MOUSE EXIT
//       // ============================================================

//       onExit: (_) {
//         setState(() {
//           _isHovering = false;
//         });
//       },

//       child: GestureDetector(
//         onTap: widget.onTap,

//         child: Stack(
//           fit: StackFit.expand,

//           children: [
//             // ======================================================
//             // IMAGE
//             // ======================================================

//             Image.asset(
//               widget.imagePath,

//               fit: BoxFit.cover,

//               errorBuilder:
//                   (context, error, stackTrace) {
//                 return Container(
//                   color: Colors.grey.shade900,

//                   child: const Icon(
//                     Icons
//                         .image_not_supported_outlined,

//                     color: Colors.white38,

//                     size: 40,
//                   ),
//                 );
//               },
//             ),

//             // ======================================================
//             // IMAGE GRADIENT
//             // ======================================================

//             Positioned.fill(
//               child: AnimatedContainer(
//                 duration:
//                     const Duration(milliseconds: 220),

//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topCenter,

//                     end: Alignment.bottomCenter,

//                     colors: [
//                       Colors.transparent,

//                       Colors.black.withOpacity(
//                         _isHovering
//                             ? 0.80
//                             : 0.75,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),

//             // ======================================================
//             // CATEGORY
//             // ======================================================

//             Positioned(
//               top: 10,
//               left: 10,

//               child: Container(
//                 padding:
//                     const EdgeInsets.symmetric(
//                   horizontal: 9,
//                   vertical: 5,
//                 ),

//                 decoration: BoxDecoration(
//                   color: accent,

//                   borderRadius:
//                       BorderRadius.circular(12),
//                 ),

//                 child: Text(
//                   widget.category,

//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 10,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ),
//             ),

//             // ======================================================
//             // CENTER EYE ICON
//             // ======================================================

//             Center(
//               child: AnimatedOpacity(
//                 duration:
//                     const Duration(milliseconds: 220),

//                 opacity:
//                     _isHovering ? 1.0 : 0.0,

//                 child: AnimatedScale(
//                   duration:
//                       const Duration(milliseconds: 220),

//                   scale:
//                       _isHovering ? 1.0 : 0.75,

//                   child: Container(
//                     width: 58,
//                     height: 58,

//                     decoration: BoxDecoration(
//                       color:
//                           Colors.black.withOpacity(
//                         0.65,
//                       ),

//                       shape: BoxShape.circle,

//                       border: Border.all(
//                         color: Colors.white
//                             .withOpacity(0.35),

//                         width: 1,
//                       ),

//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black
//                               .withOpacity(0.30),

//                           blurRadius: 15,

//                           spreadRadius: 1,
//                         ),
//                       ],
//                     ),

//                     child: const Icon(
//                       Icons.visibility_rounded,

//                       color: Colors.white,

//                       size: 27,
//                     ),
//                   ),
//                 ),
//               ),
//             ),

//             // ======================================================
//             // ARROW
//             // ======================================================

//             Positioned(
//               right: 10,
//               bottom: 10,

//               child: AnimatedOpacity(
//                 duration:
//                     const Duration(milliseconds: 200),

//                 opacity:
//                     _isHovering ? 0.0 : 1.0,

//                 child: Container(
//                   width: 32,
//                   height: 32,

//                   decoration: BoxDecoration(
//                     color:
//                         Colors.black.withOpacity(
//                       0.55,
//                     ),

//                     shape: BoxShape.circle,
//                   ),

//                   child: const Icon(
//                     Icons.arrow_forward_ios,

//                     color: Colors.white,

//                     size: 13,
//                   ),
//                 ),
//               ),
//             ),

//             // ======================================================
//             // HOVER OVERLAY
//             // ======================================================

//             Positioned.fill(
//               child: IgnorePointer(
//                 child: AnimatedContainer(
//                   duration:
//                       const Duration(milliseconds: 220),

//                   decoration: BoxDecoration(
//                     color: _isHovering
//                         ? Colors.white
//                             .withOpacity(0.03)
//                         : Colors.transparent,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // ===================================================================
// // FULL SCREEN IMAGE PAGE
// // ===================================================================

// class FullScreenImagePage
//     extends StatelessWidget {
//   final String imagePath;

//   const FullScreenImagePage({
//     super.key,
//     required this.imagePath,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,

//       body: Stack(
//         children: [
//           // ==========================================================
//           // IMAGE + ZOOM
//           // ==========================================================

//           Center(
//             child: InteractiveViewer(
//               minScale: 1.0,

//               maxScale: 4.0,

//               boundaryMargin:
//                   const EdgeInsets.all(40),

//               child: Image.asset(
//                 imagePath,

//                 fit: BoxFit.contain,

//                 width:
//                     MediaQuery.of(context)
//                         .size
//                         .width,

//                 errorBuilder:
//                     (context, error, stackTrace) {
//                   return const Center(
//                     child: Icon(
//                       Icons
//                           .image_not_supported_outlined,

//                       color: Colors.white38,

//                       size: 60,
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),

//           // ==========================================================
//           // CLOSE BUTTON
//           // ==========================================================

//           SafeArea(
//             child: Positioned(
//               top: 0,
//               left: 0,
//               child: Padding(
//                 padding:
//                     const EdgeInsets.all(14),

//                 child: Container(
//                   width: 44,
//                   height: 44,

//                   decoration: BoxDecoration(
//                     color: Colors.black
//                         .withOpacity(0.60),

//                     shape: BoxShape.circle,

//                     border: Border.all(
//                       color: Colors.white
//                           .withOpacity(0.15),
//                     ),
//                   ),

//                   child: IconButton(
//                     padding: EdgeInsets.zero,

//                     icon: const Icon(
//                       Icons.close,

//                       color: Colors.white,

//                       size: 22,
//                     ),

//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           // ==========================================================
//           // BOTTOM HINT
//           // ==========================================================

//           Positioned(
//             left: 0,
//             right: 0,
//             bottom: 25,

//             child: IgnorePointer(
//               child: Center(
//                 child: Container(
//                   padding:
//                       const EdgeInsets.symmetric(
//                     horizontal: 14,
//                     vertical: 8,
//                   ),

//                   decoration: BoxDecoration(
//                     color: Colors.black
//                         .withOpacity(0.55),

//                     borderRadius:
//                         BorderRadius.circular(20),
//                   ),

//                   child: const Text(
//                     "Pinch to zoom • Drag to move",

//                     style: TextStyle(
//                       color: Colors.white60,

//                       fontSize: 11,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import 'Home.dart';
import 'Service.dart';
import 'project_detail_page.dart';
import 'gallery_data.dart';
import 'full_screen_image_page.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  static const bg = Color(0xFF0D0D0D);
  static const card = Color(0xFF171717);
  static const accent = Color(0xFF2FBEA6);

  String selectedFilter = "All";

  List<Map<String, dynamic>> get filteredProjects {
    if (selectedFilter == "All") {
      return GalleryData.projects;
    }

    return GalleryData.projects
        .where((p) => p["category"] == selectedFilter)
        .toList();
  }

  void _openImage(String image) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FullScreenImagePage(
          imagePath: image,
        ),
      ),
    );
  }

  void _openProject(Map<String, dynamic> project) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProjectDetailPage(
          title: project["title"],
          category: project["category"],
          imageUrl: project["image"],
          description: project["description"],
          services: List<String>.from(project["services"]),
          facebookUrl: project["facebookUrl"],
          instagramUsername: project["instagramUsername"],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: _header(),
            ),

            if (filteredProjects.isEmpty)
              const SliverFillRemaining(
                child: Center(
                  child: Text(
                    "No projects found.",
                    style: TextStyle(
                      color: Colors.white54,
                    ),
                  ),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  18,
                  0,
                  18,
                  30,
                ),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (_, index) {
                      return _projectCard(
                        filteredProjects[index],
                      );
                    },
                    childCount: filteredProjects.length,
                  ),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 13,
                    mainAxisSpacing: 15,
                    childAspectRatio: .82,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 15, 18, 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _backButton(),
              const SizedBox(width: 14),
              const Text(
                "Gallery",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 27,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),

          const SizedBox(height: 26),

          Row(
            children: [
              Container(
                width: 4,
                height: 24,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                "Our Completed Projects",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          _filters(),
        ],
      ),
    );
  }

  Widget _backButton() {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const HomeScreen(),
            ),
          );
        }
      },
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white.withOpacity(.06),
          ),
        ),
        child: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
          size: 17,
        ),
      ),
    );
  }

  Widget _filters() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: GalleryData.filters.length,
        separatorBuilder: (_, __) =>
            const SizedBox(width: 9),
        itemBuilder: (_, index) {
          final filter = GalleryData.filters[index];
          final selected = selectedFilter == filter;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedFilter = filter;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(
                horizontal: 17,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected ? accent : card,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: selected
                      ? accent
                      : Colors.white.withOpacity(.07),
                ),
              ),
              child: Text(
                filter,
                style: TextStyle(
                  color: selected
                      ? Colors.white
                      : Colors.white60,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _projectCard(
    Map<String, dynamic> project,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white.withOpacity(.06),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: GalleryImage(
                imagePath: project["image"],
                category: project["category"],
                onTap: () => _openImage(project["image"]),
              ),
            ),

            InkWell(
              onTap: () => _openProject(project),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  12,
                  11,
                  10,
                  12,
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      project["title"],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      project["description"],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 10.5,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GalleryImage extends StatefulWidget {
  final String imagePath;
  final String category;
  final VoidCallback onTap;

  const GalleryImage({
    super.key,
    required this.imagePath,
    required this.category,
    required this.onTap,
  });

  @override
  State<GalleryImage> createState() => _GalleryImageState();
}

class _GalleryImageState extends State<GalleryImage> {
  bool hovering = false;

  static const accent = Color(0xFF2FBEA6);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => hovering = true),
      onExit: (_) => setState(() => hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              widget.imagePath,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
                return Container(
                  color: Colors.grey.shade900,
                  child: const Icon(
                    Icons.image_not_supported_outlined,
                    color: Colors.white38,
                    size: 40,
                  ),
                );
              },
            ),

            AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(
                      hovering ? .80 : .75,
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              top: 10,
              left: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  widget.category,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),

            Center(
              child: AnimatedScale(
                scale: hovering ? 1 : .75,
                duration:
                    const Duration(milliseconds: 220),
                child: AnimatedOpacity(
                  opacity: hovering ? 1 : 0,
                  duration:
                      const Duration(milliseconds: 220),
                  child: Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.65),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(.35),
                      ),
                    ),
                    child: const Icon(
                      Icons.visibility_rounded,
                      color: Colors.white,
                      size: 27,
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
              right: 10,
              bottom: 10,
              child: AnimatedOpacity(
                opacity: hovering ? 0 : 1,
                duration:
                    const Duration(milliseconds: 200),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.55),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 13,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}