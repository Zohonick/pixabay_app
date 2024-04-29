import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixabay/bloc/pixabay_bloc.dart';
import 'package:pixabay/screens/full_screen_image.dart';
import 'package:pixabay/utils/utils.dart';
import 'package:pixabay/widgets/image_card.dart';

Scaffold buildHomeScreen(
    BuildContext context, String title, PixabayLoadedState state) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.blueGrey.shade300,
      title: Text(title),
    ),
    body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: TextField(
            controller: state.searchController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              hintText: 'Enter search query',
            ),
            onChanged: (value) {
              context.read<PixabayBloc>().add(PixabayChangeUpdateEvent(value));
            },
          ),
        ),
        if (state.images.isNotEmpty)
          Expanded(
            child: GridView.builder(
              controller: state.scrollController,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: calculateColumns(context)),
              itemCount: state.images.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FullScreenImage(
                            imageUrl: state.images[index].largeImageURL!),
                      ),
                    );
                  },
                  child: buildImageCard(state, index),
                );
              },
            ),
          )
        else
          Text('Nothing was found for your request: "${state.changedQuery}"'),
        if (state.bottomLoader)
          const CircularProgressIndicator(
            strokeWidth: 8,
          ),
      ],
    ),
  );
}
