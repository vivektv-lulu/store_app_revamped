import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/article_info.dart';
import '../../domain/entities/article_enquiry_mode.dart';
import '../../domain/repositories/article_enquiry_repository.dart';
import '../datasources/article_enquiry_remote_data_source.dart';

class ArticleEnquiryRepositoryImpl implements ArticleEnquiryRepository {
  final ArticleEnquiryRemoteDataSource remoteDataSource;

  ArticleEnquiryRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, ArticleInfo>> searchArticle({
    required ArticleEnquiryMode mode,
    required String number,
  }) async {
    try {
      final result = await remoteDataSource.searchArticle(
        mode: mode,
        number: number,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }
}

