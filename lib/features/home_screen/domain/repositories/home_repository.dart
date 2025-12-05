import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/home_item.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<HomeItem>>> getHomeItems();
  Future<Either<Failure, HomeItem>> getHomeItemById(String id);
}
