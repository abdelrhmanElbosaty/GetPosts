import 'package:clean_arch/features/posts/presentation/bloc/get_posts/posts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/post.dart';

class PostsHome extends StatelessWidget {

  late List<Post> posts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Center(
      child: ListView.separated(
        itemBuilder: (context, index) => buildPostItem(posts[index]),
        separatorBuilder: (context, index) => buildPostSeperator(),
        itemCount: posts.length,
      ),
    );
  }

  Widget buildPostItem(post) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is LoadingPostState) {
            return buildLoadingProgressWidget();
          } else if (state is LoadedPostState) {
            posts = state.posts;
            return buildSingleRow(post);
          } else if (state is ErrorPostState){
            return buildErrorWidget();
          }
          return buildLoadingProgressWidget();
        },
      ),
    );
  }

  Widget buildPostSeperator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        height: 1,
        color: Colors.grey[300],
      ),
    );
  }

  Widget buildSingleRow(Post post) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(post.id),
        const SizedBox(width: 16,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),

              Text(
                post.body,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildLoadingProgressWidget() {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.orange,
      ),
    );
  }

  Widget buildErrorWidget(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        child: Text('data'),
      )
    );
  }
}
