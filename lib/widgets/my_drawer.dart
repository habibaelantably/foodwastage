import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../shared/cubit/Food_Cubit/food_cubit.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    final _userModel = FoodCubit.get(context).userModel;
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        width: size.width * 0.7,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              /// Profile image and Rating
              SizedBox(
                height: size.height * 0.25,
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
                      height: 10,
                    ),
                    const Text(
                      'USER A. USER',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star,
                          size: 20,
                          color: Colors.amber[400],
                        ),
                        Icon(
                          Icons.star,
                          size: 20,
                          color: Colors.amber[400],
                        ),
                        Icon(
                          Icons.star,
                          size: 20,
                          color: Colors.amber[400],
                        ),
                        Icon(
                          Icons.star,
                          size: 20,
                          color: Colors.amber[400],
                        ),
                        Icon(
                          Icons.star_border,
                          size: 20,
                          color: Colors.amber[400],
                        ),
                      ],
                    )
                  ],
                ),
              ),

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
                            size: 18,
                          ),
                          title: const Text(
                            'Profile',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          // trailing: const Icon(
                          //   Icons.arrow_forward_ios_rounded,
                          //   color: Colors.black,
                          //   size: 15,
                          // ),
                          onTap: () {
                            // Navigate to Profile Screen
                          },
                        ),
                      ),
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
                            size: 18,
                          ),
                          title: const Text('History'),
                          // trailing: const Icon(
                          //   Icons.arrow_forward_ios_rounded,
                          //   color: Colors.black, size: 15,
                          // ),
                          onTap: () {
                            // Navigate to History Screen
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                        child: ListTile(
                          dense: true,
                          horizontalTitleGap: 1,
                          contentPadding: const EdgeInsets.all(1),
                          minVerticalPadding: 0,
                          leading: FaIcon(
                            FontAwesomeIcons.solidMoon,
                            color: Colors.black,
                            size: 18,
                          ),
                          title: Text('Dark Mode:'),
                          // trailing: CupertinoSwitch(
                          //     value: _darkModeSwitchValue,
                          //     onChanged: (val) {
                          //       setState(() {
                          //         _darkModeSwitchValue = val;
                          //       });
                          //     }),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                        child: ListTile(
                          dense: true,
                          horizontalTitleGap: 1,
                          contentPadding: EdgeInsets.all(1),
                          minVerticalPadding: 0,
                          leading: FaIcon(
                            FontAwesomeIcons.solidMessage,
                            color: Colors.black,
                            size: 18,
                          ),
                          title: Text('Language:'),
                          // trailing: CupertinoSwitch(
                          //     value: _languageSwitchValue,
                          //     onChanged: (val) {
                          //       setState(() {
                          //         _languageSwitchValue = val;
                          //       });
                          //     }),
                        ),
                      ),
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
                          title: const Text('About us'),
                          // trailing: const Icon(
                          //   Icons.arrow_forward_ios_rounded,
                          //   color: Colors.black, size: 15,
                          // ),
                          onTap: () {
                            // Navigate to About us Screen
                          },
                        ),
                      ),
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
                            size: 18,
                          ),
                          title: const Text('Contact us'),
                          // trailing: const Icon(
                          //   Icons.arrow_forward_ios_rounded,
                          //   color: Colors.black, size: 15,
                          // ),
                          onTap: () {
                            // Navigate to Contact us Screen
                          },
                        ),
                      ),
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
                            size: 18,
                          ),
                          title: const Text('Terms & Conditions'),
                          // trailing: const Icon(
                          //   Icons.arrow_forward_ios_rounded,
                          //   color: Colors.black, size: 15,
                          // ),
                          onTap: () {
                            // Navigate to Terms & Conditions Screen
                          },
                        ),
                      ),
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
                            size: 18,
                          ),
                          title: const Text('Logout'),
                          // trailing: const Icon(
                          //   Icons.arrow_forward_ios_rounded,
                          //   color: Colors.black, size: 15,
                          // ),
                          onTap: () {
                            // Code to logout Screen
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
