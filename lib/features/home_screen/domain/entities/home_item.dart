import 'package:equatable/equatable.dart';

class HomeItem extends Equatable {
  final String id;
  final String title;
  final String? description;
  final String? imageUrl;
  final String category;

  const HomeItem({
    required this.id,
    required this.title,
    this.description,
    this.imageUrl,
    required this.category,
  });

  @override
  List<Object?> get props => [id, title, description, imageUrl, category];
}
