
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// const String kWhatsappNumber = "971527898516";

// class ProjectDetailPage extends StatelessWidget {
//   final String title;
//   final String category;
//   final String imageUrl;
//   final String description;
//   final List<String> services;
//   final String facebookUrl;
//   final String instagramUsername;

//   const ProjectDetailPage({
//     super.key,
//     required this.title,
//     required this.category,
//     required this.imageUrl,
//     required this.description,
//     required this.services,
//     required this.facebookUrl,
//     required this.instagramUsername,
//   });

//   Future<void> _openWhatsApp(String message) async {
//     final Uri url = Uri.parse(
//       "https://wa.me/$kWhatsappNumber?text=${Uri.encodeComponent(message)}",
//     );

//     await launchUrl(
//       url,
//       mode: LaunchMode.externalApplication,
//     );
//   }

//   Future<void> _openSocial(String appUrl, String webUrl) async {
//     final app = Uri.parse(appUrl);
//     final web = Uri.parse(webUrl);

//     if (await canLaunchUrl(app)) {
//       await launchUrl(
//         app,
//         mode: LaunchMode.externalApplication,
//       );
//     } else {
//       await launchUrl(
//         web,
//         mode: LaunchMode.externalApplication,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     const bg = Color(0xFF0D0D0D);
//     const card = Color(0xFF171717);
//     const accent = Color(0xFF2FBEA6);

//     return Scaffold(
//       backgroundColor: bg,
//       body: CustomScrollView(
//         physics: const BouncingScrollPhysics(),
//         slivers: [
//           // ---------------------------------------------------------
//           // PROJECT IMAGE + BACK BUTTON
//           // ---------------------------------------------------------
//           SliverAppBar(
//             expandedHeight: 280,
//             pinned: true,
//             backgroundColor: bg,
//             elevation: 0,
//             automaticallyImplyLeading: false,

//             leading: Padding(
//               padding: const EdgeInsets.all(8),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.black.withOpacity(0.55),
//                   shape: BoxShape.circle,
//                 ),
//                 child: IconButton(
//                   icon: const Icon(
//                     Icons.arrow_back_ios_new,
//                     color: Colors.white,
//                     size: 18,
//                   ),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//               ),
//             ),

//             flexibleSpace: FlexibleSpaceBar(
//               background: Stack(
//                 fit: StackFit.expand,
//                 children: [
//                   Image.network(
//                     imageUrl,
//                     fit: BoxFit.cover,
//                     errorBuilder: (context, error, stackTrace) {
//                       return Container(
//                         color: Colors.grey.shade900,
//                         child: const Icon(
//                           Icons.image_not_supported_outlined,
//                           color: Colors.white38,
//                           size: 50,
//                         ),
//                       );
//                     },
//                   ),

//                   // Dark gradient
//                   DecoratedBox(
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         colors: [
//                           Colors.black.withOpacity(0.15),
//                           Colors.black.withOpacity(0.85),
//                         ],
//                       ),
//                     ),
//                   ),

//                   // Bottom image title
//                   Positioned(
//                     left: 20,
//                     right: 20,
//                     bottom: 22,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 11,
//                             vertical: 6,
//                           ),
//                           decoration: BoxDecoration(
//                             color: accent,
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: Text(
//                             category,
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 11,
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                         ),

//                         const SizedBox(height: 10),

//                         Text(
//                           title,
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 25,
//                             fontWeight: FontWeight.w800,
//                             height: 1.15,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           // ---------------------------------------------------------
//           // CONTENT
//           // ---------------------------------------------------------
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(18, 22, 18, 35),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // -------------------------------------------------
//                   // PROJECT OVERVIEW
//                   // -------------------------------------------------
//                   _sectionTitle(
//                     icon: Icons.description_outlined,
//                     title: "Project Overview",
//                   ),

//                   const SizedBox(height: 12),

//                   Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.all(18),
//                     decoration: BoxDecoration(
//                       color: card,
//                       borderRadius: BorderRadius.circular(18),
//                       border: Border.all(
//                         color: Colors.white.withOpacity(0.06),
//                       ),
//                     ),
//                     child: Text(
//                       description,
//                       style: const TextStyle(
//                         color: Colors.white70,
//                         fontSize: 14,
//                         height: 1.65,
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 28),

//                   // -------------------------------------------------
//                   // SERVICES USED
//                   // -------------------------------------------------
//                   _sectionTitle(
//                     icon: Icons.design_services_outlined,
//                     title: "Services Used",
//                   ),

