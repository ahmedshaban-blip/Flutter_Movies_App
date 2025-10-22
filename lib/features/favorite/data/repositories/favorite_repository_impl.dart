import '../../domain/repositories/favorite_repository.dart';
import '../datasources/favorite_remote_datasource.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteRemoteDataSource remoteDataSource;

  FavoriteRepositoryImpl(this.remoteDataSource);

  // TODO: Implement repository logic
}
