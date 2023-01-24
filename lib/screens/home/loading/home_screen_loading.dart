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
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // child | top part
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                // child | left
                Container(
                  padding: const EdgeInsets.all(20),
                  height: 25,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),

                // child | right
                Expanded(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      height: 20,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.all(20),
              height: 100,
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
