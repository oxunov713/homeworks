import 'package:flutter/material.dart';
import 'package:homeworks/pages/widgets/if_offline.dart';

import '../../controller/main_controller.dart';
import '../../utils/connection.dart';
import 'future_buildings.dart';

class Buildings extends StatefulWidget {
  const Buildings({super.key, required this.controller});

  final MainController controller;

  @override
  State<Buildings> createState() => _BuildingsState();
}

class _BuildingsState extends State<Buildings> {
  int _pageNumber = 2;

  final List<Widget> _listFuture = [];

  bool _isInternetAvailable = false;

  @override
  void initState() {
    _listFuture.add(
      CustomFutureBuildings(controller: widget.controller, pageNumber: 1),
    );
    super.initState();
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
                CustomFutureBuildings(
                  controller: widget.controller,
                  pageNumber: _pageNumber,
                ),
              );
              _pageNumber++;
            });
          },
          backgroundColor: Colors.deepOrange,
          child: const Icon(Icons.add),
        ),
      );
    } else {
      return const IfOffline(assetImage: "assets/images/buildings.jpg");
    }
  }
}
