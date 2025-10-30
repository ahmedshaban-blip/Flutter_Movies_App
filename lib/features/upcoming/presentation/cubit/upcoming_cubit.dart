import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/network/movies_api.dart';

import 'upcoming_state.dart';

class UpcomingCubit extends Cubit<UpcomingState> {
  UpcomingCubit() : super(UpcomingInitial());
  ApiClient apiClient = ApiClient();

  Future<void> doSomething() async {
    emit(UpcomingLoading());
    try {
      // Call usecase
      // emit(UpcomingSuccess(result));
      final result = await apiClient.fetchUpcomingMovies();
      emit(UpcomingSuccess(result));
    } catch (e) {
      emit(UpcomingFailure(e.toString()));
    }
  }
}
