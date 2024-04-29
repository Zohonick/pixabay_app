part of 'pixabay_bloc.dart';

@immutable
abstract class PixabayEvent {}

class PixabayInitialEvent extends PixabayEvent {}

class PixabayUpdateEvent extends PixabayEvent {}

class PixabayChangeUpdateEvent extends PixabayEvent {
  PixabayChangeUpdateEvent(this.query);

  final String query;
}
