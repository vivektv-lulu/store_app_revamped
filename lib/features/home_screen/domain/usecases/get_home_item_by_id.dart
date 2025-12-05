import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/home_item.dart';
import '../repositories/home_repository.dart';

class GetHomeItemById implements UseCase<HomeItem, GetHomeItemByIdParams> {
  final HomeRepository repository;

  GetHomeItemById(this.repository);

  @override
  Future<Either<Failure, HomeItem>> call(GetHomeItemByIdParams params) {
    return repository.getHomeItemById(params.id);
  }
}

class GetHomeItemByIdParams extends Equatable {
  final String id;

  const GetHomeItemByIdParams({required this.id});

  @override
  List<Object> get props => [id];
}
