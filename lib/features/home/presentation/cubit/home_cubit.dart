import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/network/movies_api.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  ApiClient apiClient = ApiClient();
  Future<void> doSomething() async {
    emit(HomeLoading());
    try {
      // Call usecase
      // emit(HomeSuccess(result));
      final result = await apiClient.fetchMovies();

      print(result);
      emit(HomeSuccess(result));
      return;
    } catch (e) {
      emit(HomeFailure(e.toString()));
    }
  }
}
