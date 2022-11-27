part of 'posts_operations_bloc.dart';

@immutable
abstract class PostsOperationsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PostsOperationsInitial extends PostsOperationsState {}

class LoadingPostsOperations extends PostsOperationsState {}

class ErrorPostsOperations extends PostsOperationsState {

  final String message;

  ErrorPostsOperations({required this.message});

  @override
  List<Object?> get props => [message];
}

class SuccessPostsOperations extends PostsOperationsState {

  final String message;

  SuccessPostsOperations({required this.message});

  @override
  List<Object?> get props => [message];
}