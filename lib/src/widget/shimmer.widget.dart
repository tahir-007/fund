import 'package:flutter/material.dart';
import 'package:shimmer_pro/shimmer_pro.dart';

class ShimmerContent extends StatefulWidget {
  const ShimmerContent({super.key});

  @override
  State<ShimmerContent> createState() => _ShimmerContentState();
}

class _ShimmerContentState extends State<ShimmerContent> {
  // Initialize ShimmerProLight with a default value
  ShimmerProLight shimmerlight = ShimmerProLight.darker;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Update shimmer light based on platform brightness (light or dark)
    updateShimmerLight();
  }

  void updateShimmerLight() {
    // Detect platform brightness (light or dark)
    final brightness = MediaQuery.of(context).platformBrightness;
    setState(() {
      // Set shimmer light based on platform brightness
      shimmerlight = brightness == Brightness.light
          ? ShimmerProLight.darker
          : ShimmerProLight.lighter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        // AppBar with a shimmering leading icon as a loading placeholder
        leading: ShimmerPro.sized(
          light: shimmerlight,
          scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
          height: 100,
          width: 100,
          borderRadius: 50,
        ),
      ),
      body: Column(
        children: [
          // Card Widget 1 with shimmering placeholders
          Card(
            margin: const EdgeInsets.all(10),
            elevation: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Shimmering image placeholder
                ShimmerPro.sized(
                  light: shimmerlight,
                  scaffoldBackgroundColor:
                      Theme.of(context).scaffoldBackgroundColor,
                  height: 250,
                  width: 500,
                ),
                // Shimmering row with circular avatar and text placeholder
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    // Shimmering circular avatar as a loading placeholder
                    ShimmerPro.sized(
                      light: shimmerlight,
                      scaffoldBackgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      height: 70,
                      width: 70,
                      borderRadius: 50,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Shimmering text placeholder
                        ShimmerPro.text(
                          light: shimmerlight,
                          width: 225,
                          scaffoldBackgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Card Widget 2 with shimmering placeholders (similar to Card 1)
          Card(
            margin: const EdgeInsets.all(10),
            elevation: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerPro.sized(
                  light: shimmerlight,
                  scaffoldBackgroundColor:
                      Theme.of(context).scaffoldBackgroundColor,
                  height: 250,
                  width: 500,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    ShimmerPro.sized(
                      light: shimmerlight,
                      scaffoldBackgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      height: 70,
                      width: 70,
                      borderRadius: 50,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShimmerPro.text(
                          light: shimmerlight,
                          width: 225,
                          scaffoldBackgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
