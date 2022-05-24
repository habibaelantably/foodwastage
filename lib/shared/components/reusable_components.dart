import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodwastage/models/post_model.dart';
import 'package:foodwastage/styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../modules/Post Overview Screen/post_overview.dart';
import '../../modules/Profile Screen/profile_screen.dart';
import '../constants.dart';
import '../cubit/Food_Cubit/food_cubit.dart';

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
  required Function? function,
  required String text,
  required BuildContext context,
}) =>
    Container(
      height: height,
      width: width,
      child: MaterialButton(
        onPressed: () {
          function!();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
              fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.white),
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
    required FontWeight fontWeight}) {
  return Text(
    text,
    style: TextStyle(
        fontSize: fontSize, fontWeight: fontWeight, color: defaultColor),
  );
}

Widget rowTextAndFormInput({
  required String rowText,
  required double fontSize,
  required FontWeight fontWeight,
  required IconData icon,
  required String hintTextForm,
  TextEditingController? textEditingController,
  Function? validator,
  TextInputType? textInputType,
  List<TextInputFormatter>? inputFormatters,
  int? maxLength,
  bool isEnabled = true,
  String? initialValue,
  Function(String? value)? onChange,
  int linesNumber = 1,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          defaultText(
              text: rowText, fontSize: fontSize, fontWeight: fontWeight),
          Icon(icon, color: defaultColor),
        ],
      ),
      TextFormField(
        maxLength: maxLength,
        minLines: 1,
        maxLines: linesNumber,
        keyboardType: textInputType,
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: hintTextForm,
        ),
        onChanged: (value) {
          if (onChange == null) {
            return;
          } else {
            onChange(value);
          }
        },
        onSaved: (String? value) {},
        validator: (value) => validator!(value),
        inputFormatters: inputFormatters,
        initialValue: initialValue,
        enabled: isEnabled,
      )
    ],
  );
}

Widget postBuilder(
        {required BuildContext context,
        required PostModel postModel,
        required bool viewPost,}) =>
    InkWell(
      onTap: viewPost
          ? () {
              navigateTo(context, PostOverview(postModel: postModel));
            }
          : null,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5.0,
        margin: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 145,
              width: 155,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                  ),
                  image: DecorationImage(
                    image: NetworkImage('${postModel.imageUrl1}'),
                    fit: BoxFit.fill,
                  )),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 37,
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      "${postModel.postDate}",
                      style: const TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                  Text(
                    '${postModel.itemName}',
                    style: Theme.of(context).textTheme.bodyText1,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 7.0,
                  ),
                  Row(
                    children: [
                      InkWell(
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage('${postModel.userImage}'),
                        ),
                        onTap: () {
                            FoodCubit.get(context).getUserdata(
                                selectedUserId: postModel.donorId,
                                context: context);
                            FoodCubit.get(context).getSelectedUserPosts(
                              selectedUserId: postModel.donorId!,
                            );
                          navigateTo(
                            context,
                            ProfileScreen(
                              selectedUserId: postModel.donorId!,
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                  FoodCubit.get(context).getUserdata(
                                      selectedUserId: postModel.donorId,
                                      context: context);
                                  FoodCubit.get(context)
                                      .getSelectedUserPosts(
                                    selectedUserId: postModel.donorId!,
                                  );
                                navigateTo(
                                    context,
                                    ProfileScreen(
                                      selectedUserId: postModel.donorId!,
                                    ));
                              },
                              child: Text("${postModel.userName}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800)),
                            ),
                            Text(
                              '${FoodCubit.get(context).userModel!.type}',
                              style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 12,
                                  fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 2.0),
              height: 145,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [postModel.donorId != uId
                          ? IconButton(
                              onPressed: () {
                                FoodCubit.get(context)
                                    .getFavPosts(postModel);
                              },
                              iconSize: 20,
                              constraints: BoxConstraints.tight(
                                  const Size(35.0, 35.0)),
                              icon: Icon(
                                FoodCubit.get(context).isItFav(postModel) ??
                                        false
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.orange,
                              ),
                            )
                          : PopupMenuButton<String>(
                              icon: const Icon(
                                Icons.more_horiz,
                              ),
                              onSelected: (value) {
                                if (value == "Delete") {
                                  FoodCubit.get(context)
                                      .deletePost(postModel.postId!);
                                }
                              },
                              itemBuilder: (BuildContext context) {
                                return <PopupMenuItem<String>>[
                                  PopupMenuItem(
                                    child: Text(
                                        AppLocalizations.of(context)!
                                            .deleteButton),
                                    value: "Delete",
                                  )
                                ];
                              }),
                  const Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    textBaseline: TextBaseline.alphabetic,
                    children: const [
                      Text(
                        '13',
                        style: TextStyle(color: Colors.orange),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 5.0, right: 5.0),
                        child: Icon(Icons.comment_outlined),
                      ),
                    ],
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );

Widget filterButton(
    {required String filterValue,
    required String text,
    required Function onPressed}) {
  return TextButton(
    style: ButtonStyle(
        elevation: MaterialStateProperty.all(3),
        backgroundColor: MaterialStateProperty.all(filterValue == text
            ? Colors.orange
            : Colors.white),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: const BorderSide(width: 0.05, color: Colors.black)))),
    onPressed: () {
      onPressed();
    },
    child: Text(
      text,
      style: TextStyle(
          color: filterValue == text ? Colors.white : defaultColor,
          fontWeight: FontWeight.bold),
    ),
  );
}
