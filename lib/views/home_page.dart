import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:provider/provider.dart';
import 'package:switcher/core/switcher_size.dart';
import 'package:switcher/switcher.dart';
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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50.0,
            ),
            header(context)
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
          padding: EdgeInsets.only(top: 10.0, left: 40.0),
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
                  hintStyle:
                      headingStyle.copyWith(fontWeight: FontWeight.bold)),
              keyboardType: TextInputType.phone,
              cursorColor: HexColor(primaryCol),
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
}
