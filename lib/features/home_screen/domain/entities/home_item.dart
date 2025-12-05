import 'package:equatable/equatable.dart';

class HomeItem extends Equatable {
  final String id;
  final String title;
  final String? description;
  final String? imageUrl;

  const HomeItem({
    required this.id,
    required this.title,
    this.description,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [id, title, description, imageUrl];
}
