// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:foodwastage/layout/App_Layout.dart';
// import 'package:foodwastage/shared/components/reusable_components.dart';
// import 'package:foodwastage/shared/constants.dart';
// import 'package:foodwastage/shared/cubit/Food_Cubit/food_cubit.dart';
// import 'package:foodwastage/shared/cubit/Register/food_register_cubit.dart';
// import 'package:foodwastage/shared/cubit/Register/food_register_state.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//
// // ignore: must_be_immutable
// class OTP extends StatelessWidget {
//   OTP(
//       {Key? key,
//       required this.name,
//       required this.email,
//       required this.password,
//       required this.phone,
//       required this.country})
//       : super(key: key);
//
//   String? name;
//   String? email;
//   String? password;
//   String? phone;
//   String? country;
//   late String requiredOtp;
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (BuildContext context) => FoodRegisterCubit(),
//       child: BlocConsumer<FoodRegisterCubit, FoodRegisterStates>(
//         builder: (BuildContext context, Object? state) {
//           return Scaffold(
//               body: SafeArea(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(19.0),
//                 child: Column(
//                   children: [
//                     Text(
//                       AppLocalizations.of(context)!
//                           .otpScreenHint,
//                       style: const TextStyle(
//                           fontSize: 20.0, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     const Image(
//                       image: NetworkImage(
//                           'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBn-W_SPwJPOL1eMxz25k95HveGt7M_Uvg_g&usqp=CAU'),
//                     ),
//                     const SizedBox(
//                       height: 40,
//                     ),
//                     PinCodeTextField(
//                       appContext: context,
//                       length: 6,
//                       onChanged: (value) {
//                       },
//                       onCompleted: (value) {
//                         requiredOtp = value;
//                       },
//                       pinTheme: PinTheme(
//                         shape: PinCodeFieldShape.box,
//                         fieldHeight: 50,
//                         fieldWidth: 50,
//                         borderRadius: BorderRadius.circular(5.0),
//                         inactiveColor: Colors.grey,
//                         selectedColor: Colors.orange,
//                         activeColor: Colors.orange,
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 60,
//                     ),
//                     defaultButton(
//                       height: 50,
//                         function: () {
//                           FoodRegisterCubit.get(context)
//                               .verifyOTP(email, requiredOtp);
//                         },
//                         text: AppLocalizations.of(context)!
//                             .continueRegisterButton,
//                         context: context)
//                   ],
//                 ),
//               ),
//             ),
//           ));
//         },
//         listener: (BuildContext context, state) {
//           if (state is FoodSuccessVerifyOTPState) {
//             FoodRegisterCubit.get(context).userRegister(
//                 name: name!,
//                 email: email!,
//                 password: password!,
//                 phone: phone!,
//                 country: 'egypt');
//           }
//           if (state is FoodSuccessCreateState) {
//             if (uId != null) {
//               FoodCubit.getLoggedInUser();
//               FoodCubit.get(context).getUserdata(context: context);
//               FoodCubit.get(context).getPosts();
//               navigateAndKill(context, AppLayout());
//             } else {
//               FoodCubit.getLoggedInUser();
//               navigateAndKill(context, AppLayout());
//             }
//           }
//         },
//       ),
//     );
//   }
// }
