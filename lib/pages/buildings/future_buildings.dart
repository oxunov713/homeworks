import 'package:flutter/material.dart';

import '../../controller/main_controller.dart';
import '../widgets/cart.dart';

class CustomFutureBuildings extends StatelessWidget {
  const CustomFutureBuildings({
    super.key,
    required this.controller,
    required this.pageNumber,
  });

  final MainController controller;
  final int pageNumber;
  final String _search = 'buildings';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:
            controller.getPhoto(title: _search, page: pageNumber.toString()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                CustomCard(controller: controller, n: 0),
                CustomCard(controller: controller, n: 2),
                CustomCard(controller: controller, n: 4),
                CustomCard(controller: controller, n: 6),
                CustomCard(controller: controller, n: 8),
              ],
            );
          } else {
            return const Center(child: LinearProgressIndicator());
          }
        });
  }
}
