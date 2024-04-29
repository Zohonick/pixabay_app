import 'package:flutter/material.dart';
import 'package:pixabay/bloc/pixabay_bloc.dart';

Widget buildImageCard(PixabayLoadedState state, int index) {
  return Padding(
    padding: const EdgeInsets.all(5),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blueGrey.shade300,
          width: 3,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Stack(
        children: [
          Center(
            child: Image.network(state.images[index].previewURL!),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: buildImageInfo(state, index),
          ),
        ],
      ),
    ),
  );
}

Container buildImageInfo(PixabayLoadedState state, int index) {
  const textStile = TextStyle(color: Colors.grey, fontSize: 10);

  return Container(
    alignment: Alignment.bottomCenter,
    child: Row(
      children: [
        const SizedBox(
          width: 8,
        ),
        const Icon(
          Icons.thumb_up_alt_sharp,
          color: Colors.grey,
          size: 14,
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          state.images[index].likes.toString(),
          style: textStile,
        ),
        const SizedBox(
          width: 8,
        ),
        const Icon(
          Icons.remove_red_eye,
          color: Colors.grey,
          size: 14,
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          state.images[index].views.toString(),
          style: textStile,
        ),
      ],
    ),
  );
}
