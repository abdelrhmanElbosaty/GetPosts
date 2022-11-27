part of 'posts_bloc.dart';

@immutable
abstract class PostsEvent {}

class GetAllPostEvent extends PostsEvent {}

class RefreshPostEvent extends PostsEvent {}