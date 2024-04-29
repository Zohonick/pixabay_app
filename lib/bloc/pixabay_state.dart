part of 'pixabay_bloc.dart';

@immutable
abstract class PixabayState {}

class PixabayInitialState extends PixabayState {}

class PixabayLoadingState extends PixabayState {}

class PixabayLoadedState extends PixabayState {
  PixabayLoadedState(this.images, this.scrollController, this.searchController,
      this.bottomLoader, this.changedQuery);

  final List<Hits> images;
  final ScrollController scrollController;
  final TextEditingController searchController;
  final bool bottomLoader;
  final String changedQuery;
}
