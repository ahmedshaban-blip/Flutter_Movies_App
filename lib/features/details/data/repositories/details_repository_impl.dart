import '../../domain/repositories/details_repository.dart';
import '../datasources/details_remote_datasource.dart';

class DetailsRepositoryImpl implements DetailsRepository {
  final DetailsRemoteDataSource remoteDataSource;

  DetailsRepositoryImpl(this.remoteDataSource);

  // TODO: Implement repository logic
}
