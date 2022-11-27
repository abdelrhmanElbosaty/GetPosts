import 'package:clean_arch/features/posts/presentation/bloc/get_posts/posts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/post.dart';

class PostsHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: buildBody(),
      floatingActionButton:
          FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add)),
    );
  }

  Widget buildPostBody(posts) {
    return Center(
      child: ListView.separated(
        itemBuilder: (context, index) => buildSingleRow(posts[index]),
        separatorBuilder: (context, index) => buildPostSeparator(),
        itemCount: posts.length,
      ),
    );
  }

  Widget buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is LoadingPostState) {
            return buildLoadingProgressWidget();
          } else if (state is LoadedPostState) {
            return RefreshIndicator(
              onRefresh: () => onRefresh(context),
              child: buildPostBody(state.posts),
            );
          } else if (state is ErrorPostState) {
            return buildErrorWidget(context, state.message);
          }
          return buildLoadingProgressWidget();
        },
      ),
    );
  }

  Future<void> onRefresh(context) async {
    BlocProvider.of<PostsBloc>(context).add(RefreshPostEvent());
  }

  Widget buildPostSeparator() {
    return Divider(
      color: Colors.grey[300],
      thickness: 1,
    );
  }

  Widget buildSingleRow(Post post) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(post.id.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 18,
            )),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 8,
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

  Widget buildErrorWidget(BuildContext context, msg) {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        child: SingleChildScrollView(child: Text(msg)),
      ),
    );
  }
}
