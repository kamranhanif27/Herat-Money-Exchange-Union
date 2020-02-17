import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:bmnav/bmnav.dart' as bmnav;
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:http/http.dart';
import 'package:moneyexchangeunion/Scren/aboutTotia.dart';
import 'package:moneyexchangeunion/Scren/feedback_screen.dart';
import 'package:moneyexchangeunion/Scren/news.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:moneyexchangeunion/Scren/custom_dialog.dart' as customDialog;
import './Scren/about.dart';

import 'Scren/Static.dart';
import 'Scren/aboutApp.dart';
import 'Scren/account.dart';
import 'Scren/first.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'اتحادیه صرافان',
      home: SplashScreen(),
      theme: ThemeData(primaryColor: Colors.blue, fontFamily: 'IranSans'),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],

      supportedLocales: [
        Locale("fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales
        const Locale('en'), // English
      ],
      locale: Locale('en')));
}

class MainWidget extends StatefulWidget {
  @override
  MainWidgetState createState() => MainWidgetState();
}

class MainWidgetState extends State<MainWidget> {

  bool active = true;
  void _checkFirebase() async{
    DocumentReference qs =
    Firestore.instance.collection('check').document('check');
    DocumentSnapshot snap = await qs.get();
    if(snap.data['active'] == true) {
      setState(() {
        active = true;
      });
      print(active);
    } else {
      setState(() {
        active = false;
      });
      print(active);
    }
  }

  Future<List<dynamic>> _getData({String date}) async {
      Response response =
      await get('https://tutiatech.com/wp-json/wp/v2/advertise');

      if (response.statusCode == 200) {
          var data = json.decode(response.body);
          return data;
        } else {
          print(response.statusCode);
          return null;
      }
  }


