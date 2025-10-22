import 'package:flutter_bloc/flutter_bloc.dart';
import 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());

  Future<void> doSomething() async {
    emit(FavoriteLoading());
    try {
      // Call usecase
      // emit(FavoriteSuccess(result));
    } catch (e) {
      emit(FavoriteFailure(e.toString()));
    }
  }
}
