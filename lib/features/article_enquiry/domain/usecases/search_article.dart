import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/article_info.dart';
import '../entities/article_enquiry_mode.dart';
import '../repositories/article_enquiry_repository.dart';

class SearchArticle implements UseCase<ArticleInfo, SearchArticleParams> {
  final ArticleEnquiryRepository repository;

  SearchArticle(this.repository);

  @override
  Future<Either<Failure, ArticleInfo>> call(SearchArticleParams params) {
    return repository.searchArticle(
      mode: params.mode,
      number: params.number,
    );
  }
}

class SearchArticleParams extends Equatable {
  final ArticleEnquiryMode mode;
  final String number;

  const SearchArticleParams({
    required this.mode,
    required this.number,
  });

  @override
  List<Object> get props => [mode, number];
}

