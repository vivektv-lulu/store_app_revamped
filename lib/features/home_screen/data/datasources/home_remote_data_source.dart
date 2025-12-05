import '../../../../core/error/exceptions.dart';
import '../models/home_item_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<HomeItemModel>> getHomeItems();
  Future<HomeItemModel> getHomeItemById(String id);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  // TODO: Add your HTTP client (dio, http, etc.)

  @override
  Future<List<HomeItemModel>> getHomeItems() async {
    // TODO: Implement API call
    // Example:
    // final response = await httpClient.get('/home-items');
    // return (response.data as List).map((json) => HomeItemModel.fromJson(json)).toList();

    // Placeholder implementation
    throw ServerException('Not implemented');
  }

  @override
  Future<HomeItemModel> getHomeItemById(String id) async {
    // TODO: Implement API call
    // Example:
    // final response = await httpClient.get('/home-items/$id');
    // return HomeItemModel.fromJson(response.data);

    // Placeholder implementation
    throw ServerException('Not implemented');
  }
}
