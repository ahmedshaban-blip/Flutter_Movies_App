import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/favorite/presentation/pages/shared_pref.dart';
import 'package:movie_app/features/home/data/models/home_model.dart';
import 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());

  final SharedPref sharedPref = SharedPref();
  Future<void> removeMovie(Movie movie) async {
    emit(FavoriteLoading());
    try {
      final result = await sharedPref.removeFromFav(movie);

      emit(FavoriteLoaded(result));
      // emit(FavoriteSuccess(result));
    } catch (e) {
      emit(FavoriteFailure(e.toString()));
    }
  }

  Future<void> getMovies() async {
    emit(FavoriteLoading());
    try {
      final result = await sharedPref.getFav();
      emit(FavoriteLoaded(result));
    } catch (e) {
      emit(FavoriteFailure(e.toString()));
    }
  }
}
