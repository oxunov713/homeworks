import 'package:flutter/material.dart';
import 'package:homeworks/pages/widgets/if_offline.dart';

import '../../controller/main_controller.dart';
import '../../utils/connection.dart';
import 'future_nature.dart';

class Nature extends StatefulWidget {
  const Nature({super.key, required this.controller});

  final MainController controller;

  @override
  State<Nature> createState() => _NatureState();
}

class _NatureState extends State<Nature> {
  int pageNumber = 2;

  final List<Widget> _listFuture = [];

  bool _isInternetAvailable = false;

  @override
  void initState() {super.initState(); initializeInternetConnection();
    _listFuture.add(
      CustomFutureNature(
        controller: widget.controller,
        pageNumber: 1,
      ),
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
                CustomFutureNature(
                    controller: widget.controller, pageNumber: pageNumber),
              );
              pageNumber++;
            });
          },
          backgroundColor: Colors.deepOrange,
          child: const Icon(Icons.add),
        ),
      );
    } else {
      return const IfOffline(assetImage: "assets/images/nature.jpg");
    }
  }
}
