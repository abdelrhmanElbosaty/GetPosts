import 'package:clean_arch/features/posts/domain/repositories/post_repository/post_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/failure.dart';

class DeletePostUseCase{
  final PostRepository repository;

  DeletePostUseCase(this.repository);

  Future<Either<Failure,Unit>> call(String id) async {
    return await repository.deletePost(id);
  }
}