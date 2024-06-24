import 'package:equatable/equatable.dart';
import 'package:marvel_comics_app/core/errors/exceptions.dart';

abstract class Failure extends Equatable {
  final String message;
  final dynamic statusCode;

  const Failure({required this.message, required this.statusCode});

  String get errorMessage {
    final showErrorText =
        statusCode is! String || int.tryParse(statusCode as String) != null;
    return '$statusCode ${showErrorText ? ' Error' : ''}: $message';
  }

  @override
  List<dynamic> get props => [message, statusCode];
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.statusCode});

  ServerFailure.fromException(ServerException exception)
      : this(message: exception.message, statusCode: exception.statusCode);
}
