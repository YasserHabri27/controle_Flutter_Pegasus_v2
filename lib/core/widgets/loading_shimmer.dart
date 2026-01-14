import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class LoadingShimmer extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const LoadingShimmer.rectangular({
    super.key,
    this.width = double.infinity,
    required this.height,
  }) : shapeBorder = const RoundedRectangleBorder();

  const LoadingShimmer.circular({
    super.key,
    required this.width,
    required this.height,
    this.shapeBorder = const CircleBorder(),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Shimmer.fromColors(
      baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
      highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: ShapeDecoration(
          color: Colors.grey[400],
          shape: shapeBorder,
        ),
      ),
    );
  }
}

class TaskListShimmer extends StatelessWidget {
  const TaskListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 1.5.h),
          child: Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                LoadingShimmer.circular(width: 6.w, height: 6.w),
                SizedBox(width: 4.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LoadingShimmer.rectangular(height: 2.h, width: 60.w),
                      SizedBox(height: 1.h),
                      LoadingShimmer.rectangular(height: 1.5.h, width: 40.w),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
