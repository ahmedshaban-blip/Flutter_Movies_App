abstract class DetailsState {}

class DetailsInitial extends DetailsState {}

class DetailsLoading extends DetailsState {}

class DetailsSuccess extends DetailsState {
  // final result;
  // Success(this.result);
}

class DetailsFailure extends DetailsState {
  final String error;
  DetailsFailure(this.error);
}
