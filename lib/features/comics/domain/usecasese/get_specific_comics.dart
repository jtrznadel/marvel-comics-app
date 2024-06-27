import 'package:equatable/equatable.dart';
import 'package:marvel_comics_app/core/usecases/usecases.dart';
import 'package:marvel_comics_app/core/utils/typedefs.dart';
import 'package:marvel_comics_app/features/comics/domain/entities/comics.dart';
import 'package:marvel_comics_app/features/comics/domain/repositories/comics_repository.dart';

class GetSpecificComics
    extends FutureUsecaseWithParams<List<Comics>, GetSpecificComicsParams> {
  const GetSpecificComics(this._repo);

  final ComicsRepository _repo;

  @override
  ResultFuture<List<Comics>> call(GetSpecificComicsParams params) =>
      _repo.getSpecificComics(
          query: params.query, offset: params.offset, limit: params.limit);
}

class GetSpecificComicsParams extends Equatable {
  const GetSpecificComicsParams(
      {required this.query, required this.offset, required this.limit});

  final String query;
  final int offset;
  final int limit;

  @override
  List<Object?> get props => [query, offset, limit];
}
