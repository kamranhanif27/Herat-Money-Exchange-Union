import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  String abo = "اتحادیه صرافان ولایت هرات به تاریخ ۲۴/۹/۱۳۹۲ مطابق جواز نمبر ۱۲۲۷ که به امضای جلالتماب محترم سید یوسف «حلیم» که در آن زمان بحیث سر پرست وزارت جلیله عدلیه تشریف داشتند ایجاد گردیده و این ازنتیجه زحمات و فعالیت شبانه روزی هیأت رهبری و شخص ریس اتحادیه صرافان محترم ولایت هرات میباشد زیرا در گذشته این یک انجمن بود بعد از بوجود آمدن اتحادیه و انتخاب جناب آقای الحاج بهاء الدین «رحیمی» در دور اول به اکثریت مطلق و در دور دوم به اتفاق صد درصد آرا بحیث رییس اتحادیه انتخاب گردید، تمام امور اتحادیه به شکل درست تحت رهبری هیأت مدیره که تعداد شان به ۴۰ نفر می رسد صورت گرفته و کاملاً به شکل دموکراتیک در جلسات مسایل توسط هیات رهبری داخل آجندا به اتفاق آرا در موارد بسیار اندک به اکثریت آراء فیصله می گردد.";

  String about = '''
    اتحادیه صرافان ولایت هرات که از سال‌های قبل در خدمت هموطنان عزیز قرار دارد قبلا تحت نام صنف صرافان فعالیت داشته است که در سال 1388 اولین جواز انجمن صرافان هرات ثبت وزارت عدلیه دولت اسلامی افغانستان گردیده است . 
در سال 1392 بعد از انتخاب الحاج بهاألدین ( رحیمی ) به حیث رئیس اتحادیه صرافان ولایت هرات به اکثریت آراء با  ایجاد چندین انجمن صرافی در ولسوالی های غوریان ، شندند و کهسان انجمن صرافان هرات به اتحادیه صرافان ولایت هرات ارتفاع یافت و بتاریخ 24/12/1392,  مطابق جواز نمبر 1227 صادره وزارت عدلیه دولت اسلامی افغانستان  اتحادیه صرافان ایجاد گردیده است و این از نتیجه زحمات و فعالیت های شبانه روزی هیأت رهبری و اعضای اتحادیه صرافان در راس شخص رییس اتحادیه صرافان ولایت هرات میباشد. 
در حال حاضر به تعداد 440 نفر صراف که جواز فعالیت صرافی و خدمات پولی را از بانک مرکزی دولت اسلامی افغانستان بدست دارند و تحت رهبری واحد با اتحاد و یکپارچگی در مارکت های اسعاری (خراسان و پاساژ رازی ) فعالیت صرافی و اجرای حواله جات خدمات پولی داشته در خدمت همشهریان عزیز قرار دارند. 
جهت اخذ معلومات بیشتر ما ، میتوانید به ویب سایت (اتحادیه صرافان ولایت هرات ) مراجعه فرمائید.
  ''';
  @override
  Widget build(BuildContext context) {
    abo += "درحال حاضر این اتحادیه اضافه از ۴۰۰ تن صرافان درعضویت خود دارد.";
    abo +=
        "همچنان بخش های مهم این اتحادیه را بخش اداری ، صدوق مالی ، روابط عمومی ( غرض رسیدگی به موقع به درخواست های صرافان ومراجعین) بخش فرهنگی با داشتن یک فصلنامه وزین صفحه فیس بوک تشکیل می دهد.";

    return Container(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(5),
            child: Center(
              child: new Image.asset(
                'images/sarf.jpg',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Align(
                alignment: Alignment.center,
                child: Text(
                  about,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 16.0,),
                  textDirection: TextDirection.rtl,
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
            child: InkWell(
              onTap: ()async{
                await launch('http://heratexchangeunion.com/');
              },
              child: Card(
                color: Colors.grey.shade200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Image.asset( 'images/web.png',),
                    Padding(
                      padding: const EdgeInsets.only(right: 35.0),
                      child: Text(
                        "وب سایت اتحادیه صرافان ولایت هرات",
                        style: TextStyle(fontSize: 14.0,color: Colors.black,fontWeight: FontWeight.w400),

                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
            child: InkWell(
              onTap: ()async{
                await launch('https://www.facebook.com/Herat-Exchange-Union-HEU-716703725102514/');
              },
              child: Card(
                color: Colors.grey.shade200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                   Image.asset( 'images/face.png',),
                   Padding(
                     padding: const EdgeInsets.only(right: 25.0),
                     child: Text(
                        "اتحادیه صرافان ولایت هرات",
                        style: TextStyle(fontSize: 14.0,color: Colors.black,fontWeight: FontWeight.w400),

                      ),
                   )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
            child: InkWell(
              onTap: ()async{
                await launch('https://www.facebook.com/profile.php?id=100007644765429/');
              },
              child: Card(
                color: Colors.grey.shade200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Image.asset( 'images/face.png',),
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Text(
                        "باشگاه ورزشی اتحادیه صرافان ولایت هرات",
                        style: TextStyle(fontSize: 14.0,color: Colors.black,fontWeight: FontWeight.w400),

                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
            child: InkWell(
              onTap: ()async{
                await launch('tel: 0787959799');
              },
              child: Card(
                color: Colors.grey.shade200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Image.asset( 'images/call.png', scale: 1.1,),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Text(
                        "شماره تماس اتحادیه صرافان ولایت هرات",
                        style: TextStyle(fontSize: 14.0,color: Colors.black,fontWeight: FontWeight.w400),

                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
            child: InkWell(
              onTap: ()async{
                await launch('https://t.me/heratexchangeunion');
              },
              child: Card(
                color: Colors.grey.shade200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Image.asset( 'images/tel.png', scale: 1.1,),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Text(
                        "تلگرام اتحادیه صرافان ولایت هرات",
                        style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.w400),

                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
            child: InkWell(
              onTap: ()async{
                await launch('https://t.me/HEXUclubsport');
              },
              child: Card(
                color: Colors.grey.shade200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Image.asset( 'images/tel.png', scale: 1.1,),
                    Padding(
                      padding: const EdgeInsets.only(right: 13.0),
                      child: Text(
                        "باشگاه ورزشی اتحادیه صرافان ولایت هرات",
                        style: TextStyle(fontSize: 14.0,color: Colors.black,fontWeight: FontWeight.w400),

                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
