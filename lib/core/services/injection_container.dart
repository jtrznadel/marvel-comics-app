import 'package:get_it/get_it.dart';
import 'package:marvel_comics_app/features/comics/data/datasources/comics_remote_data_source.dart';
import 'package:marvel_comics_app/features/comics/data/repositories/comics_repository.dart';
import 'package:marvel_comics_app/features/comics/domain/repositories/comics_repository.dart';
import 'package:marvel_comics_app/features/comics/domain/usecasese/get_comics.dart';
import 'package:marvel_comics_app/features/comics/domain/usecasese/get_specific_comics.dart';
import 'package:marvel_comics_app/features/comics/presentation/cubit/comics_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _initComics();
}

Future<void> _initComics() async {
  sl
    ..registerFactory(
      () => ComicsCubit(
        getComics: sl(),
        getSpecificComics: sl(),
      ),
    )
    ..registerLazySingleton(() => GetComics(sl()))
    ..registerLazySingleton(() => GetSpecificComics(sl()))
    ..registerLazySingleton<ComicsRemoteDataSource>(
        () => ComicsRemoteDataSourceImpl())
    ..registerLazySingleton<ComicsRepository>(() => ComicsRepositoryImpl(sl()));
}
