import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';

import '../../controller/main_controller.dart';


void okButton(BuildContext context) => Navigator.pop(context);

class CustomDownload extends StatelessWidget {
  const CustomDownload({super.key, required this.controller, required this.n});

  final MainController controller;
  final int n;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text("Ushbu rasmni yuklab olmoqchimisiz"),
      content: Text("${controller.photoModel?.results?[n].altDescription}"),
      actions: [
        MaterialButton(
          onPressed: () {
            GallerySaver.saveImage(
              "${controller.photoModel?.results?[n].links?.download}.jpg",
              toDcim: true,
              albumName: "Only the best",
            );
            okButton(context);
          },
          child: const Text("Ok"),
        ),
        MaterialButton(
          onPressed: () {
            okButton(context);
          },
          child: const Text("No"),
        ),
      ],
    );
  }
}
