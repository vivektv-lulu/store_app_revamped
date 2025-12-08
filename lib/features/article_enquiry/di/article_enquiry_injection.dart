// Dependency injection for Article Enquiry feature
import '../data/datasources/article_enquiry_remote_data_source.dart';
import '../data/repositories/article_enquiry_repository_impl.dart';
import '../domain/repositories/article_enquiry_repository.dart';
import '../domain/usecases/search_article.dart';
import '../presentation/controllers/article_enquiry_controller.dart';

class ArticleEnquiryInjection {
  // Data Sources
  static ArticleEnquiryRemoteDataSource get remoteDataSource =>
      ArticleEnquiryRemoteDataSourceImpl();

  // Repository
  static ArticleEnquiryRepository get repository => ArticleEnquiryRepositoryImpl(
        remoteDataSource: remoteDataSource,
      );

  // Use Cases
  static SearchArticle get searchArticleUseCase => SearchArticle(repository);

  // Controller
  static ArticleEnquiryController get articleEnquiryController =>
      ArticleEnquiryController(
        searchArticle: searchArticleUseCase,
      );
}

