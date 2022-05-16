import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodwastage/block_observer.dart';
import 'package:foodwastage/components/constants.dart';
import 'package:foodwastage/layout/food_Layout.dart';
import 'package:foodwastage/modules/login_Screen.dart';
import 'package:foodwastage/network/local/cache_helper.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_cubit.dart';
import 'package:foodwastage/styles/themes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hexcolor/hexcolor.dart';
import 'l10n/l10n.dart';
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

  const MyApp(this.startWidget, {Key? key}): super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> FoodCubit()..getUserdata(context: context)..getPosts(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: ThemeData(
          primarySwatch: Colors.deepOrange,
          appBarTheme: AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor('333739'),
                  statusBarIconBrightness: Brightness.light),
              backgroundColor: HexColor('333739'),
              elevation: 0.0,
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              iconTheme: IconThemeData(color: Colors.white)),
          floatingActionButtonTheme:
          const FloatingActionButtonThemeData(backgroundColor: Colors.deepOrange),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              elevation: 20.0,
              selectedItemColor: Colors.deepOrange,
              unselectedItemColor: Colors.grey,
              backgroundColor: HexColor('333739')
          ),
          scaffoldBackgroundColor:HexColor('333739'),
    textTheme:  TextTheme(
    bodyText1: TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    color: Colors.white),
    ),

        ),
        themeMode: ThemeMode.dark,
        home:startWidget,
      supportedLocales:L10n.all,
        localizationsDelegates: [
          AppLocalizations.delegate, // Add this line
          AppLocalizations.delegate,
        ],
      ),
    );
  }
}

