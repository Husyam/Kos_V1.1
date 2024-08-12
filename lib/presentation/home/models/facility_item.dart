import 'package:flutter/material.dart';
import 'package:kos_mobile_v2_testing/presentation/home/widgets/theme.dart';

import '../../../core/assets/assets.gen.dart';

class FacilityItem extends StatelessWidget {
  final String name;
  final String imageUrl;
  // final int total;

  final List<String> fasilitas = [
    Assets.images.iconAc.path,
    Assets.images.wifi.path,
    Assets.images.refrigerator.path,
    Assets.images.bedroom.path,
    Assets.images.smokingArea.path,
    Assets.images.tv.path,
    Assets.images.toilet.path,
  ];

  FacilityItem({
    super.key,
    required this.imageUrl,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          imageUrl,
          width: 32,
        ),
        const SizedBox(
          height: 8, // this adds some space between the image and the text
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 4,
            vertical: 4,
          ), // add space to the left and right
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: ' $name',
                  style: greyRegularTextStyle.copyWith(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
