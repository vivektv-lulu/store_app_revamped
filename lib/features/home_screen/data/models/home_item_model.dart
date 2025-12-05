import '../../domain/entities/home_item.dart';

class HomeItemModel extends HomeItem {
  const HomeItemModel({
    required super.id,
    required super.title,
    super.description,
    super.imageUrl,
  });

  factory HomeItemModel.fromJson(Map<String, dynamic> json) {
    return HomeItemModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
    };
  }
}