//                   const SizedBox(height: 12),

//                   Wrap(
//                     spacing: 9,
//                     runSpacing: 9,
//                     children: services.map((service) {
//                       return Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 14,
//                           vertical: 10,
//                         ),
//                         decoration: BoxDecoration(
//                           color: card,
//                           borderRadius: BorderRadius.circular(12),
//                           border: Border.all(
//                             color: accent.withOpacity(0.20),
//                           ),
//                         ),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             const Icon(
//                               Icons.check_circle_outline,
//                               size: 15,
//                               color: accent,
//                             ),
//                             const SizedBox(width: 7),
//                             Text(
//                               service,
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     }).toList(),
//                   ),

//                   const SizedBox(height: 30),

//                   // -------------------------------------------------
//                   // SHARE PROJECT
//                   // -------------------------------------------------
//                   _sectionTitle(
//                     icon: Icons.share_outlined,
//                     title: "Share Project",
//                   ),

//                   const SizedBox(height: 14),

//                   Row(
//                     children: [
//                       _socialIcon(
//                         color: const Color(0xFF25D366),
//                         child: const FaIcon(
//                           FontAwesomeIcons.whatsapp,
//                           color: Colors.white,
//                           size: 21,
//                         ),
//                         onTap: () => _openWhatsApp(
//                           "Hi, I want to know about $title",
//                         ),
//                       ),

//                       const SizedBox(width: 12),

//                       _socialIcon(
//                         color: const Color(0xFF1877F2),
//                         child: const FaIcon(
//                           FontAwesomeIcons.facebookF,
//                           color: Colors.white,
//                           size: 19,
//                         ),
//                         onTap: () => _openSocial(
//                           'fb://facewebmodal/f?href=https://web.facebook.com/profile.php?id=100083316963554',
//                           facebookUrl,
//                         ),
//                       ),

//                       const SizedBox(width: 12),

//                       _socialIcon(
//                         color: const Color(0xFFE1306C),
//                         child: const FaIcon(
//                           FontAwesomeIcons.instagram,
//                           color: Colors.white,
//                           size: 21,
//                         ),
//                         onTap: () => _openSocial(
//                           'instagram://user?username=$instagramUsername',
//                           'https://www.instagram.com/alrmanadvertising/',
//                         ),
//                       ),

//                       const SizedBox(width: 12),

//                       _socialIcon(
//                         color: const Color(0xFF0A66C2),
//                         child: const FaIcon(
//                           FontAwesomeIcons.linkedinIn,
//                           color: Colors.white,
//                           size: 19,
//                         ),
//                         onTap: () => _openSocial(
//                           'linkedin://company/alrman-advertising',
//                           'https://www.linkedin.com/company/alrman-advertising/posts/?feedView=all',
//                         ),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 25),

//                   // -------------------------------------------------
//                   // SMALL FOOTER
//                   // -------------------------------------------------
//                   Center(
//                     child: Text(
//                       "Project Showcase",
//                       style: TextStyle(
//                         color: Colors.white.withOpacity(0.30),
//                         fontSize: 12,
//                         letterSpacing: 1,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ---------------------------------------------------------------
//   // SECTION TITLE
//   // ---------------------------------------------------------------
//   Widget _sectionTitle({
//     required IconData icon,
//     required String title,
//   }) {
//     return Row(
//       children: [
//         Container(
//           width: 34,
//           height: 34,
//           decoration: BoxDecoration(
//             color: const Color(0xFF2FBEA6).withOpacity(0.12),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: const Icon(
//             Icons.circle,
//             color: Colors.transparent,
//             size: 1,
//           ),
//         ),

//         Transform.translate(
//           offset: const Offset(-25, 0),
//           child: Icon(
//             icon,
//             color: const Color(0xFF2FBEA6),
//             size: 18,
//           ),
//         ),

//         Transform.translate(
//           offset: const Offset(-16, 0),
//           child: Text(
//             title,
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 16,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   // ---------------------------------------------------------------
//   // SOCIAL ICON
//   // ---------------------------------------------------------------
//   Widget _socialIcon({
//     required Color color,
//     required Widget child,
//     required VoidCallback onTap,
//   }) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(16),
//       child: Container(
//         width: 50,
//         height: 50,
//         decoration: BoxDecoration(
//           color: color,
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: color.withOpacity(0.20),
//               blurRadius: 10,
//               spreadRadius: 1,
//             ),
//           ],
//         ),
//         child: Center(
//           child: child,
//         ),
//       ),
//     );
//   }
// }