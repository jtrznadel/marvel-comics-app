import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:marvel_comics_app/features/comics/domain/entities/comics.dart';
import 'package:marvel_comics_app/features/comics/domain/usecasese/get_comics.dart';

part 'comics_state.dart';

class ComicsCubit extends Cubit<ComicsState> {
  final GetComics _getComics;

  ComicsCubit({
    required GetComics getComics,
  })  : _getComics = getComics,
        super(ComicsInitial());

  Future<void> getComics() async {
    emit(ComicsLoading());
    final result = await _getComics();
    result.fold(
      (failure) => emit(ComicsError(failure.errorMessage)),
      (comics) => emit(ComicsLoaded(comics)),
    );
  }
}
