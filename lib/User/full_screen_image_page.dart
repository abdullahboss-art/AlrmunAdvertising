import 'package:flutter/material.dart';

class FullScreenImagePage extends StatelessWidget {
  final String imagePath;

  const FullScreenImagePage({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: InteractiveViewer(
              minScale: 1,
              maxScale: 4,
              boundaryMargin: const EdgeInsets.all(40),
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
                width: MediaQuery.of(context).size.width,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.image_not_supported_outlined,
                  color: Colors.white38,
                  size: 60,
                ),
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.6),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 25,
            child: IgnorePointer(
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.55),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "Pinch to zoom • Drag to move",
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 11,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}