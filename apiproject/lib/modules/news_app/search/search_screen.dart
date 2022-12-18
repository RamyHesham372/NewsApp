import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/news_app/news/cubit/cubit.dart';
import '../../../layout/news_app/news/cubit/states.dart';
import '../../../shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        //////////////////////
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: defaultFormField(
                    keyboardType: TextInputType.text,
                    controller: searchController,
                    onChanged: (value) {
                      NewsCubit.get(context).getSearch(value);
                      return null;
                    },
                    labelText: 'Search',
                    prefix: Icons.search),
              ),
              Expanded(child: newsBuilder(list, context, isSearch: true))
            ],
          ),
        );
      },
    );
  }
}
