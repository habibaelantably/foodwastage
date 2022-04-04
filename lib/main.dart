import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodwastage/block_observer.dart';
import 'package:foodwastage/components/constants.dart';
import 'package:foodwastage/layot/food_Layout.dart';
import 'package:foodwastage/modules/login_Screen.dart';
import 'package:foodwastage/network/local/Cach_helper.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_cubit.dart';
import 'package:foodwastage/styles/thems.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  Bloc.observer = MyBlocObserver();

  await CacheHelper.init();

  Widget? widget;

  uId=CacheHelper.getData(key: 'uId');

  if(uId != null)
    widget=foodLayout();
  else
    widget=LoginScreen();

  runApp( MyApp(widget));
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;
   MyApp(this.startWidget);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>FoodCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        themeMode: ThemeMode.light,
        home:startWidget,
      ),
    );
  }
}


