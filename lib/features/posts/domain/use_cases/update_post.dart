import 'package:clean_arch/features/posts/domain/repositories/post_repository/post_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/failure.dart';
import '../entity/post.dart';

class UpdatePostUseCase {
  final PostRepository repository;

  UpdatePostUseCase(this.repository);

  Future<Either<Failure,Unit>> call(Post post) async {
    return await repository.updatePost(post);
  }
}
