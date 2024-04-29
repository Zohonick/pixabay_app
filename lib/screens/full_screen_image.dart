import 'package:flutter/material.dart';
import 'package:pixabay/widgets/loader_widget.dart';

class FullScreenImage extends StatelessWidget {
  const FullScreenImage({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Image.network(
            imageUrl,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              return loadingProgress == null ? child : buildLoader();
            },
          ),
        ),
      ),
    );
  }
}
