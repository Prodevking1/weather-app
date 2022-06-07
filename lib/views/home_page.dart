import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:switcher/core/switcher_size.dart';
import 'package:switcher/switcher.dart';
import 'package:weather_app/models/date_model.dart';
import 'package:weather_app/providers/theme_provider.dart';
import 'package:weather_app/utils/app_constants.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50.0,
            ),
            header(context),
            SizedBox(
              height: 45.0,
            ),
            tempContainer(context, size.width, themeProvider),
            SizedBox(
              height: 15.0,
            ),
            infoContainer(context),
          ],
        ),
      ),
    );
  }

  Widget header(context) {
    var isActive = false;
    AnimationController animationController;
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            setState(() {
              isActive = !isActive;
              isActive
                  ? animationController.forward()
                  : animationController.reverse();
            });
          },
          child: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: animationController,
            size: 40.0,
          ),
        ),
        Expanded(
            child: Padding(
          padding: EdgeInsets.only(top: 10.0, left: 65.0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            height: 60.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: TextFormField(
              decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  border: InputBorder.none,
                  hintText: 'Ouagadougou',
                  hintStyle: AppStyle.headingStyle
                      .copyWith(fontWeight: FontWeight.bold)),
              style:
                  AppStyle.headingStyle.copyWith(fontWeight: FontWeight.bold),
              keyboardType: TextInputType.text,
            ),
          ),
        )),
        Switcher(
          onChanged: (value) {},
          onTap: () {
            themeProvider.toggleThemeData();
          },
          value: themeProvider.isLightTheme ? false : true,
          size: SwitcherSize.medium,
          switcherButtonRadius: 50,
          enabledSwitcherButtonRotate: true,
          iconOff: Icons.sunny,
          iconOn: Icons.nightlight,
          colorOff: Colors.blueGrey.withOpacity(0.3),
          colorOn: Color.fromARGB(255, 75, 73, 73),
        )
      ],
    );
  }

  Widget tempContainer(context, width, themeProvider) {
    return Stack(children: <Widget>[
      Container(
        margin: EdgeInsets.only(top: 10.0),
        width: width,
        height: 250,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.0),
            gradient: LinearGradient(
              colors: [Color(0xffc95edb), Color(0xff8bdafe)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              /* BoxShadow(
              color: HexColor(primaryCol).withOpacity(0.3),
              blurRadius: 10.0,
              spreadRadius: -6.0,
              offset: const Offset(-2, -25.0),
            ) */
            ]),
      ),
      Positioned(
        left: width / 4,
        child: Container(
          height: 30.0,
          width: width / 2.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: themeProvider.isLightTheme ? Colors.black : Colors.white,
          ),
          child: Center(
              child: Text(
            TodayDate().getTodayDate(),
            style: AppStyle.headingStyle.copyWith(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color:
                    themeProvider.isLightTheme ? Colors.white : Colors.black),
          )),
        ),
      ),
      Padding(
          padding: EdgeInsets.only(top: 45.0, left: 20),
          child: Text(
            '32',
            style: TextStyle(fontSize: 150.0),
          )),
      Padding(
        padding: EdgeInsets.only(
          left: 190.0,
          top: 70.0,
        ),
        child: Container(
          width: 25.0,
          height: 15.0,
          decoration: BoxDecoration(
            border: Border.all(
                width: 2.0,
                color:
                    themeProvider.isLightTheme ? Colors.black : Colors.white),
            shape: BoxShape.circle,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(
          left: width / 1.7,
          top: 80.0,
        ),
        child: Text(
          'Sunny'.toUpperCase(),
          textScaleFactor: 2.0,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: width / 3.5, left: width / 2.5),
        child: Lottie.asset(RessourcesPath.sunnyLottie, width: 220.0),
      ),
    ]);
  }

  Widget infoContainer(context) {
    return Container(
        height: 150,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xffc95edb).withOpacity(0.2),
                Color(0xff8bdafe).withOpacity(0.2)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20.0),
            color: HexColor(AppColors.primaryCol)),
        child: Padding(
          padding: EdgeInsets.all(25),
          child: Row(
            children: <Widget>[
              Expanded(
                  child: SizedBox(
                      child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(FontAwesomeIcons.wind,
                      color: HexColor(AppColors.weatherICons)),
                  Text('9km/h', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Wind',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: HexColor(AppColors.greyCol))),
                ],
              ))),
              Expanded(
                  child: SizedBox(
                      child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(FontAwesomeIcons.droplet,
                      color: HexColor(AppColors.weatherICons)),
                  Text('30%',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                  Text(
                    'Humidity',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: HexColor(AppColors.greyCol)),
                  ),
                ],
              ))),
              Expanded(
                  child: SizedBox(
                      child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(FontAwesomeIcons.minimize,
                      color: HexColor(AppColors.weatherICons)),
                  Text(
                    '1008',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Pressure',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: HexColor(AppColors.greyCol))),
                ],
              ))),
            ],
          ),
        ));
  }

  Widget sunContainer() {}
}
