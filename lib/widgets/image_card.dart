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
        alignment: Alignment.bottomCenter,
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
          buildImageInfo(state, index),
        ],
      ),
    ),
  );
}

Widget buildImageInfo(PixabayLoadedState state, int index) {
  const textStile = TextStyle(color: Colors.white, fontSize: 10);

  return Container(
    height: 20,
    decoration: const BoxDecoration(
      color: Colors.blueGrey,
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
    ),
    child: Row(
      children: [
        const SizedBox(
          width: 14,
        ),
        const Icon(
          Icons.thumb_up_alt_sharp,
          color: Colors.white,
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
          color: Colors.white,
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
