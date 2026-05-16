import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../utils/app_colors.dart';

class ImageShimmer extends StatelessWidget {
  final double width;
  final double height;

  const ImageShimmer({
    Key? key,
    this.width = double.infinity,
    this.height = 200,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.sageLight.withOpacity(0.3),
      highlightColor: AppColors.cream,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.sageLight,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}

class GridShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return ImageShimmer(height: 250);
      },
    );
  }
}
