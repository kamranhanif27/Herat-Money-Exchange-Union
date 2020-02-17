import 'package:flutter/material.dart';

class AboutApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        width: double.infinity,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Text(
              ' Herat Exchange Union \n نرخ ارز در بازار صرافان ولایت هرات',
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0),
            ),
            SizedBox(height: 10.0,),
            Text(
              'این اپلیکشن موبایل به منظور ارائه دقیق و بموقع نرخ اسعار در بازار صرافی های ولایت هرات طراحی و راه اندازی گردیده است که نرخ انواع اسعار خارجی را مطابق به تحولات بازار هم ثابت و هم لحظه ای در خدمت هموطنان عزیز که موبایل های هوشمند (Android & iOS) دارند قرار دهد.',
              textAlign: TextAlign.justify,
              textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: 14.0),
            ),
            SizedBox(height: 10.0,),
            Text(
              'بخش های این اپلیکشن موبایل:',
              textAlign: TextAlign.justify,
              textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0,),
            Text(
              '۱- نرخ روزانه ثابت',
              textAlign: TextAlign.justify,
              textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              '   که روز یکبار تغییر میکند و مورد استفاده ادارات دولتی، محاکمات عدلی و قضائی و رسانه های خبری قرار می گیرد.',
              textAlign: TextAlign.justify,
              textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: 14.0),
            ),
            Text(
              '۲- نرخ اسعار لحظه ای',
              textAlign: TextAlign.justify,
              textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              '   در این بخش شرکت های محترم تجارتی، معامله داران و بازاریان می توانند لحظه به لحظه از نرخ اسعار خارجی اطلاع حاصل نمایند.',
              textAlign: TextAlign.justify,
              textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: 14.0),
            ),
            Text(
              '۳- تبادله اسعار',
              textAlign: TextAlign.justify,
              textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              '   در این بخش مراجعین می توانند بطور خود کار طبق نرخ لحظه ای، اسعار مورد نظر خودش را تبادله نمایند.',
              textAlign: TextAlign.justify,
              textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: 14.0),
            ),
            Text(
              '۴- اطلاعیه ها',
              textAlign: TextAlign.justify,
              textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              '   در این بخش اطلاعیه های مهم و ضروری از طرف ریاست اتحادیه صرافان منتشر میگردد.',
              textAlign: TextAlign.justify,
              textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: 14.0),
            ),
            Text(
              '۵- درباره اتحادیه صرافان ولایت هرات',
              textAlign: TextAlign.justify,
              textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              '   این بخش انعکاس  دهنده، تشکیلات، فعالیت ها، دستاورد ها، کمک های خیریه، بخش فرهنگی، ورزشی، گالری ... در سایت های معتبر ( وب سایت، فیسبوک، کانال های تلگرام، واتساپ و ...) درباره اتحادیه صرافان ولایت هرات میباشد.',
              textAlign: TextAlign.justify,
              textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: 14.0),
            ),
            SizedBox(height: 35.0,),
            Center(
              child: Text(
                'version: 1.0.0',
                textAlign: TextAlign.justify,
                textDirection: TextDirection.rtl,
                style: TextStyle(fontSize: 14.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



