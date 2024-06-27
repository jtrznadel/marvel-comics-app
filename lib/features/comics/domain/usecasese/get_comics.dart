import 'package:equatable/equatable.dart';
import 'package:marvel_comics_app/core/usecases/usecases.dart';
import 'package:marvel_comics_app/core/utils/typedefs.dart';
import 'package:marvel_comics_app/features/comics/domain/entities/comics.dart';
import 'package:marvel_comics_app/features/comics/domain/repositories/comics_repository.dart';

class GetComics extends FutureUsecaseWithParams<List<Comics>, GetComicsParams> {
  const GetComics(this._repo);

  final ComicsRepository _repo;

  @override
  ResultFuture<List<Comics>> call(GetComicsParams params) =>
      _repo.getComics(offset: params.offset, limit: params.limit);
}

class GetComicsParams extends Equatable {
  const GetComicsParams({required this.offset, required this.limit});

  final int offset;
  final int limit;

  @override
  List<Object?> get props => [offset, limit];
}
