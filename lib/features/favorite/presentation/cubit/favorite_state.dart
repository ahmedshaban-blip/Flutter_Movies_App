abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final result;
  FavoriteLoaded(this.result);
}

class FavoriteRemoved extends FavoriteState {
  final result;
  FavoriteRemoved(this.result);
}

class FavoriteFailure extends FavoriteState {
  final String error;
  FavoriteFailure(this.error);
}
