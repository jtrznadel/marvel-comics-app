import 'package:dartz/dartz.dart';
import 'package:marvel_comics_app/core/errors/exceptions.dart';
import 'package:marvel_comics_app/core/errors/failures.dart';
import 'package:marvel_comics_app/core/utils/typedefs.dart';
import 'package:marvel_comics_app/features/comics/data/datasources/comics_remote_data_source.dart';
import 'package:marvel_comics_app/features/comics/domain/entities/comics.dart';
import 'package:marvel_comics_app/features/comics/domain/repositories/comics_repository.dart';

class ComicsRepositoryImpl implements ComicsRepository {
  const ComicsRepositoryImpl(this._remoteDataSource);

  final ComicsRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<List<Comics>> getComics() async {
    try {
      final result = await _remoteDataSource.getComics();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Comics>> getSpecificComics({required String query}) async {
    try {
      final result = await _remoteDataSource.getSpecificComics(query: query);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
