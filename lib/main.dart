import 'package:alternate_icons_flutter/app_icon_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_dynamic_icon/flutter_dynamic_icon.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  String currentIconName = "?";

  bool loading = false;

  TextEditingController controller = TextEditingController();
  List<String> entries = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      entries = getPremiumIcons(PremimumIcons.values.toList());
      print(entries.toString());
    });
    FlutterDynamicIcon.getAlternateIconName().then((v) {
      setState(() {
        currentIconName = v ?? "`primary`";
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
    return  MaterialApp(
        home: CupertinoPageScaffold(
          backgroundColor: CupertinoColors.secondarySystemBackground,
        child: NestedScrollView(
        headerSliverBuilder:
        (BuildContext context, bool innerBoxIsScrolled) {
      return <Widget>[
        CupertinoSliverNavigationBar(
          largeTitle: Text("Alternate Icons Flutter",),
        )
      ];
    },
        body: Padding(
          padding: const EdgeInsets.only(left: 16.0,right: 16.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemBuilder: (_, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () async {
                    try {
                      print(await FlutterDynamicIcon.supportsAlternateIcons);
                      if (await FlutterDynamicIcon.supportsAlternateIcons) {
                        await FlutterDynamicIcon.setAlternateIconName(
                            entries[index].asIconName);
                        _scaffoldKey.currentState.hideCurrentSnackBar();
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text("App icon change successful"),
                        ));
                        FlutterDynamicIcon.getAlternateIconName().then((v) {
                          setState(() {
                            currentIconName = v ?? "`primary`";
                          });
                        });
                        return;
                      }
                    } on PlatformException {} catch (e) {}
                    _scaffoldKey.currentState.hideCurrentSnackBar();
                    _scaffoldKey.currentState.showSnackBar(SnackBar(
                      content: Text("Failed to change app icon"),
                    ));
                  },
                  child: Container(
                    width: 44.0,
                      height: 44.0,
                      child: Image.asset(entries[index].asIconAsset))),
            ),
            itemCount: entries.length,
          )

//          ListView(
//            children: <Widget>[
//              Text('ios/${PremimumIcons.appletv.toString()}.png'),
//              Image.asset('ios/appletv.png'),
//              Padding(
//                padding: const EdgeInsets.all(8.0),
//                child: Text(
//                  "Current Icon Name: $currentIconName",
//                  textAlign: TextAlign.center,
//                  style: Theme.of(context).textTheme.headline4,
//                ),
//              ),
//              OutlineButton.icon(
//                icon: Icon(Icons.ac_unit),
//                label: Text("Face Time"),
//
//              ),
//              OutlineButton.icon(
//                icon: Icon(Icons.ac_unit),
//                label: Text("Photos"),
//                onPressed: () async {
//                  try {
//                    if (await FlutterDynamicIcon.supportsAlternateIcons) {
//                      await FlutterDynamicIcon.setAlternateIconName("photos");
//                      _scaffoldKey.currentState.hideCurrentSnackBar();
//                      _scaffoldKey.currentState.showSnackBar(SnackBar(
//                        content: Text("App icon change successful"),
//                      ));
//                      FlutterDynamicIcon.getAlternateIconName().then((v) {
//                        setState(() {
//                          currentIconName = v ?? "`primary`";
//                        });
//                      });
//                      return;
//                    }
//                  } on PlatformException {} catch (e) {}
//                  _scaffoldKey.currentState.hideCurrentSnackBar();
//                  _scaffoldKey.currentState.showSnackBar(SnackBar(
//                    content: Text("Failed to change app icon"),
//                  ));
//                },
//              ),
//              OutlineButton.icon(
//                icon: Icon(Icons.ac_unit),
//                label: Text("Calc"),
//                onPressed: () async {
//                  try {
//                    if (await FlutterDynamicIcon.supportsAlternateIcons) {
//                      await FlutterDynamicIcon.setAlternateIconName("calc");
//                      _scaffoldKey.currentState.hideCurrentSnackBar();
//                      _scaffoldKey.currentState.showSnackBar(SnackBar(
//                        content: Text("App icon change successful"),
//                      ));
//                      FlutterDynamicIcon.getAlternateIconName().then((v) {
//                        setState(() {
//                          currentIconName = v ?? "`primary`";
//                        });
//                      });
//                      return;
//                    }
//                  } on PlatformException {} catch (e) {}
//                  _scaffoldKey.currentState.hideCurrentSnackBar();
//                  _scaffoldKey.currentState.showSnackBar(SnackBar(
//                    content: Text("Failed to change app icon"),
//                  ));
//                },
//              ),
//              SizedBox(
//                height: 28,
//              ),
//              OutlineButton.icon(
//                icon: Icon(Icons.restore_outlined),
//                label: Text("Restore Icon"),
//                onPressed: () async {
//                  try {
//                    if (await FlutterDynamicIcon.supportsAlternateIcons) {
//                      await FlutterDynamicIcon.setAlternateIconName(null);
//                      _scaffoldKey.currentState.hideCurrentSnackBar();
//                      _scaffoldKey.currentState.showSnackBar(SnackBar(
//                        content: Text("App icon restore successful"),
//                      ));
//                      FlutterDynamicIcon.getAlternateIconName().then((v) {
//                        setState(() {
//                          currentIconName = v ?? "`primary`";
//                        });
//                      });
//                      return;
//                    }
//                  } on PlatformException {} catch (e) {}
//                  _scaffoldKey.currentState.hideCurrentSnackBar();
//                  _scaffoldKey.currentState.showSnackBar(SnackBar(
//                    content: Text("Failed to change app icon"),
//                  ));
//                },
//              ),
//            ],
//          ),
        ),
      ),
    ));
  }
}