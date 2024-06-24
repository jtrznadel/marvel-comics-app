import 'package:dartz/dartz.dart';
import 'package:marvel_comics_app/core/errors/failures.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;

typedef ResultStream<T> = Stream<Either<Failure, T>>;
