import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../controller/main_controller.dart';
import '../../data/photo_repos.dart';
import '../buildings/buildings.dart';
import '../cars/cars.dart';
import '../nature/nature.dart';
import '../search_page/search.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final MainController _controller;
  bool hasInternet = true;
  @override
  void initState() {
    super.initState();
    _controller = MainController(photoRepository: PhotoRepository());
    checkInternetConnection();
  }

  Future<void> checkInternetConnection() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {

      setState(() {
        hasInternet = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.deepOrangeAccent,
        appBar: AppBar(
          title: const Text("Your lovely photos"),
          backgroundColor: Colors.deepOrange,
          actions: [
            IconButton(
              icon: const Icon(CupertinoIcons.search),
              onPressed: () {
                if (!hasInternet) {
                  // İnternet bağlantısı yoksa uyarı göster
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Internet yo'q"),
                        content: const Text("Internetingizni yoqing"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("OK"),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchPage(controller: _controller),
                    ),
                  );
                }
              },
            ),
            PopupMenuButton(itemBuilder: (context) => []),
          ],
        ),
        body: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              const TabBar(
                indicatorColor: Colors.white,
                tabs: [
                  Tab(icon: Icon(CupertinoIcons.car_detailed), text: "Cars"),
                  Tab(icon: Icon(CupertinoIcons.tree), text: "Nature"),
                  Tab(
                      icon: Icon(CupertinoIcons.building_2_fill),
                      text: "Buildings"),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Cars(controller: _controller),
                    Nature(controller: _controller),
                    Buildings(controller: _controller),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
