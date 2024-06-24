import 'package:marvel_comics_app/core/usecases/usecases.dart';
import 'package:marvel_comics_app/core/utils/typedefs.dart';
import 'package:marvel_comics_app/features/comics/domain/entities/comics.dart';
import 'package:marvel_comics_app/features/comics/domain/repositories/comics_repository.dart';

class GetComics extends FutureUsecaseWithoutParams<List<Comics>> {
  const GetComics(this._repo);

  final ComicsRepository _repo;

  @override
  ResultFuture<List<Comics>> call() => _repo.getComics();
}
