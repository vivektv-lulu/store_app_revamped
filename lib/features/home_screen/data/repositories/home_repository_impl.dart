import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/home_item.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_local_data_source.dart';
import '../datasources/home_remote_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  final HomeLocalDataSource localDataSource;

  HomeRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<HomeItem>>> getHomeItems() async {
    try {
      // Try to get from remote first
      final remoteItems = await remoteDataSource.getHomeItems();

      // Cache the remote data
      await localDataSource.cacheHomeItems(remoteItems);

      return Right(remoteItems);
    } on ServerException catch (e) {
      // If remote fails, try local cache
      try {
        final localItems = await localDataSource.getCachedHomeItems();
        return Right(localItems);
      } on CacheException {
        return Left(ServerFailure(e.message));
      }
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, HomeItem>> getHomeItemById(String id) async {
    try {
      // Try to get from remote first
      final remoteItem = await remoteDataSource.getHomeItemById(id);
      return Right(remoteItem);
    } on ServerException catch (e) {
      // If remote fails, try local cache
      try {
        final localItem = await localDataSource.getCachedHomeItemById(id);
        return Right(localItem);
      } on CacheException {
        return Left(ServerFailure(e.message));
      }
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }
}
