import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodwastage/components/constants.dart';
import 'package:foodwastage/components/reusable_components.dart';
import 'package:foodwastage/modules/History%20Screen/history_screen.dart';
import 'package:foodwastage/modules/login_Screen.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_cubit.dart';
import 'package:foodwastage/shared/cubit/Prefrences%20Cubit/prefrences_cubit.dart';
import '../modules/Profile Screen/profile_screen.dart';
import '../styles/colors.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    final _userModel = FoodCubit.get(context).userModel;
    final _size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        width: _size.width * 0.7,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              /// Profile image and Rating
              SizedBox(
                height: _size.height * 0.25,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (_userModel!.image != null && _userModel.image != '')
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(_userModel.image!),
                        backgroundColor: Colors.amber[900],
                      ),
                    if (_userModel.image == null || _userModel.image == '')
                      CircleAvatar(
                        radius: 50,
                        backgroundImage:
                        const AssetImage('assets/images/profile.png'),
                        backgroundColor: Colors.amber[900],
                      ),
                    const SizedBox(
                      height: 12,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "${_userModel.name} ",
                            style: const TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: "(${_userModel.type})",
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black54,
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                        ]
                      ),
                    ),
                    const SizedBox(height: 7.0,),
                    RatingBar(
                      initialRating: _userModel.rating!,
                      itemSize: 25.0,
                      ignoreGestures: _userModel.uId == uId ? true : false,
                      itemCount: 5,
                      direction: Axis.horizontal,
                      ratingWidget: RatingWidget(
                        full: const Icon(
                          Icons.star,
                          color: defaultColor,
                        ),
                        half: const Icon(
                          Icons.star_half,
                          color: defaultColor,
                        ),
                        empty: const Icon(
                          Icons.star_border,
                          color: defaultColor,
                        ),
                      ),
                      minRating: 1,
                      maxRating: 5,
                      onRatingUpdate: (double value) {},
                    ),
                  ],
                ),
              ),
              myDivider(),
              /// Drawer Properties
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 30,
                        child: ListTile(
                          dense: true,
                          horizontalTitleGap: 1,
                          contentPadding: const EdgeInsets.all(1),
                          minVerticalPadding: 0,
                          leading: const FaIcon(
                            FontAwesomeIcons.solidCircleUser,
                            color: Colors.black,
                            size: 20,
                          ),
                          title: const Text(
                            'Profile',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            navigateTo(
                                context,
                                ProfileScreen(
                                  selectedUserId: uId!,
                                ));
                          },
                        ),
                      ),
                      const SizedBox(height: 15.0,),
                      SizedBox(
                        height: 30,
                        child: ListTile(
                          dense: true,
                          horizontalTitleGap: 1,
                          contentPadding: const EdgeInsets.all(1),
                          minVerticalPadding: 0,
                          leading: const FaIcon(
                            FontAwesomeIcons.clockRotateLeft,
                            color: Colors.black,
                            size: 20,
                          ),
                          title: const Text('History',style: TextStyle(
                            fontSize: 16,
                          ),
                          ),
                          onTap: () {
                            FoodCubit.get(context).getMyReceivedFood();
                            Navigator.pop(context);
                            navigateTo(context, const HistoryScreen());
                          },
                        ),
                      ),
                      const SizedBox(height: 15.0,),
                      SizedBox(
                        height: 30,
                        child: ListTile(
                            dense: true,
                            horizontalTitleGap: 1,
                            contentPadding: const EdgeInsets.all(1),
                            minVerticalPadding: 0,
                            leading: const FaIcon(
                              FontAwesomeIcons.solidMoon,
                              color: Colors.black,
                              size: 20,
                            ),
                            title: const Text('Dark Mode:',style: TextStyle(
                              fontSize: 16,
                            ),
                            ),
                            trailing: Switch(
                                value: PreferencesCubit.get(context)
                                    .darkModeSwitchIsOn,
                                onChanged: (newValue) {
                                  setState(() {
                                    PreferencesCubit.get(context)
                                        .changeAppTheme();
                                  });
                                })),
                      ),
                      const SizedBox(height: 15.0,),
                      SizedBox(
                        height: 30,
                        child: ListTile(
                          dense: true,
                          horizontalTitleGap: 1,
                          contentPadding: const EdgeInsets.all(1),
                          minVerticalPadding: 0,
                          leading: const FaIcon(
                            FontAwesomeIcons.solidMessage,
                            color: Colors.black,
                            size: 20,
                          ),
                          title: const Text('Language:', style: TextStyle(
                            fontSize: 16,
                          ),
                          ),
                          trailing: Switch(
                              value: PreferencesCubit.get(context).appLangSwitchIsOn,
                              activeThumbImage: const NetworkImage('https://lists.gnu.org/archive/html/emacs-devel/2015-10/pngR9b4lzUy39.png'),
                              inactiveThumbImage:  const NetworkImage('http://wolfrosch.com/_img/works/goodies/icon/vim@2x'),
                              onChanged: (value){
                                setState(() {
                                  PreferencesCubit.get(context).changeAppLanguage();
                                });
                              })
                        ),
                      ),
                      const SizedBox(height: 15.0,),
                      SizedBox(
                        height: 30,
                        child: ListTile(
                          dense: true,
                          horizontalTitleGap: 1,
                          contentPadding: const EdgeInsets.all(1),
                          minVerticalPadding: 0,
                          leading: const FaIcon(
                            FontAwesomeIcons.circleInfo,
                            color: Colors.black,
                            size: 18,
                          ),
                          title: const Text('About us',style: TextStyle(
                            fontSize: 16,
                          ),
                          ),
                          onTap: () {
                          },
                        ),
                      ),
                      const SizedBox(height: 15.0,),
                      SizedBox(
                        height: 30,
                        child: ListTile(
                          dense: true,
                          horizontalTitleGap: 1,
                          contentPadding: const EdgeInsets.all(1),
                          minVerticalPadding: 0,
                          leading: const FaIcon(
                            FontAwesomeIcons.headset,
                            color: Colors.black,
                            size: 20,
                          ),
                          title: const Text('Contact us',style: TextStyle(
                            fontSize: 16,
                          ),
                          ),
                          onTap: () {
                          },
                        ),
                      ),
                      const SizedBox(height: 15.0,),
                      SizedBox(
                        height: 30,
                        child: ListTile(
                          dense: true,
                          horizontalTitleGap: 1,
                          contentPadding: const EdgeInsets.all(1),
                          minVerticalPadding: 0,
                          leading: const FaIcon(
                            FontAwesomeIcons.fileContract,
                            color: Colors.black,
                            size: 20,
                          ),
                          title: const Text('Terms & Conditions',style: TextStyle(
                            fontSize: 16,
                          ),
                          ),
                          onTap: () {
                          },
                        ),
                      ),
                      const SizedBox(height: 15.0,),
                      SizedBox(
                        height: 30,
                        child: ListTile(
                          dense: true,
                          horizontalTitleGap: 1,
                          contentPadding: const EdgeInsets.all(1),
                          minVerticalPadding: 0,
                          leading: const FaIcon(
                            FontAwesomeIcons.arrowRightFromBracket,
                            color: Colors.black,
                            size: 20,
                          ),
                          title: const Text('Logout',style: TextStyle(
                            fontSize: 16,
                          ),
                          ),
                          onTap: () {
                            FoodCubit.get(context).logout();
                            navigateAndKill(context, LoginScreen());
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
