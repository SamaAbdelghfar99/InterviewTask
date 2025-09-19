part of 'home_bloc.dart';


abstract class HomeState {}

class HomeInitialState extends HomeState {}

class NavigationState extends HomeState {
  final int selectedIndex;
  NavigationState(this.selectedIndex);
}

class PostLoading extends HomeState{}
class PostLoaded extends HomeState {
  final List<Post> posts;
  PostLoaded(this.posts);
}
class PostError extends HomeState {
  final String message;
  PostError(this.message);
}
