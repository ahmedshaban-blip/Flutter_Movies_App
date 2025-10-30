import '../../domain/repositories/upcoming_repository.dart';
import '../datasources/upcoming_remote_datasource.dart';

class UpcomingRepositoryImpl implements UpcomingRepository {
  final UpcomingRemoteDataSource remoteDataSource;

  UpcomingRepositoryImpl(this.remoteDataSource);

  // TODO: Implement repository logic
}
