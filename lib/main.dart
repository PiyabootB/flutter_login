import 'package:flutter/material.dart';
import 'package:flutter_login/covid/covid.dart';
import 'package:flutter_login/covid/CovidStatus.dart';
// import 'package:flutter_login/covid/covidpage.dart';
import 'package:flutter_login/data/models/auth.dart';
import 'package:flutter_login/ui/lockedscreen/device_info.dart';
import 'package:flutter_login/screen/finance.dart';
// import 'package:flutter_login/screen/form_screen.dart';
import 'package:flutter_login/ui/lockedscreen/geolocator.dart';
import 'package:flutter_login/ui/lockedscreen/shared_preferences.dart';
import 'package:persist_theme/persist_theme.dart';
import 'package:provider/provider.dart';

import 'ui/lockedscreen/home.dart';
import 'ui/lockedscreen/settings.dart';
import 'ui/signin/newaccount.dart';
import 'ui/signin/signin.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeModel _model = ThemeModel();
  final AuthModel _auth = AuthModel();

  @override
  void initState() {
    try {
      _auth.loadSettings();
    } catch (e) {
      print("Error Loading Settings: $e");
    }
    try {
      _model.init();
    } catch (e) {
      print("Error Loading Theme: $e");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<ThemeModel>.value(value: _model),
          ChangeNotifierProvider<AuthModel>.value(value: _auth),
        ],
        child: Consumer<ThemeModel>(
          builder: (context, model, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: model.theme,
            home: Consumer<AuthModel>(builder: (context, model, child) {
              // print(model.user);
              if (model?.user != null) return Home();
              return LoginPage();
            }),
            routes: <String, WidgetBuilder>{
              "/login": (BuildContext context) => LoginPage(),
              "/menu": (BuildContext context) => Home(),
              "/home": (BuildContext context) => Home(),
              "/settings": (BuildContext context) => SettingsPage(),
              "/covid": (BuildContext context) => CovidPages(),
              "/device": (BuildContext context) => MyDevice(),
              "/shareprefer": (BuildContext context) => SharePrefer(),
              "/geolocator": (BuildContext context) => HomePage(),
              "/finance": (BuildContext context) => Finance(),
              "/create": (BuildContext context) => CreateAccount(),
            },
          ),
        ));
  }
}
