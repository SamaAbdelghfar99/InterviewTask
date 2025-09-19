import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_task/features/home/controller/home_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeBloc =context.read<HomeBloc>();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.circular(12),
              ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red, width: 2.0),
                borderRadius: BorderRadius.circular(12),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.circular(12),
              ),
              hintText: 'Search',
              hintStyle: const TextStyle(color: Colors.grey),
            ),
            onChanged: (query){
              homeBloc.add(SearchPosts(query));
            },
          ),
          // Posts List
          Expanded(
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is PostLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is PostLoaded) {
                  if (state.posts.isEmpty) {
                    return const Center(child: Text("No posts found"));
                  }
                  return ListView.builder(
                    itemCount: state.posts.length,
                    itemBuilder: (context, index) {
                      final post = state.posts[index];
                      return Card(
                        margin:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        elevation: 2,
                        child: ListTile(
                          title: Text(post.title??'',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold)),
                          subtitle: Text(post.body??''),
                        ),
                      );
                    },
                  );
                } else if (state is PostError) {
                  return Center(child: Text("Error: ${state.message}"));
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}