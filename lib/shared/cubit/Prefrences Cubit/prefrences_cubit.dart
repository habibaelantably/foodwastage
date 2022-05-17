import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodwastage/shared/cubit/Prefrences%20Cubit/prefrences_states.dart';
import '../../../network/local/cache_helper.dart';

class PreferencesCubit extends Cubit<PreferencesStates> {
  PreferencesCubit() : super(ThemeInitialState());

  static PreferencesCubit get(context) => BlocProvider.of(context);

  bool darkModeSwitchIsOn = false;
  bool appLangSwitchIsOn = false;

  void changeAppTheme({bool? themeFromCache}) {
    if (themeFromCache != null) {
      darkModeSwitchIsOn = themeFromCache;
      if (themeFromCache == true) {
        SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(systemNavigationBarColor: Color(0xff2b2b2b)));
      }
    } else {
      darkModeSwitchIsOn = !darkModeSwitchIsOn;
      CacheHelper.saveData(key:'theme',value: darkModeSwitchIsOn, );
      if (darkModeSwitchIsOn) {
        SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
            systemNavigationBarColor: Color(0xff2b2b2b),
            systemNavigationBarIconBrightness: Brightness.light));
      } else {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.grey[100],
            systemNavigationBarIconBrightness: Brightness.dark));
      }
    }
    emit(ChangeThemeState());
  }

  void changeAppLanguage({bool? appLangFromCache}){
    if(appLangFromCache!=null){
      appLangSwitchIsOn = appLangFromCache;
    }
    else{
      appLangSwitchIsOn = !appLangSwitchIsOn;
      CacheHelper.saveData(key: 'lang', value: appLangSwitchIsOn);
    }
    emit(ChangeLanguageState());
  }
  }
