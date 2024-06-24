import 'package:marvel_comics_app/features/comics/domain/entities/comics.dart';

class ComicsModel extends Comics {
  const ComicsModel({
    required super.id,
    required super.title,
    required super.description,
    required super.creators,
    required super.images,
  });

  ComicsModel.fromJson(Map<String, dynamic> json)
      : super(
          id: json['id'] ?? 0,
          title: json['title'] ?? '',
          description: json['description'] ?? '',
          creators: (json['creators']['items'] as List?)
                  ?.map((creator) => creator['name'] as String? ?? '')
                  .toList() ??
              [],
          images: (json['images'] as List?)
                  ?.map((image) =>
                      '${image['path'] ?? ''}.${image['extension'] ?? ''}')
                  .toList() ??
              [],
        );
}
