import 'dart:convert';

import 'package:clean_arch/core/Exception.dart';
import 'package:clean_arch/features/posts/data/models/postModel.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

abstract class RemotePostsDataSource {
  Future<List<PostModel>> getPosts();

  Future<Unit> deletePost(String id);

  Future<Unit> updatePost(PostModel post);

  Future<Unit> addPost(PostModel post);
}

const baseUrl = 'https://jsonplaceholder.typicode.com/';

class RemotePostsDataSourceImp implements RemotePostsDataSource {
  final http.Client client;

  RemotePostsDataSourceImp({required this.client});

  @override
  Future<Unit> addPost(PostModel post) async {
    final body = {'title': post.title, 'body': post.body};

    final response =
        await client.post(Uri.parse('${baseUrl}posts/'), body: body);

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(String id) async {
    final response = await client.post(Uri.parse('${baseUrl}posts/$id'),
        headers: {'contentType': 'application/json'});

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<PostModel>> getPosts() async {
    final response = await client.get(Uri.parse('${baseUrl}posts'),
        headers: {'contentType': 'application/json'});

    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.body) as List;
      final List<PostModel> postModel = decodedJson
          .map<PostModel>((postModel) => PostModel.fromJson(postModel))
          .toList();
      return postModel;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel post) async {
    String postid = post.id.toString();
    final body = {'title': post.title, 'body': post.body};

    final response =
    await client.post(Uri.parse('${baseUrl}posts/$postid'), body: body);

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
