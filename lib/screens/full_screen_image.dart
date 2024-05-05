import 'package:flutter/material.dart';

import '../Repository/entity/images_data_entity.dart';

class FullScreenImage extends StatelessWidget {
  const FullScreenImage({super.key, required this.imageData});

  final Hits imageData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade300,
        title: Text(
          imageData.tags ?? '',
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: SafeArea(
          child: Center(
            child: Image.network(
              imageData.largeImageURL ?? '',
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                return loadingProgress == null
                    ? child
                    : const CircularProgressIndicator();
              },
            ),
          ),
        ),
      ),
    );
  }
}
