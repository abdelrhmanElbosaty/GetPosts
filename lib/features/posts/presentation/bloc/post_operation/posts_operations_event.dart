part of 'posts_operations_bloc.dart';

@immutable
abstract class PostsOperationsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class DeletePostEvent extends PostsOperationsEvent {
  final String postId;

  DeletePostEvent(this.postId);

  @override
  List<Object?> get props => [postId];
}

class UpdatePostEvent extends PostsOperationsEvent {
  final Post post;

  UpdatePostEvent(this.post);

  @override
  List<Object?> get props => [post];
}

class AddPostEvent extends PostsOperationsEvent {
  final Post post;

  AddPostEvent(this.post);

  @override
  List<Object?> get props => [post];
}
