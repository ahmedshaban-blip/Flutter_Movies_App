import 'package:flutter_bloc/flutter_bloc.dart';
import 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit() : super(DetailsInitial());

  Future<void> doSomething() async {
    emit(DetailsLoading());
    try {
      // Call usecase
      // emit(DetailsSuccess(result));
    } catch (e) {
      emit(DetailsFailure(e.toString()));
    }
  }
}
