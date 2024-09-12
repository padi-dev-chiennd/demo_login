import 'dart:io';

import 'package:demologin/home/image_model.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final ImageModel imageModel;

  const DetailScreen({super.key, required this.imageModel});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Image.file(File(widget.imageModel.path),
            width: double.infinity, height: double.infinity, fit: BoxFit.cover),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 30, 0, 0),
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
        )
      ],
    ));
  }
}
