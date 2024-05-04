import 'package:flutter/material.dart';
import 'package:pixabay/bloc/pixabay_bloc.dart';

Widget buildImageCard(PixabayLoadedState state, int index) {
  return Padding(
    padding: const EdgeInsets.all(5),
    child: Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: NetworkImage(
                  state.images[index].previewURL!,
                ),
                fit: BoxFit.cover,
              ),
            ),
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
