import 'package:equatable/equatable.dart';

class Creator extends Equatable {
  const Creator({
    required this.name,
    required this.role,
  });

  final String name;
  final String role;

  @override
  List<Object?> get props => [name, role];
}
