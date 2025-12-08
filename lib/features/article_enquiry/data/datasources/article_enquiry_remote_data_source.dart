import '../../../../core/error/exceptions.dart';
import '../../domain/entities/article_enquiry_mode.dart';
import '../models/article_info_model.dart';

abstract class ArticleEnquiryRemoteDataSource {
  Future<ArticleInfoModel> searchArticle({
    required ArticleEnquiryMode mode,
    required String number,
  });
}

class ArticleEnquiryRemoteDataSourceImpl
    implements ArticleEnquiryRemoteDataSource {
  // TODO: Inject REST or SOAP client based on your API

  @override
  Future<ArticleInfoModel> searchArticle({
    required ArticleEnquiryMode mode,
    required String number,
  }) async {
    // TODO: Implement API call
    // Example for REST:
    // final response = await restClient.get('/article/search', queryParameters: {
    //   'mode': mode.shortForm,
    //   'number': number,
    // });
    // return ArticleInfoModel.fromJson(response.data);

    // Example for SOAP:
    // final envelope = SoapEnvelopeBuilder.buildEnvelope(...);
    // final response = await soapClient.postSoap(...);
    // return ArticleInfoModel.fromXml(response);

    // Placeholder
    throw ServerException('Not implemented');
  }
}

