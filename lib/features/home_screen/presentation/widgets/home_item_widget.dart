import 'package:flutter/material.dart';
import '../../domain/entities/home_item.dart';

class HomeItemWidget extends StatelessWidget {
  final HomeItem item;

  const HomeItemWidget({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: item.imageUrl != null
            ? CircleAvatar(
                backgroundImage: NetworkImage(item.imageUrl!),
                onBackgroundImageError: (_, __) {},
              )
            : const CircleAvatar(
                child: Icon(Icons.image),
              ),
        title: Text(
          item.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: item.description != null
            ? Text(
                item.description!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )
            : null,
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          // TODO: Navigate to item details
        },
      ),
    );
  }
}

