import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_cubit.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_states.dart';
import 'package:foodwastage/shared/cubit/Prefrences%20Cubit/prefrences_cubit.dart';
import 'package:foodwastage/styles/colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class PhoneOtpScreen extends StatelessWidget {
  PhoneOtpScreen({Key? key}) : super(key: key);

  late String _otpCode;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoodCubit, FoodStates>(
      listener: (context, state) {
        if(state is PhoneVerifiedSuccessState){
          Navigator.pop(context);
        }
      },
      builder: (context, state){
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.only(
                  right: 32.0, top: 70.0, bottom: 20.0, left: 32.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: (Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.phoneOtpScreenText1,
                      style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    RichText(
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                            text: AppLocalizations.of(context)!.phoneOtpScreenText2,
                            style: TextStyle(fontSize: 17.0, color: PreferencesCubit.get(context).darkModeSwitchIsOn?Colors.white:Colors.black),
                          ),
                          TextSpan(
                            text: FoodCubit.get(context).userModel!.phone,
                            style: const TextStyle(
                                fontSize: 16.0, height: 1.8, color: defaultColor),
                          ),
                        ])),
                    const SizedBox(
                      height: 50.0,
                    ),
                    PinCodeTextField(
                      textStyle: TextStyle(
                        color: PreferencesCubit.get(context).darkModeSwitchIsOn?Colors.black:Colors.white
                      ),
                      appContext: context,
                      cursorColor: Colors.black,
                      autoFocus: true,
                      length: 6,
                      keyboardType: TextInputType.number,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          borderWidth: 1.0,
                          fieldHeight: 50,
                          fieldWidth: 40,
                          activeFillColor: Colors.orange,
                          activeColor: Colors.orange,
                          inactiveFillColor: Colors.white,
                          inactiveColor: Colors.orange,
                          selectedColor: Colors.orange,
                          selectedFillColor: Colors.white),
                      animationDuration: const Duration(milliseconds: 300),
                      backgroundColor: Colors.white,
                      enableActiveFill: true,
                      onCompleted: (code) {
                        _otpCode = code;
                      },
                      onChanged: (value) {},
                    ),
                    const SizedBox(
                      height: 50.0,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: MaterialButton(
                          color: defaultColor,
                          height: 50.0,
                          minWidth: 120.0,
                          onPressed: () {
                            FoodCubit.get(context).submitOTP(_otpCode,context);
                          },
                          child:Text(
                            AppLocalizations.of(context)!.verifyButton,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
              ),
            ),
          ),
        );
      },
    );
  }
}
