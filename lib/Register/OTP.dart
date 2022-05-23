import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodwastage/layout/Food_Layout.dart';
import 'package:foodwastage/shared/components/reusable_components.dart';
import 'package:foodwastage/shared/constants.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_cubit.dart';
import 'package:foodwastage/shared/cubit/Register/food_register_cubit.dart';
import 'package:foodwastage/shared/cubit/Register/food_register_state.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class OTP extends StatelessWidget
{
  OTP({Key? key, required this.name,required this.email,
    required this.password,required this.phone,required this.country}) : super(key: key);

  String? name;
  String? email;
  String? password;
  String? phone;
  String? country;
  late String requiredOtp;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>FoodRegisterCubit(),
      child: BlocConsumer<FoodRegisterCubit,FoodRegisterStates>(
        builder: (BuildContext context, Object? state)
        {
          return  Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(19.0),
                    child: Column(

                      children:
                      [
                        const Text('Please enter the verification code that sent to your email',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(height: 20,),
                         Container(
                          child: const Image(
                            image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBn-W_SPwJPOL1eMxz25k95HveGt7M_Uvg_g&usqp=CAU'),
                          ),

                        ),
                        const SizedBox(height: 40,),
                        PinCodeTextField(
                          appContext: context,
                          length: 6,
                          onChanged: (value){
                            print(value);
                          },
                          onCompleted: (value){
                            requiredOtp=value;
                          },
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            fieldHeight: 50,
                            fieldWidth: 50,
                            borderRadius: BorderRadius.circular(5.0),
                            inactiveColor: Colors.grey,
                            activeColor: Colors.deepOrange,

                          ),
                        ),
                        const SizedBox(height: 60,),
                        defaultButton(
                            function: ()
                            {
                              FoodRegisterCubit.get(context).verifyOTP(email, requiredOtp);


                            }, text: 'continue register', context: context)

                      ],
                    ),
                  ),
                ),
              )

          );
        },
        listener: (BuildContext context, state)
        {
          if(state is FoodSuccessVerifyOTPState){
            FoodRegisterCubit.get(context).userRegister(
                name: name!,
                email: email!,
                password: password!,
                phone: phone!,
                country: 'egypt');
          }
          if (state is FoodSuccessCreateState )
          {

            if(uId!=null) {
              FoodCubit.getLoggedInUser();
              FoodCubit.get(context).getUserdata(context: context);
              FoodCubit.get(context).getPosts();
              navigateAndKill(context, const FoodLayout());
            }else{
              FoodCubit.getLoggedInUser();
              navigateAndKill(context, const FoodLayout());
            }


          }
        },

      ),
    );

  }
}
