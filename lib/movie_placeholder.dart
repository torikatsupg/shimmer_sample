import 'package:flutter/material.dart';
import 'package:shimmer_sample/box.dart';

class MoviePlaceholder extends StatelessWidget {
  const MoviePlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Box(height: 200, width: double.infinity),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              ClipOval(
                child: Box(height: 60, width: 60),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Box(height: 20, width: 240),
                  const SizedBox(height: 8),
                  Box(height: 20, width: 200),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
