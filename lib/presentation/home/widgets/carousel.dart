import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class CarouselSliderWithDots extends StatefulWidget {
  final List<String> items;

  const CarouselSliderWithDots({
    super.key,
    this.items = const [],
  });

  @override
  State<CarouselSliderWithDots> createState() => _CarouselSliderWithDotsState();
}

class _CarouselSliderWithDotsState extends State<CarouselSliderWithDots> {
  late CarouselSliderController controller;
  int currentIndex = 0;

  @override
  void initState() {
    controller = CarouselSliderController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        CarouselSlider(
          carouselController: controller,
          items: widget.items
              .map(
                (item) => Image.network(
                  item,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 310.0,
                ),
              )
              .toList(),
          options: CarouselOptions(
            height: 310.0,
            viewportFraction: 1,
            autoPlayAnimationDuration: const Duration(milliseconds: 300),
            autoPlay: true,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
        ),
        Positioned(
          bottom: 20.0,
          child: DotsIndicator(
            dotsCount: widget.items.length,
            position: currentIndex,
            onTap: (index) {
              controller.animateToPage(index);
            },
            decorator: DotsDecorator(
              color: Colors.white,
              activeColor: const Color.fromARGB(255, 219, 146, 20),
              size: const Size.square(12.0),
              activeSize: const Size(24.0, 12.0),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
