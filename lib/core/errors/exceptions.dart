import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  const ServerException({required this.message, required this.statusCode});

  final String message;
  final dynamic statusCode;

  @override
  List<dynamic> get props => [message, statusCode];
}
