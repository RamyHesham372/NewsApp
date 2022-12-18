// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modules/news_app/search/search_screen.dart';
import '../../shared/components/components.dart';
import 'news/cubit/cubit.dart';
import 'news/cubit/states.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, states) {},
        builder: (context, states) {
          var cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('News App'),
              actions: [
                IconButton(onPressed: () {
                  // to clear the page when i enter
                  cubit.search = [];
                  navigateTo(context, SearchScreen());
                }, icon: const Icon(Icons.search)),
                IconButton(onPressed: () {
                  cubit.changeThemeMode();
                }, icon: const Icon(Icons.brightness_3)),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNavBar(index);
              },
              items: cubit.bottomItems,
            ),
          );
        });
  }
}