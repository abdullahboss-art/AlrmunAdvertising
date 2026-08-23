import 'package:adverting_app/User/GetQuote.dart';
import 'package:flutter/material.dart';

class ServiceDetail extends StatelessWidget {
  final Map<String, String> service;

  const ServiceDetail({
    super.key,
    required this.service,
  });

  List<String> getOffers(String title) {
    switch (title) {
      case "Graphic Design":
        return [
          "Logo Design",
          "Brand Identity",
          "Business Card Design",
          "Brochure Design",
          "Flyer Design",
          "Social Media Design",
          "Packaging Design",
          "Banner Design",
          "UI/UX Design",
        ];

      case "Animation & Media":
        return [
          "2D Animation",
          "3D Animation",
          "Motion Graphics",
          "Video Editing",
          "Explainer Videos",
          "Product Advertisement",
          "YouTube Editing",
          "Reels Editing",
          "Corporate Videos",
        ];

      case "3D Visualization":
        return [
          "Interior Rendering",
          "Exterior Rendering",
          "3D Product Design",
          "Furniture Modeling",
          "Architecture Modeling",
          "Walkthrough Animation",
          "Industrial Design",
          "Landscape Design",
          "3D Floor Plans",
        ];

      case "Digital & Offset":
        return [
          "Business Cards",
          "Brochures",
          "Flyers",
          "Posters",
          "Roll-up Stands",
          "Catalog Printing",
          "Packaging Printing",
          "Offset Printing",
          "Sticker Printing",
        ];

      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final offers = getOffers(service["title"] ?? "");

    return Scaffold(
      backgroundColor: const Color(0xff0D0D0D),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// IMAGE
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
              child: Image.asset(
                service["image"]!,
                width: double.infinity,
                height: 260,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// TITLE
                  Text(
                    service["title"]!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  /// DESCRIPTION
                  Text(
                    service["description"]!,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                      height: 1.7,
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// HEADING
                  const Text(
                    "What We Offer",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  /// OFFER CARD
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xff171717),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      children: offers.map((item) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.check_circle,
                                color: Color(0xff18D4D9),
                                size: 22,
                              ),

                              const SizedBox(width: 12),

                              Expanded(
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  const SizedBox(height: 35),

                  /// GET A QUOTE BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff18D4D9),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GetAQuotePage(
                              serviceTitle: service["title"] ?? "",
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        "Get a Quote",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}