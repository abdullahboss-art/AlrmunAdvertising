import 'package:flutter/material.dart';

import 'Home.dart';


import 'gallery_data.dart';
import 'full_screen_image_page.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  static const bg = Color(0xFF0B0F19);
  static const card = Color(0xFF171717);
  static const accent = Color(0xFF2BC3DC); // <- heading color

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
            
              

            const Text(
              "Portofio",
              style: TextStyle(
                color: Color(0xFF2BC3DC),
                fontSize: 27,
                fontWeight: FontWeight.w800,
              ),
            ),

            const Spacer(),

            // // HOME ARROW BUTTON
            // InkWell(
            //   borderRadius: BorderRadius.circular(12),
            //   onTap: () {
            //     Navigator.pushReplacement(
            //       context,
            //       MaterialPageRoute(
            //         builder: (_) => const HomeScreen(),
            //       ),
            //     );
            //   },
            //   child: Container(
            //     width: 42,
            //     height: 42,
            //     decoration: BoxDecoration(
            //       color: card,
            //       borderRadius: BorderRadius.circular(12),
            //       border: Border.all(
            //         color: Colors.white.withOpacity(.06),
            //       ),
            //     ),
            //     child: const Icon(
            //       Icons.arrow_forward_ios_rounded,
            //       color: Colors.white,
            //       size: 17,
            //     ),
            //   ),
            // ),
          ],
        ),

        const SizedBox(height: 26),

        Row(
          children: [
            Container(
              width: 4,
              height: 24,
             decoration: BoxDecoration(
  color: Color(0xFF2BC3DC),
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
                      ? Color(0xFF2BC3DC)
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

  static const accent = Color(0xFF2BC3DC); // <- heading color (was 0xFF2FBEA6)

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