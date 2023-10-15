import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../controller/main_controller.dart';
import '../widgets/custom_appbar.dart';
import 'custom_future_search.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required this.controller});

  final MainController controller;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int _pageNumber = 1;

  final List<Widget> _listFuture = [];

  String _searchText = 'Love';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.deepOrangeAccent,
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: ListView(
            children: [
              const CustomAppBar(),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
                child: SearchBar(
                  leading: const Icon(CupertinoIcons.search),
                  hintText: "Search your favourite pictures",
                  hintStyle: MaterialStateProperty.all(
                    const TextStyle(color: Colors.blueGrey),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _listFuture.clear();
                      _searchText = value;
                      if (value == '') {
                        _searchText = 'car';
                      }
                      if (widget.controller.photoModel != null) {
                        int maxIndex =
                            widget.controller.photoModel!.results!.length - 2;
                        int startIndex = _pageNumber - 1;
                        int endIndex = startIndex + 1;
                        if (startIndex >= 0 && endIndex <= maxIndex) {
                          _listFuture.add(
                            CustomSearch(
                              searchText: _searchText,
                              controller: widget.controller,
                              pageNumber: _pageNumber,
                            ),
                          );
                        }
                      }
                    });
                  },
                ),
              ),
              Column(
                children: _listFuture,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _listFuture.add(
                CustomSearch(
                  searchText: _searchText,
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
      ),
    );
  }
}
