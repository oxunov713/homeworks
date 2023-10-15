import 'package:flutter/material.dart';

import '../../controller/main_controller.dart';
import 'custom_dialog.dart';
import 'images.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.controller, required this.n});

  final MainController controller;
  final int n;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: GestureDetector(
            onLongPress: () => showDialog(
              context: context,
              builder: (context) =>
                  CustomDownload(controller: controller, n: n),
            ),
            child: CustomImages(controller: controller, n: n),
          ),
        ),
        Expanded(
          flex: 1,
          child: GestureDetector(
            onLongPress: () => showDialog(
              context: context,
              builder: (context) =>
                  CustomDownload(controller: controller, n: n + 1),
            ),
            child: CustomImages(controller: controller, n: n + 1),
          ),
        ),
      ],
    );
  }
}
