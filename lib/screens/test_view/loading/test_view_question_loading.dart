import 'package:flutter/material.dart';

// -- package | shimmer
import 'package:shimmer/shimmer.dart';


class TestViewQuestionLoading extends StatelessWidget {
  const TestViewQuestionLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[200]!,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                height: 11,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              const SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.all(20),
                height: 11,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              const SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.all(20),
                height: 11,
                width: 190,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              const SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.all(20),
                height: 11,
                width: 240,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              const SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.all(20),
                height: 11,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),

              const SizedBox(height: 50),
            ],
          ),
        )
    );
  }
}
