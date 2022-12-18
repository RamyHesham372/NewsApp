import 'package:apiproject/layout/news_app/news/cubit/states.dart';
import 'package:apiproject/shared/bloc__observer.dart';
import 'package:apiproject/shared/network/local/cashe_helper.dart';
import 'package:apiproject/shared/network/remote/dio_helper.dart';
import 'package:apiproject/shared/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'layout/news_app/news/cubit/cubit.dart';
import 'layout/news_app/news_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CasheHelper.init();

  late bool light;
  if(CasheHelper.getData(key: 'lightTheme') != null){
    light = CasheHelper.getData(key: 'lightTheme');
  }else {
    light = true;
  }

  runApp(MyApp(isLight: light));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isLight});

  final bool isLight;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()..getBusiness()..changeThemeMode(isLight: isLight),
      child: BlocConsumer<NewsCubit, NewsStates>(
          listener: (context, states) {},
          builder: (context, states) {
            var cubitAccess = NewsCubit.get(context);
            return MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: cubitAccess.themeModeLight ? lightTheme : darkTheme,
              home: const NewsLayout(),
            );
          }),
    );
  }
}
