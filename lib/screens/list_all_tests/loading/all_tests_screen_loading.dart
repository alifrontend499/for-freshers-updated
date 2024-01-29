import 'package:flutter/material.dart';

// -- packages
import 'package:shimmer/shimmer.dart';

class ScreenLoading extends StatefulWidget {
  const ScreenLoading({Key? key}) : super(key: key);

  @override
  State<ScreenLoading> createState() => _ScreenLoadingState();
}

class _ScreenLoadingState extends State<ScreenLoading> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[200]!,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              height: 85,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
