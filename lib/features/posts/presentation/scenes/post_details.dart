import 'package:clean_arch/core/utils/snack_bar.dart';
import 'package:clean_arch/features/posts/presentation/bloc/get_posts/posts_bloc.dart';
import 'package:clean_arch/features/posts/presentation/bloc/post_operation/posts_operations_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/post.dart';
import '../widgets/Widgets.dart';
import 'form_widget.dart';

class PostDetails extends StatelessWidget {
  PostDetails({Key? key, this.post, required this.isUpdatePost})
      : super(key: key);

  final Post? post;
  final bool isUpdatePost;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(isUpdatePost ? 'Update Post' : 'Add Post'),
    );
  }

  Widget buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: BlocConsumer<PostsOperationsBloc, PostsOperationsState>(
          builder: (context, state) {
            if (state is LoadingPostsOperations) {
              return buildLoadingProgressWidget();
            }
            return FormWidget(
                isUpdatePost: isUpdatePost, post: isUpdatePost ? post : null);
          },
          listener: (context, state) {
            if (state is ErrorPostsOperations) {
              SnackBarMessage()
                  .showErrorSnackBar(context: context, msg: state.message);
            } else if (state is SuccessPostsOperations) {
              SnackBarMessage()
                  .showSuccessSnackBar(context: context, msg: state.message);
              Navigator.of(context).pop();
            }
          },
        ),
      ),
    );
  }
}
