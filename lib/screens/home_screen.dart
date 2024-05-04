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
      title: SafeArea(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ),
    body: SafeArea(
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: state.searchController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  hintText: state.changedQuery,
                ),
                onChanged: (value) {
                  context
                      .read<PixabayBloc>()
                      .add(PixabayChangeUpdateEvent(value));
                },
              ),
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
          if (state.bottomLoader) const LinearProgressIndicator(),
        ],
      ),
    ),
  );
}
