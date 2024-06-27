part of 'comics_cubit.dart';

sealed class ComicsState extends Equatable {
  const ComicsState();

  @override
  List<Object> get props => [];
}

final class ComicsInitial extends ComicsState {}

final class ComicsLoading extends ComicsState {}

final class ComicsLoadingMore extends ComicsState {
  const ComicsLoadingMore(this.comics);

  final List<Comics> comics;

  @override
  List<Object> get props => [comics];
}

final class SpecificComicsLoading extends ComicsState {
  const SpecificComicsLoading(this.specificComics);

  final List<Comics> specificComics;

  @override
  List<Object> get props => [specificComics];
}

final class SpecificComicsLoadingMore extends ComicsState {
  const SpecificComicsLoadingMore(this.specificComics);

  final List<Comics> specificComics;

  @override
  List<Object> get props => [specificComics];
}

final class ComicsLoaded extends ComicsState {
  const ComicsLoaded(this.comics);

  final List<Comics> comics;

  @override
  List<Object> get props => [comics];
}

final class SpecificComicsLoaded extends ComicsState {
  const SpecificComicsLoaded(this.specificComics);

  final List<Comics> specificComics;

  @override
  List<Object> get props => [specificComics];
}

final class ComicsError extends ComicsState {
  const ComicsError(this.message);

  final String message;

  @override
  List<String> get props => [message];
}
