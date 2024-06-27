import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:marvel_comics_app/features/comics/domain/entities/comics.dart';
import 'package:marvel_comics_app/features/comics/domain/usecasese/get_comics.dart';
import 'package:marvel_comics_app/features/comics/domain/usecasese/get_specific_comics.dart';

part 'comics_state.dart';

class ComicsCubit extends Cubit<ComicsState> {
  final GetComics _getComics;
  final GetSpecificComics _getSpecificComics;

  int _currentOffset = 0;
  final int _limit = 20;
  bool _isFetching = false;
  final List<Comics> _allComics = [];
  final List<Comics> _specificComics = [];

  ComicsCubit({
    required GetComics getComics,
    required GetSpecificComics getSpecificComics,
  })  : _getComics = getComics,
        _getSpecificComics = getSpecificComics,
        super(ComicsInitial());

  Future<void> getComics() async {
    emit(ComicsLoading());
    _currentOffset = 0;
    _allComics.clear();
    final result = await _getComics(GetComicsParams(
      offset: _currentOffset,
      limit: _limit,
    ));
    result.fold(
      (failure) => emit(ComicsError(failure.errorMessage)),
      (comics) {
        _allComics.addAll(comics);
        emit(ComicsLoaded(_allComics));
      },
    );
  }

  Future<void> loadMoreComics() async {
    if (_isFetching) return;

    _isFetching = true;
    _currentOffset += _limit;
    emit(ComicsLoadingMore(_allComics));
    final result = await _getComics(GetComicsParams(
      offset: _currentOffset,
      limit: _limit,
    ));
    result.fold(
      (failure) {
        emit(ComicsError(failure.errorMessage));
        _isFetching = false;
      },
      (comics) {
        _allComics.addAll(comics);
        emit(ComicsLoaded(_allComics));
        _isFetching = false;
      },
    );
  }

  Future<void> getSpecificComics(String query) async {
    emit(const SpecificComicsLoading([]));
    _currentOffset = 0;
    _specificComics.clear();
    final result = await _getSpecificComics(GetSpecificComicsParams(
      query: query,
      offset: _currentOffset,
      limit: _limit,
    ));
    result.fold(
      (failure) => emit(ComicsError(failure.errorMessage)),
      (comics) {
        _specificComics.addAll(comics);
        emit(SpecificComicsLoaded(_specificComics));
      },
    );
  }

  Future<void> loadMoreSpecificComics(String query) async {
    if (_isFetching) return;

    _isFetching = true;
    _currentOffset += _limit;
    emit(SpecificComicsLoadingMore(_specificComics));
    final result = await _getSpecificComics(GetSpecificComicsParams(
      query: query,
      offset: _currentOffset,
      limit: _limit,
    ));
    result.fold(
      (failure) {
        emit(ComicsError(failure.errorMessage));
        _isFetching = false;
      },
      (comics) {
        _specificComics.addAll(comics);
        emit(SpecificComicsLoaded(_specificComics));
        _isFetching = false;
      },
    );
  }
}
