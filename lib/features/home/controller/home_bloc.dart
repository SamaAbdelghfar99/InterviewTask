import 'package:bloc/bloc.dart';
import 'package:interview_task/core/models/post_model.dart';
import 'package:interview_task/core/repo/post_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final PostRepository repository;
  List<Post> _allPosts = [];

  HomeBloc(this.repository) : super(NavigationState(0)) {
    // Navigation
    on<NavigateTo>((event, emit) {
      emit(NavigationState(event.index));
    });

    // Fetch posts
    on<FetchPosts>(_onFetchPosts);

    // Search posts
    on<SearchPosts>(_onSearchPosts);
  }

  Future<void> _onFetchPosts(FetchPosts event, Emitter<HomeState> emit) async {
    emit(PostLoading());
    try {
      _allPosts = await repository.fetchPosts();
      emit(PostLoaded(_allPosts));
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  void _onSearchPosts(SearchPosts event, Emitter<HomeState> emit) {
    if (event.query.isEmpty) {
      emit(PostLoaded(_allPosts));
    } else {
      final filtered = _allPosts
          .where((post) =>
      (post.title ?? '').toLowerCase().contains(event.query.toLowerCase()) ||
          (post.body ?? '').toLowerCase().contains(event.query.toLowerCase()))
          .toList();
      print("Filtered count: ${filtered.length}");
      emit(PostLoaded(filtered));
    }
  }
}
