import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/article_info.dart';
import '../entities/article_enquiry_mode.dart';

abstract class ArticleEnquiryRepository {
  Future<Either<Failure, ArticleInfo>> searchArticle({
    required ArticleEnquiryMode mode,
    required String number,
  });
}

