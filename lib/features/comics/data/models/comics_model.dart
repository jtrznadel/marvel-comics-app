import 'package:marvel_comics_app/features/comics/domain/entities/comics.dart';
import 'package:marvel_comics_app/features/comics/domain/entities/creator.dart';

class ComicsModel extends Comics {
  const ComicsModel({
    required super.id,
    required super.title,
    required super.description,
    required super.resourceUrl,
    required super.creators,
    required super.images,
  });

  ComicsModel.fromJson(Map<String, dynamic> json)
      : super(
          id: json['id'] ?? 0,
          title: json['title'] ?? '',
          description: json['description'] ?? '',
          resourceUrl: (json['urls'] as List<dynamic>?)?.first['url'] ?? '',
          creators: (json['creators']['items'] as List?)
                  ?.map((creator) =>
                      CreatorModel.fromJson(creator as Map<String, dynamic>))
                  .toList() ??
              [],
          images: (json['images'] as List?)
                  ?.map((image) =>
                      '${image['path'] ?? ''}.${image['extension'] ?? ''}')
                  .toList() ??
              [],
        );
}

class CreatorModel extends Creator {
  const CreatorModel({required super.name, required super.role});

  factory CreatorModel.fromJson(Map<String, dynamic> json) {
    return CreatorModel(
      name: json['name'] as String,
      role: json['role'] as String,
    );
  }
}
