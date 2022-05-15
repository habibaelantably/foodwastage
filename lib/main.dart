import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodwastage/block_observer.dart';
import 'package:foodwastage/components/constants.dart';
import 'package:foodwastage/layout/food_Layout.dart';
import 'package:foodwastage/modules/login_Screen.dart';
import 'package:foodwastage/network/local/cache_helper.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_cubit.dart';
import 'package:foodwastage/styles/themes.dart';

//
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();

  Widget? widget;

  uId = CacheHelper.getData(key: 'uId');

  if (uId != null) {
    widget = const foodLayout();
  } else {
    widget = LoginScreen();
  }

  BlocOverrides.runZoned(
    () {
      runApp(MyApp(widget));
    },
    blocObserver: MyBlocObserver(),
  );
  // runApp( MyApp(widget));
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;

  // ignore: use_key_in_widget_constructors
  const MyApp(this.startWidget);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => FoodCubit()
        ..getUserdata(context: context)
        ..getPosts(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        themeMode: ThemeMode.light,
        home: startWidget,
      ),
    );
  }
}
