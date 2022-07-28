import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:switcher/core/switcher_size.dart';
import 'package:switcher/switcher.dart';
import 'package:weather_app/data/models/bodies/date_model.dart';
import 'package:weather_app/providers/theme_provider.dart';
import 'package:weather_app/utils/app_constants.dart';

import 'widgets/curved_line.dart';

class WeekForecast extends StatefulWidget {
  const WeekForecast({Key key}) : super(key: key);

  @override
  State<WeekForecast> createState() => _WeekForecastState();
}

class _WeekForecastState extends State<WeekForecast>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 50.0,
            ),
            header(context),
            const SizedBox(
              height: 40.0,
            ),
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
          padding: const EdgeInsets.only(top: 10.0, left: 65.0),
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
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
          colorOn: const Color.fromARGB(255, 75, 73, 73),
        )
      ],
    );
  }

  Widget tempContainer(context, width, themeProvider) {
    return Stack(children: <Widget>[
      Container(
        margin: const EdgeInsets.only(top: 10.0),
        width: width,
        height: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          gradient: const LinearGradient(
            colors: [Color(0xffc95edb), Color(0xff8bdafe)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
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
            style: GoogleFonts.lato(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color:
                    themeProvider.isLightTheme ? Colors.white : Colors.black),
          )),
        ),
      ),
      const Padding(
          padding: EdgeInsets.only(top: 45.0, left: 20),
          child: Text(
            '32',
            style: TextStyle(fontSize: 150.0),
          )),
      Padding(
        padding: const EdgeInsets.only(
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
          style: GoogleFonts.lato(
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
                const Color(0xffc95edb).withOpacity(0.2),
                const Color(0xff8bdafe).withOpacity(0.2)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20.0),
            color: HexColor(AppColors.primaryCol)),
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Row(
            children: <Widget>[
              Expanded(
                  child: SizedBox(
                      child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(FontAwesomeIcons.wind,
                      color: HexColor(AppColors.weatherICons)),
                  const Text('9km/h',
                      style: TextStyle(fontWeight: FontWeight.bold)),
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
                  const Text('30%',
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
                  const Text(
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

  Widget sunContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 40.0),
          width: 120.0,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xffc95edb).withOpacity(0.1),
                  const Color(0xff8bdafe).withOpacity(0.5)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20.0),
              color: HexColor(AppColors.primaryCol)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: SizedBox(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text(
                        '6H:30',
                        style: TextStyle(
                            fontFamily: 'digital',
                            fontSize: 30.0,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text('Sunrise',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: HexColor(AppColors.greyCol))),
                    ],
                  ))),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 40.0),
          width: 120.0,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xffc95edb).withOpacity(0.1),
                  const Color(0xff8bdafe).withOpacity(0.5)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20.0),
              color: HexColor(AppColors.primaryCol)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: SizedBox(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text(
                        '18H:30',
                        style: TextStyle(
                            fontFamily: 'digital',
                            fontSize: 30.0,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text('Sunset',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: HexColor(AppColors.greyCol))),
                    ],
                  ))),
            ],
          ),
        ),
      ],
    );
  }
}
