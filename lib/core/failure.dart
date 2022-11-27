import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class OfflineFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class EmptyCashFailure extends Failure {
  @override
  List<Object?> get props => [];
}

String mapFailureMessage(Failure failure) {
  switch (failure.runtimeType) {
    case EmptyCashFailure:
      return 'Their\'s no cashed data';
    case ServerFailure:
      return 'u'
          'UnKnown error, please call the developer';
    case OfflineFailure:
      return 'Please, Check your internet connection';
    default:
      return 'UnExpected error, .... ';
  }
}