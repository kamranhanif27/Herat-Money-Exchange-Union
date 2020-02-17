import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedBack extends StatefulWidget {
  @override
  _FeedBackState createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {

  void showInSnackBar(String value) {
    Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text(value, textDirection: TextDirection.rtl,)
    ));
  }

  void sendEmail(name, senderEmail, details) async{
    final Email email = Email(
      body: '$details \n\n\n\n$name',
      subject: '$senderEmail',
      recipients: ['hrexchangeads@gmail.com'],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }

  String email = '';
  String name = '';
  String message = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Row(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: [
//            Container(
//                padding: const EdgeInsets.all(8.0),
//                child: Text(
//                  'ارسال نظرات و پیشنهادات',
//                ))
//          ],
//        ),
//      ),
      body: ListView(
        children: <Widget>[
          Card(
            elevation: 3.0,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              child: Column(
                children: <Widget>[
                  Text(
                    'ما به نظرات وپیشنهادات شما ارج میدهیم؛',
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0
                    ),
                  ),
                  Text(
                    'از این كه با نظرات خود ما را در ارائه خدمات بهتر یاری می فرمایید سپاسگزاریم.',
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            elevation: 3.0,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              child: Column(
                children: <Widget>[
                  new ListTile(
                    trailing: const Icon(Icons.person),
                    title: Directionality(
                      textDirection: TextDirection.rtl,
                      child: new TextField(
                        onChanged: (newValue){
                          setState(() {
                            name = newValue;
                          });
                        },
                        textDirection: TextDirection.rtl,
                        decoration: new InputDecoration(
                          hintText: "نام و نام خانواده گی",
                        ),
                      ),
                    ),
                  ),
                  new ListTile(
                    trailing: const Icon(Icons.subject),
                    title: Directionality(
                      textDirection: TextDirection.rtl,
                      child: new TextField(
                        onChanged: (newValue){
                          setState(() {
                            email = newValue;
                          });
                        },
                        textDirection: TextDirection.rtl,
                        decoration: new InputDecoration(
                          hintText: "عنوان مطلب",
                        ),
                      ),
                    ),
                  ),
                  new ListTile(
                    trailing: const Icon(Icons.message),
                    title: Directionality(
                      textDirection: TextDirection.rtl,
                      child: new TextField(
                        minLines: 4,
                        maxLines: 10,
                        onChanged: (newValue){
                          setState(() {
                            message = newValue;
                          });
                        },
                        textDirection: TextDirection.rtl,
                        decoration: new InputDecoration(

                          hintText: "پیام",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  RaisedButton(
                    onPressed: () async{
                      if(name != '' && email != '' && message != '') {
                        print('sending');
                        sendEmail(name, email, message);
                        print('done');
                      } else {
                        showInSnackBar('لطفا فرم را پر نمایید!');
                      }

                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.4,
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Center(
                          child: Text('ارسال', style: TextStyle(color: Colors.white),)
                      ),
                    ),
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
