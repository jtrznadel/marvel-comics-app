import 'package:marvel_comics_app/core/utils/typedefs.dart';
import 'package:marvel_comics_app/features/comics/domain/entities/comics.dart';

abstract class ComicsRepository {
  const ComicsRepository();

  ResultFuture<List<Comics>> getComics(
      {required int offset, required int limit});

  ResultFuture<List<Comics>> getSpecificComics(
      {required String query, required int offset, required int limit});
}
