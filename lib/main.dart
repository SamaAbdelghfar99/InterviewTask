import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_task/features/home/controller/home_bloc.dart';
import 'package:interview_task/main_screen.dart';

import 'core/repo/post_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(PostRepository())..add(FetchPosts()),
      child: MaterialApp(
        title: 'Bloc Bottom Navigation',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const MainScreen(),
      ),
    );
  }
}

