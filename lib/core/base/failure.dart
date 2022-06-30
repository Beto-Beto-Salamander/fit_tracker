import 'package:equatable/equatable.dart';
import 'package:fit_tracker/lib.dart';

class Failure extends Equatable {
  final String message;
  final BaseException exception;

  const Failure({
    required this.message,
    required this.exception,
  });

  @override
  List<Object> get props => [message, exception];

  @override
  bool get stringify => true;
}