  void _showAd(image,link) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: customDialog.AlertDialog(
            contentPadding: EdgeInsets.all(5.0),
            titlePadding: EdgeInsets.all(1.0),
            title: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                padding: EdgeInsets.all(2.0),
                icon: Icon(Icons.close, size: 18.0,),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            content: InkWell(
              child: Image(
                image: image,
              ),
              onTap: () async {
                await launch(link);
              },
            ),
          ),
        );
      }
    );
  }

  bool isOffline = false;

  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      setState(() {
        isOffline = false;
      });
      return false;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        isOffline = false;
      });
      return false;
    }
    setState(() {
      isOffline = true;
    });
    return true;
  }

  Timer timer;
  void initState() {
    super.initState();
    _checkFirebase();
    Timer(Duration(seconds: 1), () => _getData().then((res) {
      Random rnd;
      int min = 0;
      int max = res.length;
      rnd = new Random();
      var r = min + rnd.nextInt(max - min);
      String link = Html(data: res[0]['excerpt']['rendered']).data;
      String removeAllHtmlTags(String htmlText) {
        RegExp exp = RegExp(
            r"<[^>]*>",
            multiLine: true,
            caseSensitive: true
        );

        return htmlText.replaceAll(exp, '');
      }
      String linkData = removeAllHtmlTags(link);
      var _image = NetworkImage(Uri.encodeFull(res[0]['better_featured_image']['source_url']));
      _image.resolve(ImageConfiguration()).addListener(
        ImageStreamListener(
              (info, call) {
                _showAd(_image, linkData);
            // do something
          },
        ),
      );
    }) );
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) => check());
  }

  int currentTab = 0;
  final List<Widget> screens = [
    ListData(),
    StaticDta(),
    CalCulate(),
    NewsScreen(),
    About(),
  ];

  Choice _selectedChoice = choices[0];

  void _select(Choice choice) {
    // Causes the app to rebuild with the new _selectedChoice.
    setState(() {
      _selectedChoice = choice;
    });
  }

  Widget currentScreen = ListData();

  final PageStorageBucket bucket = PageStorageBucket();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext ctx) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return active == false ?  Scaffold(
      body: Center(child: CircularProgressIndicator(),),
      ) : isOffline == true
        ?
    Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.network_check, size: 76.0,color: Colors.blueAccent,),
            SizedBox(height: 15.0,),
            Text('لطفا به شبکه متصل شوید!', textDirection: TextDirection.rtl, style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    )
        :
    Scaffold(
      endDrawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors
              .white, //This will change the drawer background to blue.
          //other styles
        ),
        child: Drawer(
          key: _scaffoldKey,
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text(''),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    image: DecorationImage(
                        image: AssetImage("images/banner.jpg"),
                        fit: BoxFit.fill,),),
              ),
              ListTile(
                dense: true,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  textDirection: TextDirection.rtl,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          'نرخ لحظه ای',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                              fontSize: 16),
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Icon(Icons.hourglass_empty, color: Colors.blue,),
                      ],
                    ),
                    Icon(Icons.arrow_left, color: Colors.blue,),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => Scaffold(
                            appBar: AppBar(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'نرخ لحظه ای',
                                      ))
                                ],
                              ),
                            ),
                            body: ListData(),
                          )));
                },
              ),
              ListTile(
                dense: true,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  textDirection: TextDirection.rtl,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          'نرخ روزانه',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                              fontSize: 16),
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Icon(Icons.schedule, color: Colors.blue,),
                      ],
                    ),
                    Icon(Icons.arrow_left, color: Colors.blue,),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => Scaffold(
                            appBar: AppBar(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'انرخ روزانه',
                                      ))
                                ],
                              ),
                            ),
                            body: StaticDta(),
                          )));
                },
              ),
              ListTile(
                dense: true,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  textDirection: TextDirection.rtl,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          'تبدیل اسعار',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                              fontSize: 16),
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Icon(Icons.swap_horiz, color: Colors.blue,),
                      ],
                    ),
                    Icon(Icons.arrow_left, color: Colors.blue,),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => Scaffold(
                            appBar: AppBar(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'تبدیل اسعار',
                                      ))
                                ],
                              ),
                            ),
                            body: CalCulate(),
                          )));
                },
              ),
              ListTile(
                dense: true,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  textDirection: TextDirection.rtl,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          'اطلاعیه ها',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                              fontSize: 16),
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Icon(Icons.receipt, color: Colors.blue,),
                      ],
                    ),
                    Icon(Icons.arrow_left, color: Colors.blue,),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => Scaffold(
                        appBar: AppBar(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'اطلاعیه ها',
                                  ))
                            ],
                          ),
                        ),
                        body: NewsScreen(),
                      )));
                },
              ),
              Divider(),
              ListTile(
                dense: true,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  textDirection: TextDirection.rtl,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          'درباره اتحادیه صرافان هرات',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                              fontSize: 16),
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Icon(Icons.info, color: Colors.blue,),
                      ],
                    ),
                    Icon(Icons.arrow_left, color: Colors.blue,),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => Scaffold(
                            appBar: AppBar(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'اتحادیه صرافان ولایت هرات',
                                      ))
                                ],
                              ),
                            ),
                            body: About(),
                          )));
                },
              ),
              ListTile(
                dense: true,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  textDirection: TextDirection.rtl,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          'درباره شرکت سازنده',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                              fontSize: 16),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Icon(Icons.info, color: Colors.blue,),
                      ],
                    ),
                    Icon(Icons.arrow_left, color: Colors.blue,),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => Scaffold(
                            appBar: AppBar(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'درباره شرکت سازنده',
                                      ))
                                ],
                              ),
                            ),
                            body: AboutTotia(),
                          )));
                },
              ),
              ListTile(
                dense: true,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  textDirection: TextDirection.rtl,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          'درباره اپلیکشن',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                              fontSize: 16),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Icon(Icons.info, color: Colors.blue,),
                      ],
                    ),
                    Icon(Icons.arrow_left, color: Colors.blue,),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => Scaffold(
                        appBar: AppBar(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'درباره اپلیکشن',
                                  ))
                            ],
                          ),
                        ),
                        body: AboutApp(),
                      )));
                },
              ),
              ListTile(
                dense: true,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  textDirection: TextDirection.rtl,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          'ارسال نظرات و پیشنهادات',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                              fontSize: 16),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Icon(Icons.question_answer, color: Colors.blue,),
                      ],
                    ),
                    Icon(Icons.arrow_left, color: Colors.blue,),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => Scaffold(
                        appBar: AppBar(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'ارسال نظرات و پیشنهادات',
                                  ))
                            ],
                          ),
                        ),
                        body: FeedBack(),
                      )));
                },
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        leading: Container(),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
//            Image.asset(
//              'images/ico.jpg',
//              fit: BoxFit.contain,
//              height: 32,
//            ),
            Container(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'اتحادیه صرافان ولایت هرات',
                ))
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: PageStorage(child: currentScreen, bucket: bucket),
      bottomNavigationBar: bmnav.BottomNav(
        index: currentTab,
        labelStyle: bmnav.LabelStyle(visible: true),
        onTap: (i) {
          setState(() {
            currentTab = i;
            currentScreen = screens[i];
          });
        },
        items: [
          bmnav.BottomNavItem(Icons.hourglass_empty, label: 'نرخ لحظه ای'),
          bmnav.BottomNavItem(Icons.schedule, label: 'نرخ روزانه'),
          bmnav.BottomNavItem(Icons.swap_horiz, label: 'تبدیل اسعار'),
          bmnav.BottomNavItem(Icons.receipt, label: 'اطلاعیه'),
          bmnav.BottomNavItem(Icons.info, label: 'درباره ما'),
        ],
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        Duration(seconds: 2),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => MainWidget())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 50.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'images/ico.jpg',
                          scale: 4.0,
                        ),
                        SizedBox(
                          height: 35.0,
                        ),
                        Text(
                          'Herat Exchange Union',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'اتحادیه صرافان ولایت هرات',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'تنظیمات', icon: Icons.settings),
];
