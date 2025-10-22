abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteSuccess extends FavoriteState {
  // final result;
  // Success(this.result);
}

class FavoriteFailure extends FavoriteState {
  final String error;
  FavoriteFailure(this.error);
}
