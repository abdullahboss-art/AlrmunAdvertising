import 'package:flutter/material.dart';

class SubscriptionsPage extends StatelessWidget {
  const SubscriptionsPage({super.key});

  static const Color bg = Color(0xff0D0D0D);
  static const Color card = Color(0xff171717);
  static const Color cyan = Color(0xff18D4D9);
  static const Color text = Colors.white;
  static const Color textDim = Colors.white70;
  static const Color border = Color(0xff292929);

  void _subscribe(
    BuildContext context,
    String plan,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: card,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Subscription',
            style: TextStyle(
              color: text,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            '$plan plan selected.\n\nPayment integration will be connected here.',
            style: const TextStyle(
              color: textDim,
              height: 1.5,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Continue',
                style: TextStyle(
                  color: cyan,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,

      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'SUBSCRIPTION PLANS',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          20,
          20,
          20,
          35,
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            // HEADER
            const Text(
              'Choose Your Plan',
              style: TextStyle(
                color: text,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Unlock premium services and get access '
              'to everything you need.',
              style: TextStyle(
                color: textDim,
                fontSize: 14,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 28),

            // BASIC PLAN
            _PlanCard(
              title: 'Basic',
              price: '\$29',
              period: '/ month',
              description:
                  'Perfect for basic creative requirements.',
              features: const [
                'Logo Design',
                'Brand Identity',
                'Business Card Design',
                'Basic Graphic Design',
              ],
              buttonText: 'Subscribe',
              onPressed: () {
                _subscribe(
                  context,
                  'Basic',
                );
              },
            ),

            const SizedBox(height: 18),

            // PREMIUM PLAN
            _PlanCard(
              title: 'Premium',
              price: '\$79',
              period: '/ month',
              description:
                  'Get access to our complete creative services.',
              features: const [
                'All Graphic Design Services',
                'Animation & Media',
                'Video Editing',
                'Motion Graphics',
                '3D Visualization',
                'Digital & Offset Services',
              ],
              buttonText: 'Subscribe Now',
              isPopular: true,
              onPressed: () {
                _subscribe(
                  context,
                  'Premium',
                );
              },
            ),

            const SizedBox(height: 18),

            // BUSINESS PLAN
            _PlanCard(
              title: 'Business',
              price: '\$149',
              period: '/ month',
              description:
                  'Best choice for businesses and agencies.',
              features: const [
                'Everything in Premium',
                'Priority Support',
                'Corporate Services',
                'Advanced 3D Visualization',
                'Premium Media Services',
                'Dedicated Assistance',
              ],
              buttonText: 'Choose Business',
              onPressed: () {
                _subscribe(
                  context,
                  'Business',
                );
              },
            ),

            const SizedBox(height: 30),

            // INFO
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xff121212),
                borderRadius:
                    BorderRadius.circular(16),
                border: Border.all(
                  color: border,
                ),
              ),
              child: const Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.lock_outline,
                    color: cyan,
                    size: 21,
                  ),

                  SizedBox(width: 12),

                  Expanded(
                    child: Text(
                      'Premium services are available '
                      'only for users with an active subscription.',
                      style: TextStyle(
                        color: textDim,
                        fontSize: 12.5,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// PLAN CARD
// ============================================================

class _PlanCard extends StatelessWidget {
  final String title;
  final String price;
  final String period;
  final String description;
  final List<String> features;
  final String buttonText;
  final bool isPopular;
  final VoidCallback onPressed;

  const _PlanCard({
    required this.title,
    required this.price,
    required this.period,
    required this.description,
    required this.features,
    required this.buttonText,
    required this.onPressed,
    this.isPopular = false,
  });

  static const Color card =
      Color(0xff171717);

  static const Color cyan =
      Color(0xff18D4D9);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: card,
        borderRadius:
            BorderRadius.circular(22),
        border: Border.all(
          color: isPopular
              ? cyan
              : const Color(0xff292929),
          width: isPopular ? 1.4 : 1,
        ),
        boxShadow: isPopular
            ? [
                BoxShadow(
                  color:
                      cyan.withOpacity(0.10),
                  blurRadius: 20,
                  offset:
                      const Offset(0, 8),
                ),
              ]
            : null,
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [

          // POPULAR BADGE
          if (isPopular)
            Container(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: cyan,
                borderRadius:
                    BorderRadius.circular(20),
              ),
              child: const Text(
                'MOST POPULAR',
                style: TextStyle(
                  color: Color(0xff04222A),
                  fontSize: 10,
                  fontWeight:
                      FontWeight.bold,
                  letterSpacing: .5,
                ),
              ),
            ),

          if (isPopular)
            const SizedBox(height: 16),

          // TITLE
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          // PRICE
          Row(
            crossAxisAlignment:
                CrossAxisAlignment.end,
            children: [
              Text(
                price,
                style: const TextStyle(
                  color: cyan,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(width: 5),

              Padding(
                padding:
                    const EdgeInsets.only(
                  bottom: 5,
                ),
                child: Text(
                  period,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Text(
            description,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 20),

          const Divider(
            color: Color(0xff292929),
          ),

          const SizedBox(height: 12),

          // FEATURES
          ...features.map(
            (feature) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(
                  vertical: 7,
                ),
                child: Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: cyan,
                      size: 19,
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: Text(
                        feature,
                        style:
                            const TextStyle(
                          color:
                              Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          const SizedBox(height: 18),

          // BUTTON
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: onPressed,
              style:
                  ElevatedButton.styleFrom(
                backgroundColor: cyan,
                foregroundColor:
                    const Color(0xff04222A),
                elevation: 0,
                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(
                    28,
                  ),
                ),
              ),
              child: Text(
                buttonText,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}