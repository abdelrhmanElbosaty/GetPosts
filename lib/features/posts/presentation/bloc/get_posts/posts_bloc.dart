import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clean_arch/core/failure.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../domain/entity/post.dart';
import '../../../domain/use_cases/get_posts.dart';

part 'posts_event.dart';

part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetPostsUseCase getPostsUseCase;

  PostsBloc({required this.getPostsUseCase}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostEvent || event is RefreshPostEvent) {
        emit(LoadingPostState());
        final failureOrPosts = await getPostsUseCase();
        failureOrPosts.fold(
          (failure) {
            emit(ErrorPostState(message: mapFailureMessage(failure)));
          },
          (data) {
            emit(LoadedPostState(posts: data));
          },
        );
      }
    });
  }
}
