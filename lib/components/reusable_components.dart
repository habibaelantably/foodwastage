import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodwastage/styles/colors.dart';

Widget defaultFormField(
        {required TextEditingController controller,
        required TextInputType type,
        Function? onSubmit,
        Function? onChanged,
        required Function validator,
        String? label,
        IconData? prefix,
        bool isPassword = false,
        IconData? suffix,
        Function? suffixButton,
        String? hint,
        onTap}) =>
    TextFormField(
        controller: controller,
        keyboardType: type,
        validator: (String? value) {
          return validator(value);
        },
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          border: const UnderlineInputBorder(),
          prefixIcon: Icon(prefix),
          suffixIcon: suffix != null
              ? IconButton(
                  onPressed: () {
                    suffixButton!();
                  },
                  icon: Icon(suffix),
                )
              : null,
          hintText: hint,
        ),
        onTap: onTap);

Widget defaultButton({
  double? width,
  double height = 30.0,
  Color background = defaultColor,
  bool isUpperCase = true,
  double radius = 0.0,
  required Function function,
  required String text,
}) =>
    Container(
      height: height,
      width: width,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w900, fontSize: 20),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: background,
      ),
    );

PreferredSizeWidget defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) =>
    AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(title!),
        actions: actions);

Widget myDivider() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      child: Container(
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndKill(context, widget) => Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => widget),
        (Route<dynamic> route) {
      return false;
    });

void showToast({required String text, required ToastStates states}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: setToastColor(states),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { SUCCESS, ERROR, WARNING }

Color setToastColor(ToastStates states) {
  Color? color;

  switch (states) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;

    case ToastStates.ERROR:
      color = Colors.red;
      break;

    case ToastStates.WARNING:
      color = Colors.yellow;
      break;
  }
  return color;
}

Widget defaultText(
    {required String text,
    required double fontSize,
    required Color color,
    required FontWeight fontWeight}) {
  return Text(
    text,
    style: TextStyle(fontSize: fontSize, color: color, fontWeight: fontWeight),
  );
}

Widget rowTextAndFormInput(
    {required String rowText,
    required double fontSize,
    TextEditingController? textEditingController,
    Function? validator,
    TextInputType? textInputType,
    List<TextInputFormatter>? inputFormatters,
    required Color color,
    required FontWeight fontWeight,
    required IconData icon,
    bool isReadonly = false,
    String? initialValue,
    required String hintTextForm}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          defaultText(
              text: rowText,
              fontSize: fontSize,
              color: color,
              fontWeight: fontWeight),
          Icon(icon, color: defaultColor),
        ],
      ),
      TextFormField(
        keyboardType: textInputType,
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: hintTextForm,
        ),
        onSaved: (String? value) {},
        validator: (value) => validator!(value),
        inputFormatters: inputFormatters,
        initialValue: initialValue!,
        readOnly: isReadonly,
      )
    ],
  );
}
