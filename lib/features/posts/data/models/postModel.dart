import 'package:clean_arch/features/posts/domain/entity/post.dart';

class PostModel extends Post {
  const PostModel({int? id, required String title, required String body})
      : super(body: body, title: title, id: id);

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(id: json['id'], title: json['title'], body: json['body']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'body': body};
  }
}
