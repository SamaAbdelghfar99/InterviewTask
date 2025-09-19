part of 'home_bloc.dart';

abstract class HomeEvent {}

class NavigateTo extends HomeEvent {
  final int index;
  NavigateTo(this.index);
}

class FetchPosts extends HomeEvent{}

class SearchPosts extends HomeEvent {
  final String query;
  SearchPosts(this.query);
}