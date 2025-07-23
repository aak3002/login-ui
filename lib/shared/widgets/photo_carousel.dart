import 'package:flutter/material.dart';
import '../../core/constants/app_dimensions.dart';

class PhotoCarousel
    extends StatefulWidget {
  final List<String>
      topRowImages;
  final List<String>
      bottomRowImages;
  final Duration
      animationDuration;

  const PhotoCarousel({
    super.key,
    required this.topRowImages,
    required this.bottomRowImages,
    this.animationDuration =
        const Duration(seconds: 20),
  });

  @override
  State<PhotoCarousel> createState() =>
      _PhotoCarouselState();
}

class _PhotoCarouselState
    extends State<PhotoCarousel>
    with
        TickerProviderStateMixin {
  late AnimationController
      _topRowController;
  late AnimationController
      _bottomRowController;
  late Animation<Offset>
      _topRowAnimation;
  late Animation<Offset>
      _bottomRowAnimation;

  @override
  void
      initState() {
    super.initState();

    // Initialize animation controllers
    _topRowController =
        AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _bottomRowController =
        AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    // Create animations for seamless horizontal movement
    _topRowAnimation =
        Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(-0.33, 0.0),
    ).animate(CurvedAnimation(
      parent: _topRowController,
      curve: Curves.linear,
    ));

    _bottomRowAnimation =
        Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(0.33, 0.0),
    ).animate(CurvedAnimation(
      parent: _bottomRowController,
      curve: Curves.linear,
    ));

    // Start animations
    _topRowController.repeat();
    _bottomRowController.repeat();
  }

  @override
  Widget
      build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          // Top row moving right
          Expanded(
            child: OverflowBox(
              maxWidth: double.infinity,
              child: SlideTransition(
                position: _topRowAnimation,
                child: Row(
                  children: [
                    // First complete cycle
                    ...widget.topRowImages.map((image) => _buildPhotoCard(image)),
                    // Second complete cycle (for seamless loop)
                    ...widget.topRowImages.map((image) => _buildPhotoCard(image)),
                    // Third complete cycle
                    ...widget.topRowImages.map((image) => _buildPhotoCard(image)),
                    // Fourth complete cycle (extra buffer for seamless loop)
                    ...widget.topRowImages.map((image) => _buildPhotoCard(image)),
                  ],
                ),
              ),
            ),
          ),
          // Bottom row moving left
          Expanded(
            child: OverflowBox(
              maxWidth: double.infinity,
              child: SlideTransition(
                position: _bottomRowAnimation,
                child: Row(
                  children: [
                    // First complete cycle
                    ...widget.bottomRowImages.map((image) => _buildPhotoCard(image)),
                    // Second complete cycle (for seamless loop)
                    ...widget.bottomRowImages.map((image) => _buildPhotoCard(image)),
                    // Third complete cycle
                    ...widget.bottomRowImages.map((image) => _buildPhotoCard(image)),
                    // Fourth complete cycle (extra buffer for seamless loop)
                    ...widget.bottomRowImages.map((image) => _buildPhotoCard(image)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget
      _buildPhotoCard(String imagePath) {
    return Container(
      width: AppDimensions.photoCardWidth,
      height: AppDimensions.photoCardHeight,
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.photoCardBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  void
      dispose() {
    _topRowController.dispose();
    _bottomRowController.dispose();
    super.dispose();
  }
}
