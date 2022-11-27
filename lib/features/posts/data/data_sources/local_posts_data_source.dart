import 'dart:convert';

import 'package:clean_arch/core/Exception.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/postModel.dart';

abstract class LocalPostsDataSource {
  Future<Unit> cashPost(List<PostModel> post);

  Future<List<PostModel>> getPosts();
}

class LocalPostsDataSourceImp implements LocalPostsDataSource {
  final SharedPreferences sharedPreferences;

  LocalPostsDataSourceImp({required this.sharedPreferences});

  @override
  Future<List<PostModel>> getPosts() {
    final jsonString = sharedPreferences.getString('CashedPosts');
    if (jsonString != null) {
      List decodedJson = json.decode(jsonString);
      List<PostModel> jsonToPostModel = decodedJson.map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel)).toList();
      return Future.value(jsonToPostModel);
    } else {
      throw EmptyCashedException();
    }
  }

  @override
  Future<Unit> cashPost(List<PostModel> post) {
    List postModelToJson = post
        .map<Map<String, dynamic>>((postModel) => postModel.toJson())
        .toList();

    sharedPreferences.setString('CashedPosts', json.encode(postModelToJson));
    return Future.value(unit);
  }
}
