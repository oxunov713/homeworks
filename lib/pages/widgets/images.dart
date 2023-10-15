import 'package:flutter/material.dart';
import 'package:homeworks/controller/main_controller.dart';

class CustomImages extends StatelessWidget {
  const CustomImages({super.key, required this.controller, required this.n});

  final MainController? controller;
  final int n;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: SizedBox(
        height: 200,
        width: 200,
        child: Image(
          fit: BoxFit.fill,
          image: NetworkImage(
              "${controller?.photoModel!.results?[n].urls?.small}"),
        ),
      ),
    );
  }
}
