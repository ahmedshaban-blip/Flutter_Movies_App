abstract class UpcomingState {}

class UpcomingInitial extends UpcomingState {}

class UpcomingLoading extends UpcomingState {}

class UpcomingSuccess extends UpcomingState {
  final result;
  UpcomingSuccess(this.result);
}

class UpcomingFailure extends UpcomingState {
  final String error;
  UpcomingFailure(this.error);
}
