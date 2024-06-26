import 'package:equatable/equatable.dart';

class Comics extends Equatable {
  const Comics({
    required this.id,
    required this.title,
    required this.description,
    required this.resourceUrl,
    required this.creators,
    required this.images,
  });

  final int id;
  final String title;
  final String description;
  final String resourceUrl;
  final List<dynamic> creators;
  final List<dynamic> images;

  @override
  List<Object?> get props => [id];
}
