import 'package:flutter/material.dart';
import 'package:foodwastage/shared/cubit/Prefrences%20Cubit/prefrences_cubit.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          children:  [
            PreferencesCubit.get(context).darkModeSwitchIsOn ? const Image(image: AssetImage("assets/images/logo_white.png")):const Image(image: AssetImage("assets/images/logo_black.png")),
            const Text(
                "Sharek is an application that aims to connect customers with stores which are throwing away their unsold food.\n"
                    "Aiming to reduce food wastage in Egypt then the entire Arab world by encouraging people to donate food",style: TextStyle(height: 1.5,fontSize: 15.0),),
          ],
        ),
      ),
    );
  }
}
