import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_task/features/home/controller/home_bloc.dart';
import 'package:interview_task/features/home/views/home_view.dart';
import 'package:interview_task/features/settings/views/settings_view.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static final List<Widget> _pages = [
    const HomePage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        int currentIndex = 0;

        // Extract current index based on state type
        if (state is NavigationState) {
          currentIndex = state.selectedIndex;
        } else if (state is PostLoaded || state is PostLoading || state is PostError) {
          currentIndex = 0; // Assume we're on home tab for post-related states
        }

        return Scaffold(
          appBar: AppBar(title: Text("sama".tr())),
          body: IndexedStack(
            index: currentIndex,
            children: _pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              context.read<HomeBloc>().add(NavigateTo(index));
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "home".tr(),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "settings".tr(),
              ),
            ],
          ),
        );
      },
    );
  }
}