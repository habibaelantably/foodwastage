

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodwastage/styles/colors.dart';



Widget   deafultFormField ({
  required TextEditingController controller,
  required TextInputType type,
  Function? Onsubmite,
  Function ? Onchanged,
  required Function validator,
  String ? label,
  IconData ? prefix,
  bool isPassword=false ,
  IconData ? suffix,
  Function ? suffixButton,
  String? hint,
  OnTap

})=>  TextFormField(
  controller: controller,
  keyboardType: type,
  validator: (String ? value){
    return validator(value);
  },
  obscureText: isPassword,
  decoration: InputDecoration(
      labelText: label,
      border: UnderlineInputBorder(),
      prefixIcon: Icon(
          prefix
      ),
      suffixIcon: suffix != null ? IconButton(
        onPressed: (){
          suffixButton!();
        },
        icon: Icon(
            suffix
        ),
      ): null,
      hintText: hint,
  ),
    onTap:OnTap
);



Widget deafultbutton({
  double? width,
  double height=30.0,
  Color background = defaultColor,
  bool IsUpperCase=true,
  double radius=0.0,
  required Function function,
  required String text,

})=>Container(
  width: width,
  child: MaterialButton(
    onPressed:(){
      function();
    },
    child: Text(
      IsUpperCase?text.toUpperCase():text,
      style:const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w900,
        fontSize: 20
      ),
    ),
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10.0),
    color: background,
  ),
);

PreferredSizeWidget deafultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>?actions,
})=>AppBar(
    leading:IconButton(
      onPressed: (){
        Navigator.pop(context);
      },
      icon: Icon(Icons.arrow_back_ios),),
    title: Text(title!),
    actions: actions
);



Widget myDivider() => Padding(
  padding: const EdgeInsets.symmetric(vertical: 0.0),
  child:   Container(
    height: 1.0,
    color: Colors.grey[300],
  ),
);

void NavigateTo(context,widget) => Navigator.push(context,
    MaterialPageRoute(
        builder: (context)=> widget
    ));

void NavigateAndKill(context,widget) => Navigator.pushAndRemoveUntil(context,
    MaterialPageRoute(
        builder: (context)=> widget
    ),(Route <dynamic> route){return false;});

void showToast({
  required String text,
  required ToastStates states
})=> Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: setToatColor(states),
    textColor: Colors.white,
    fontSize: 16.0
);

enum ToastStates{SUCCESS,ERROR,WARNING}

Color setToatColor(ToastStates states)
{
  Color ?color;

  switch(states)
  {
    case ToastStates.SUCCESS:
      color=Colors.green;
      break;

    case ToastStates.ERROR:
      color=Colors.red;
      break;

    case ToastStates.WARNING:
      color=Colors.yellow;
      break;
  }
  return color;
}

