import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:foodwastage/block_observer.dart';
import 'package:foodwastage/layout/App_Layout.dart';
import 'package:foodwastage/modules/login_Screen.dart';
import 'package:foodwastage/network/local/cache_helper.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_cubit.dart';
import 'package:foodwastage/shared/cubit/Prefrences%20Cubit/prefrences_cubit.dart';
import 'package:foodwastage/shared/cubit/Prefrences%20Cubit/prefrences_states.dart';
import 'package:foodwastage/styles/themes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//test
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();

  Widget? widget;
  bool? isDark = CacheHelper.getData(
    key: 'theme',
  );
  bool? isArabic = CacheHelper.getData(
    key: 'lang',
  );

  if (FoodCubit.getLoggedInUser() == null) {
    widget = LoginScreen();
  } else {
    widget = AppLayout();
  }

  BlocOverrides.runZoned(
    () {
      runApp(MyApp(widget!, isDark ?? false, isArabic ?? false));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  final bool isDark;
  final bool isArabic;

  const MyApp(this.startWidget, this.isDark, this.isArabic, {Key? key})
      : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => FoodCubit()
              ..getUserdata(context: context)
              ..getPosts()
              ..getMyHistoryTransactions()),
        BlocProvider(
            create: (BuildContext context) => PreferencesCubit()
              ..changeAppTheme(themeFromCache: isDark)
              ..changeAppLanguage(appLangFromCache: isArabic)),
      ],
      child: BlocConsumer<PreferencesCubit, PreferencesStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: PreferencesCubit.get(context).darkModeSwitchIsOn
                ? darkTheme
                : lightTheme,
            home: startWidget,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('ar'),
            ],
            locale: PreferencesCubit.get(context).appLangSwitchIsOn
                ? const Locale('ar')
                : const Locale('en'),
          );
        },
      ),
    );
  }
}
