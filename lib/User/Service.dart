  import 'package:flutter/material.dart';
 import 'ServiceDetail.dart';
  class ServicesPage extends StatefulWidget {
    
    final String? selectedService;

    const ServicesPage({super.key, this.selectedService});

    @override
    State<ServicesPage> createState() => _ServicesPageState();
  }
  int hoveredIndex = -1;

  class _ServicesPageState extends State<ServicesPage> {
  
    final List<Map<String, String>> services = [
      {
        'title': 'Graphic Design',
        'image': 'images/assets/Graphic_Deisgn.png',
        'description':
            'Creative and professional graphic design solutions for branding, '
                'print, and digital media that make your business stand out.',
      },
      {
        'title': 'Animation & Media',
        'image': 'images/assets/Animation & Media_Prodcution.png',
        'description':
            'Engaging animation and media production services including motion '
                'graphics, video editing, and promotional content.',
      },
      {
        'title': '3D Visualization',
        'image': 'images/assets/3d Visualization.png',
        'description':
            'Realistic 3D visualization and modeling for architecture, products, '
                'and interior design concepts.',
      },
      {
        'title': 'Digital & Offset',
        'image': 'images/assets/Digital&offset.png',
        'description':
            'High quality digital and offset printing services for all your '
                'business and personal printing needs.',
      },
    ];

    // One GlobalKey per service item, used to scroll to whichever one
    // was selected on the Home page.
    late final Map<String, GlobalKey> _itemKeys;

    @override
    void initState() {
      super.initState();
      _itemKeys = {
        for (final s in services) s['title']!: GlobalKey(),
      };

      // Wait for the first frame to be laid out, then scroll to the
      // selected service (if any) so its position is already known.
      if (widget.selectedService != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollToSelected();
        });
      }
    }

    void _scrollToSelected() {
      final key = _itemKeys[widget.selectedService];
      final ctx = key?.currentContext;
      if (ctx != null) {
        Scrollable.ensureVisible(
          ctx,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          alignment: 0.1,
        );
      }
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: const Color(0xFF0D0D0D),
        appBar: AppBar(
          backgroundColor: const Color(0xFF0D0D0D),
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'Our Services',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
        body: SafeArea(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: services.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final service = services[index];
              final title = service['title']!;
              final bool isSelected = widget.selectedService == title;
// return MouseRegion(
//   onEnter: (_) {
//     setState(() {
//       hoveredIndex = index;
//     });
//   },
//   onExit: (_) {
//     setState(() {
//       hoveredIndex = -1;
//     });
//   },
//   child: AnimatedContainer(
//     duration: const Duration(milliseconds: 250),
//     key: _itemKeys[title],
//     decoration: BoxDecoration(
//       color: const Color(0xFF1A1A1A),
//       borderRadius: BorderRadius.circular(16),
//       border: Border.all(
//         color: hoveredIndex == index
//             ? const Color(0xFF00C8FF)
//             : (isSelected ? Colors.orange : Colors.grey.shade800),
//         width: hoveredIndex == index ? 2 : 1,
//       ),
//      boxShadow: [],
//     ),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         ClipRRect(
//   borderRadius: const BorderRadius.only(
//     topLeft: Radius.circular(16),
//     topRight: Radius.circular(16),
//   ),
//   child: Image.asset(
//     service['image']!,
//     width: double.infinity,
//     height: 180,
//     fit: BoxFit.cover,
//   ),
// ),

//       AnimatedContainer(
//   duration: const Duration(milliseconds: 300),
//   curve: Curves.easeInOut,
//   width: double.infinity,
//   padding: const EdgeInsets.symmetric(
//     horizontal: 18,
//     vertical: 20,
//   ),
//   decoration: BoxDecoration(
//     gradient: hoveredIndex == index
//         ? const LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Color(0xFF1B2735),
//               Color(0xFF2A4D69),
//             ],
//           )
//         : const LinearGradient(
//             colors: [
//               Color(0xFF1A1A1A),
//               Color(0xFF1A1A1A),
//             ],
//           ),

//     borderRadius: const BorderRadius.only(
//       bottomLeft: Radius.circular(16),
//       bottomRight: Radius.circular(16),
//     ),

//     border: Border(
//       top: BorderSide(
//         color: hoveredIndex == index
//             ? const Color(0xFF3FA9F5)
//             : Colors.transparent,
//         width: 2,
//       ),
//     ),
//   ),

//   child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       AnimatedDefaultTextStyle(
//         duration: const Duration(milliseconds: 300),
//         style: TextStyle(
//           color: hoveredIndex == index
//               ? const Color(0xFF66E3FF)
//               : (isSelected ? Colors.orange : Colors.white),
//           fontSize: 20,
//           fontWeight: FontWeight.bold,
//         ),
//         child: Text(title),
//       ),

//       const SizedBox(height: 10),

//       AnimatedDefaultTextStyle(
//         duration: const Duration(milliseconds: 300),
//         style: TextStyle(
//           color: hoveredIndex == index
//               ? Colors.white
//               : Colors.white60,
//           fontSize: 14,
//           height: 1.6,
//         ),
//         child: Text(service['description'] ?? ''),
//       ),
//     ],
//   ),
// ),
//       ],
//     ),
//   ),
// );
return InkWell(
  borderRadius: BorderRadius.circular(16),
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ServiceDetail(
          service: service,
        ),
      ),
    );
  },
  child: Container(
    key: _itemKeys[title],
    decoration: BoxDecoration(
      color: const Color(0xFF1A1A1A),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: isSelected ? Colors.orange : Colors.grey.shade800,
        width: isSelected ? 2 : 1,
      ),
    ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // IMAGE
      ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        child: Image.asset(
          service['image']!,
          width: double.infinity,
          height: 180,
          fit: BoxFit.cover,
        ),
      ),

      // TEXT SECTION ONLY HOVER
      MouseRegion(
        onEnter: (_) {
          setState(() {
            hoveredIndex = index;
          });
        },
        onExit: (_) {
          setState(() {
            hoveredIndex = -1;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 18,
          ),
          decoration: BoxDecoration(
            color: hoveredIndex == index
                ? const Color(0xFF23395D)
                : const Color.fromARGB(255, 0, 0, 0),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 300),
                style: TextStyle(
                  color: hoveredIndex == index
                      ? const Color(0xFF6FEAFF)
                      : (isSelected ? Colors.orange : Colors.white),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                child: Text(title),
              ),

              const SizedBox(height: 10),

              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 300),
                style: TextStyle(
                  color: hoveredIndex == index
                      ? Colors.white
                      : Colors.white70,
                  fontSize: 14,
                  height: 1.5,
                ),
                child: Text(
                  service['description'] ?? '',
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  ),
  )
);
},
          ),
        ),
      );
    }
  }