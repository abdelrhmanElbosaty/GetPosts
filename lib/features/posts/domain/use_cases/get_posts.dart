import 'package:clean_arch/features/posts/domain/repositories/post_repository/post_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/failure.dart';
import '../entity/post.dart';

class GetPostsUseCase {
  final PostRepository repository;

  GetPostsUseCase(this.repository);

  Future<Either<Failure, List<Post>>> call() async {
    return await repository.getPosts();
  }
}
