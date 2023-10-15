import 'package:flutter/material.dart';
import 'package:homeworks/pages/widgets/if_offline.dart';

import '../../controller/main_controller.dart';
import '../../utils/connection.dart';
import 'future_car.dart';

class Cars extends StatefulWidget {
  const Cars({super.key, required this.controller});

  final MainController controller;

  @override
  State<Cars> createState() => _CarsState();
}

class _CarsState extends State<Cars> {
  int _pageNumber = 2;
  final List<Widget> _listFuture = [];
  bool _isInternetAvailable = false;

  @override
  void initState() {
    super.initState();
    initializeInternetConnection();
    _listFuture.add(
      CustomFutureCar(controller: widget.controller, pageNumber: 1),
    );
  }

  Future<void> initializeInternetConnection() async {
    bool internetAvailable = await checkInternetConnection();
    setState(() {
      _isInternetAvailable = internetAvailable;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isInternetAvailable) {
      return Scaffold(
        backgroundColor: Colors.white54,
        body: ListView(
          children: [
            Column(children: _listFuture),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _listFuture.add(
                CustomFutureCar(
                    controller: widget.controller, pageNumber: _pageNumber),
              );
              _pageNumber++;
            });
          },
          backgroundColor: Colors.deepOrange,
          child: const Icon(Icons.add),
        ),
      );
    } else {
      return const IfOffline(assetImage: "assets/images/car.jpg");
    }
  }
}
