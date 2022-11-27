import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clean_arch/core/failure.dart';
import 'package:clean_arch/features/posts/domain/entity/post.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../domain/use_cases/add_post.dart';
import '../../../domain/use_cases/delete_post.dart';
import '../../../domain/use_cases/update_post.dart';

part 'posts_operations_event.dart';

part 'posts_operations_state.dart';

class PostsOperationsBloc
    extends Bloc<PostsOperationsEvent, PostsOperationsState> {
  final AddPostUseCase addPostUseCase;
  final DeletePostUseCase deletePostUseCase;
  final UpdatePostUseCase updatePostUseCase;

  PostsOperationsBloc(
      {required this.addPostUseCase,
      required this.updatePostUseCase,
      required this.deletePostUseCase})
      : super(PostsOperationsInitial()) {
    on<PostsOperationsEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingPostsOperations());
        final failureOrSuccess = await addPostUseCase(event.post);
        failureOrSuccess.fold((failure) {
          emit(ErrorPostsOperations(message: mapFailureMessage(failure)));
        }, (_) {
          emit(SuccessPostsOperations(message: 'Post added successfully'));
        });
      }
      else if (event is UpdatePostEvent) {
        emit(LoadingPostsOperations());
        final failureOrSuccess = await updatePostUseCase(event.post);
        failureOrSuccess.fold((failure) {
          emit(ErrorPostsOperations(message: mapFailureMessage(failure)));
        }, (_) {
          emit(SuccessPostsOperations(message: 'Post updated successfully'));
        });
      }
      else if (event is DeletePostEvent) {
        emit(LoadingPostsOperations());
        final failureOrSuccess = await deletePostUseCase(event.postId);
        failureOrSuccess.fold((failure) {
          emit(ErrorPostsOperations(message: mapFailureMessage(failure)));
        }, (_) {
          emit(SuccessPostsOperations(message: 'Post deleted successfully'));
        });
      }
    });
  }
}
