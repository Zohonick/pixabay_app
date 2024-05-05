import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:pixabay/Repository/entity/images_data_entity.dart';
import 'package:pixabay/main.dart';
import 'package:pixabay/Repository/pixabay_repository.dart';
import 'package:word_generator/word_generator.dart';

part 'pixabay_event.dart';

part 'pixabay_state.dart';

bool isStateIndicator = false;

class PixabayBloc extends Bloc<PixabayEvent, PixabayState> {
  final repository = getIt<PixabayRepository>();
  final logger = getIt<Logger>();
  final wordGenerator = WordGenerator();

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  List<Hits> _images = [];
  static const defaultPage = 1;
  int page = defaultPage;
  String? changedQuery;

  PixabayBloc() : super(PixabayInitialState()) {
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        add(PixabayUpdateEvent());
      }
    });

    on<PixabayInitialEvent>((event, emit) async {
      emit(PixabayLoadingState());
      await fetchData(randomQuery(), false);
      emit(PixabayLoadedState(
          _images, _scrollController, _searchController, false, changedQuery!));
    });

    on<PixabayUpdateEvent>((event, emit) async {
      emit(PixabayLoadedState(_images, _scrollController, _searchController,
          true, changedQuery ?? ''));
      await fetchData(changedQuery ?? randomQuery(), false);
      emit(PixabayLoadedState(_images, _scrollController, _searchController,
          false, changedQuery ?? ''));
    });

    on<PixabayChangeUpdateEvent>((event, emit) async {
      sendAnalytics(event.query);
      isStateIndicator == !isStateIndicator;
      changedQuery = event.query;
      page = defaultPage;
      await fetchData(event.query.isEmpty ? randomQuery() : event.query, true);
      emit(PixabayLoadedState(
          _images, _scrollController, _searchController, false, event.query));
    });
  }

  Future<void> fetchData(String query, bool newChange) async {
    final data = await repository.fetchImagesData(query, page);
    if (data?.hits != null) {
      if (newChange) {
        _scrollController.animateTo(0.0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
        _images = data!.hits!;
      } else {
        _images.addAll(data!.hits!);
      }
      page++;
    } else {
      logger.e('data is null');
    }
  }

  String randomQuery() {
    changedQuery = wordGenerator.randomNoun();
    return changedQuery!;
  }

  void sendAnalytics(String query) {
    //TODO add some analytics method
    logger.d('query: $query');
  }
}
