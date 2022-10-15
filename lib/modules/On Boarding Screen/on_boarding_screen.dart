import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodwastage/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../network/local/cache_helper.dart';
import '../../shared/components/reusable_components.dart';
import '../Login Screen/login_Screen.dart';

class OnBoardingModel {
  final String text;
  final String image;

  OnBoardingModel(this.text, this.image);
}

// ignore: must_be_immutable
class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  var boardingController = PageController();

  List<OnBoardingModel> boardingItems = [
    OnBoardingModel(
        'world hunger is on the rise', 'assets/images/onBoardingImg3.jpg'),
    OnBoardingModel('stop throwing away your leftovers',
        'assets/images/onBoardingImg1.jpg'),
    OnBoardingModel('instead start sharing and save lives',
        'assets/images/onBoardingImg2.jpg'),
  ];

  void getStarted(context) {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigateAndKill(context, LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,

        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          PageView.builder(
            allowImplicitScrolling: true,
            controller: boardingController,
            itemCount: boardingItems.length,
            itemBuilder: (context, index) =>
                onBoardingItem(onBoardingModel: boardingItems[index]),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: screenHeight * 0.71,
                ),
                SmoothPageIndicator(
                    effect: CustomizableEffect(
                      spacing: 20,
                      dotDecoration: DotDecoration(
                        width: 11,
                        height: 11,
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                        verticalOffset: 0,
                        dotBorder: const DotBorder(
                          padding: 4,
                          width: 2,
                          color: Colors.white,
                        ),
                      ),
                      activeDotDecoration: DotDecoration(
                        width: 13,
                        height: 13,
                        color: defaultColor,
                        rotationAngle: 180,
                        borderRadius: BorderRadius.circular(24),
                        dotBorder: const DotBorder(
                          padding: 4,
                          width: 2,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                    controller: boardingController,
                    count: boardingItems.length),
                SizedBox(
                  height: screenHeight * 0.06,
                ),
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(5.0)),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: MaterialButton(
                    onPressed: () {
                      getStarted(context);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.getStartedButton,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                    height: screenHeight * 0.074,
                    minWidth: screenWidth * 0.82,
                    color: defaultColor,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget onBoardingItem({required OnBoardingModel onBoardingModel}) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(onBoardingModel.image), )),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Center(
          child: Text(
            onBoardingModel.text.toUpperCase(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.w900,
              color: defaultColor,
            ),
          ),
        ),
      ),
    );
  }
}
