import 'package:dartz/dartz.dart';
import '../../../../../core/failure.dart';
import '../../entity/post.dart';

abstract class PostRepository {
  Future<Either<Failure,List<Post>>> getPosts();
  Future<Either<Failure,Unit>>addPost(Post post);
  Future<Either<Failure,Unit>> deletePost(String id);
  Future<Either<Failure,Unit>> updatePost(Post post);
}

