import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({super.key});

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: const Color.fromARGB(255, 204, 204, 204),
          highlightColor: const Color.fromARGB(255, 233, 233, 233),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(15)),
            width: width * 0.25,
            height: 25,
          ),
        ),
        Shimmer.fromColors(
          baseColor: const Color.fromARGB(255, 204, 204, 204),
          highlightColor: const Color.fromARGB(255, 233, 233, 233),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(15)),
              width: width * 0.95,
              height: 75,
            ),
          ),
        )
      ],
    );
  }
}
