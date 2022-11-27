import 'package:clean_arch/core/Exception.dart';
import 'package:clean_arch/core/failure.dart';
import 'package:clean_arch/features/posts/data/data_sources/local_posts_data_source.dart';
import 'package:clean_arch/features/posts/data/data_sources/remote_posts_data_source.dart';
import 'package:clean_arch/features/posts/data/models/postModel.dart';

import 'package:clean_arch/features/posts/domain/entity/post.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/networkInfo.dart';
import '../../domain/repositories/post_repository/post_repository.dart';

class PostRepositoryImp implements PostRepository {
  final RemotePostsDataSource remotePostsDataSource;
  final LocalPostsDataSource localPostsDataSource;
  final NetworkInfo networkInfo;

  PostRepositoryImp(
      {required this.remotePostsDataSource,
      required this.localPostsDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    if (await networkInfo.isConnected) {
      try {
        final PostModel postModel =
            PostModel(id: post.id, title: post.title, body: post.body);
        await remotePostsDataSource.addPost(postModel);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deletePost(String id) async {
    if (await networkInfo.isConnected) {
      try {
        remotePostsDataSource.deletePost(id);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<Post>>> getPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await remotePostsDataSource.getPosts();
        localPostsDataSource.cashPost(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await localPostsDataSource.getPosts();
        return Right(localPosts);
      } on EmptyCashedException {
        return Left(EmptyCashFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    if (await networkInfo.isConnected) {
      try {
        final postModel =
            PostModel(id: post.id, title: post.title, body: post.body);
        await remotePostsDataSource.updatePost(postModel);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
