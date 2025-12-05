import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/home_item.dart';
import '../repositories/home_repository.dart';

class GetHomeItems implements UseCaseNoParams<List<HomeItem>> {
  final HomeRepository repository;

  GetHomeItems(this.repository);

  @override
  Future<Either<Failure, List<HomeItem>>> call() {
    return repository.getHomeItems();
  }
}
