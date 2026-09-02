class HomeData {
  static const List<Map<String, String>> services = [
    {
      'title': 'GRAPHIC & WEB \nDESIGN',
      'image': 'images/assets/Graphic_Deisgn.png',
      'subtitle': 'Creative Design Solutions',
    },
    {
      'title': 'ANIMATION & MEDIA \nPRODUCTION',
      'image': 'images/assets/Animation & Media_Prodcution.png',
      'subtitle': 'Motion & Media Production',
    },
    {
      'title': '3D SIGN SOLUTIONS & \nFABRICATION',
      'image': 'images/assets/3d Visualization.png',
      'subtitle': '3D Signs & Fabrication',
    },
    {
      'title': 'DIGITAL & OFFSET \nPRINTING',
      'image': 'images/assets/Digital&offset.png',
      'subtitle': 'Professional Printing',
    },
    {
      'title': 'LARGE FORMAT \nPRINTING',
      'image': 'images/assets/Outdoor Advertising.png',
      'subtitle': 'Billboards & Large Prints',
    },
    {
      'title': 'SIGNAGE PRODUCTION & \nINSTALLATION',
      'image': 'images/assets/Sign Boards.png',
      'subtitle': 'Indoor & Outdoor Signage',
    },
    {
      'title': 'PROMOTIONAL GIFTS \nPRINTING',
      'image': 'images/assets/3d_images.jpg',
      'subtitle': 'Custom Promotional Gifts',
    },
    {
      'title': 'EVENTS & EXHIBITION \nSTAND DESIGN',
      'image': 'images/assets/Events & Exhibition.webp',
      'subtitle': 'Exhibition & Stand Design',
    },
  ];

  static List<String> getOffers(String title) {
    final String cleanTitle =
        title.replaceAll('\n', ' ').trim().toUpperCase();

    switch (cleanTitle) {
      case "GRAPHIC & WEB DESIGN":
        return [
          "Logo Design",
          "Brand Identity",
          "Business Card Design",
          "Brochure Design",
          "Flyer Design",
          "Social Media Design",
          "Packaging Design",
          "Website Design",
          "UI/UX Design",
        ];

      case "ANIMATION & MEDIA PRODUCTION":
        return [
          "2D Animation",
          "3D Animation",
          "Motion Graphics",
          "Video Editing",
          "Explainer Videos",
          "Product Advertisement",
          "YouTube Video Editing",
          "Reels & Short Videos",
          "Corporate Videos",
        ];

      case "3D SIGN SOLUTIONS & FABRICATION":
        return [
          "3D Letter Signs",
          "3D Channel Letters",
          "Acrylic Signs",
          "LED Sign Boards",
          "Stainless Steel Signs",
          "Metal Fabrication",
          "Shop Front Signs",
          "Indoor Signage",
          "Outdoor Signage",
        ];

      case "DIGITAL & OFFSET PRINTING":
        return [
          "Business Cards",
          "Brochures",
          "Flyers",
          "Posters",
          "Catalog Printing",
          "Sticker Printing",
          "Packaging Printing",
          "Offset Printing",
          "Marketing Materials",
        ];

      case "LARGE FORMAT PRINTING":
        return [
          "Flex Printing",
          "Vinyl Printing",
          "One Way Vision",
          "Billboard Printing",
          "Building Wraps",
          "Vehicle Branding",
          "Backlit Printing",
          "Wall Graphics",
          "Large Promotional Prints",
        ];

      case "SIGNAGE PRODUCTION & INSTALLATION":
        return [
          "Sign Board Production",
          "Shop Signage",
          "Indoor Signage",
          "Outdoor Signage",
          "LED Signage",
          "Acrylic Signage",
          "Directional Signs",
          "Installation Services",
          "Maintenance & Repair",
        ];

      case "PROMOTIONAL GIFTS PRINTING":
        return [
          "Custom Mugs",
          "T-Shirts Printing",
          "Caps & Hats",
          "Keychains",
          "Pens",
          "Tote Bags",
          "Corporate Gifts",
          "Customized Products",
          "Branded Promotional Items",
        ];

      case "EVENTS & EXHIBITION STAND DESIGN":
        return [
          "Exhibition Stand Design",
          "3D Stand Visualization",
          "Booth Design",
          "Backdrop Design",
          "Display Counters",
          "Promotional Displays",
          "Event Branding",
          "Stand Fabrication",
          "Stand Installation",
        ];

      default:
        return [
          "Custom Design Solutions",
          "Professional Consultation",
          "Customized Services",
        ];
    }
  }
}