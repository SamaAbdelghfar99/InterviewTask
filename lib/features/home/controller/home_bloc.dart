import 'package:bloc/bloc.dart';
import 'package:interview_task/core/models/post_model.dart';
import 'package:interview_task/core/repo/post_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final PostRepository repository;
  List<Post> _allPosts = [];
  int _currentIndex = 0;
  bool _hasLoadedPosts = false;

  HomeBloc(this.repository) : super(HomeInitialState()) {
    on<NavigateTo>((event, emit) {
      _currentIndex = event.index;

      if (event.index == 0) {
        // Home tab
        if (_hasLoadedPosts) {
          emit(PostLoaded(_allPosts));
        } else {
          add(FetchPosts());
        }
      } else {
        // Settings tab
        emit(NavigationState(event.index));
      }
    });

    on<FetchPosts>(_onFetchPosts);
    on<SearchPosts>(_onSearchPosts);
  }

  Future<void> _onFetchPosts(FetchPosts event, Emitter<HomeState> emit) async {
    if (_hasLoadedPosts && _allPosts.isNotEmpty) {
      emit(PostLoaded(_allPosts));
      return;
    }

    emit(PostLoading());
    try {
      _allPosts = await repository.fetchPosts();
      _hasLoadedPosts = true;
      emit(PostLoaded(_allPosts));
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  void _onSearchPosts(SearchPosts event, Emitter<HomeState> emit) {
    if (!_hasLoadedPosts) return;

    if (event.query.isEmpty) {
      emit(PostLoaded(_allPosts));
    } else {
      final filtered = _allPosts
          .where((post) =>
      post.title.toLowerCase().contains(event.query.toLowerCase()) ||
          post.body.toLowerCase().contains(event.query.toLowerCase()))
          .toList();
      emit(PostLoaded(filtered));
    }
  }
}