import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class CalCulate extends StatefulWidget {
  CalCulate();

  @override
  CalCulateState createState() => CalCulateState();
}

class CalCulateState extends State<CalCulate> {



  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(width: 2),
    );
  }

  Future<List<dynamic>> _getData() async {
      Response response =
      await get('http://heratexchangeunion.com/wp-json/wp/v2/momentexchange');

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data;
      } else {
        print(response.statusCode);
        return null;
      }
  }

  bool calculating = false;
  String output = '';
  String buyOutput = '';


  void _calculate() async {
    var data = await _getData().whenComplete((){
      setState(() {
        calculating = false;
      });
    });


    if(input != 0 && input != null) {
      if (value == 1) {
        setState(() {
          total = input * double.parse(data[0]['metadata']['SellDollar'][0]);
          output = ' فروش: $input دالر = ${total.toStringAsFixed(3)} افغانی';
          buyTotal = input * double.parse(data[0]['metadata']['BuyDollar'][0]);
          buyOutput = ' خرید: $input دالر = ${buyTotal.toStringAsFixed(3)} افغانی';
        });
      }
      if (value == 2) {
        setState(() {
          total = input / double.parse(data[0]['metadata']['SellDollar'][0]);
          output = ' فروش: $input افغانی = ${total.toStringAsFixed(3)} دالر';
          buyTotal = input / double.parse(data[0]['metadata']['BuyDollar'][0]);
          buyOutput = ' خرید: $input افغانی = ${buyTotal.toStringAsFixed(3)} دالر';
        });
      }
      if (value == 3) {
        setState(() {
          total = input * double.parse(data[0]['metadata']['SellYuro'][0]);
          output = ' فروش: $input یورو = ${total.toStringAsFixed(3)} افغانی';
          buyTotal = input * double.parse(data[0]['metadata']['BuyYuro'][0]);
          buyOutput = ' خرید: $input یورو = ${buyTotal.toStringAsFixed(3)} افغانی';
        });
      }
      if (value == 4) {
        setState(() {
          total = input / double.parse(data[0]['metadata']['SellYuro'][0]);
          output = ' فروش: $input افغانی = ${total.toStringAsFixed(3)} یورو';
          buyTotal = input / double.parse(data[0]['metadata']['BuyYuro'][0]);
          buyOutput = ' خرید: $input افغانی = ${buyTotal.toStringAsFixed(3)} یورو';
        });
      }
      if (value == 5) {
        setState(() {
          total = input * double.parse(data[0]['metadata']['Sellpuond'][0]);
          output = ' فروش: $input پوند = ${total.toStringAsFixed(3)} افغانی';
          buyTotal = input * double.parse(data[0]['metadata']['Buypuond'][0]);
          buyOutput = ' خرید: $input پوند = ${buyTotal.toStringAsFixed(3)} افغانی';
        });
      }
      if (value == 6) {
        setState(() {
          total = input / double.parse(data[0]['metadata']['Sellpuond'][0]);
          output = ' فروش: $input افغانی = ${total.toStringAsFixed(3)} پوند';
          buyTotal = input / double.parse(data[0]['metadata']['Buypuond'][0]);
          buyOutput = ' خرید: $input افغانی = ${buyTotal.toStringAsFixed(3)} پوند';
        });
      }
      if (value == 7) {
        setState(() {
          total = input * double.parse(data[0]['metadata']['sellToman'][0]) / 1000;
          output = ' فروش: $input تومان = ${total.toStringAsFixed(3)} افغانی';
          buyTotal = input * double.parse(data[0]['metadata']['BuyToman'][0]) / 1000;
          buyOutput = ' خرید: $input تومان = ${buyTotal.toStringAsFixed(3)} افغانی';
        });
      }
      if (value == 8) {
        setState(() {
          total = input * 1000 / double.parse(data[0]['metadata']['sellToman'][0]);
          output = ' فروش: $input افغانی = ${total.toStringAsFixed(3)} تومان';
          buyTotal = input * 1000 / double.parse(data[0]['metadata']['BuyToman'][0]);
          buyOutput = ' خرید: $input افغانی = ${buyTotal.toStringAsFixed(3)} تومان';
        });
      }
      if (value == 9) {
        setState(() {
          total = input * double.parse(data[0]['metadata']['Sellcaldar'][0]) / 1000;
          output = ' فروش: $input کالدار = ${total.toStringAsFixed(3)} افغانی';
          buyTotal = input * double.parse(data[0]['metadata']['Buycaldar'][0]) / 1000;
          buyOutput = ' خرید: $input کالدار = ${buyTotal.toStringAsFixed(3)} افغانی';
        });
      }
      if (value == 10) {
        setState(() {
          total = input * 1000 / double.parse(data[0]['metadata']['Sellcaldar'][0]);
          output = ' فروش: $input افغانی = ${total.toStringAsFixed(3)} کالدار';
          buyTotal = input * 1000 / double.parse(data[0]['metadata']['Buycaldar'][0]);
          buyOutput = ' خرید: $input افغانی = ${buyTotal.toStringAsFixed(3)} کالدار';
        });
      }
      if (value == 11) {
        setState(() {
          total = input * double.parse(data[0]['metadata']['SellRopya'][0]) / 1000;
          output = ' فروش: $input روپیه = ${total.toStringAsFixed(3)} افغانی';
          buyTotal = input * double.parse(data[0]['metadata']['BuyRopya'][0]) / 1000;
          buyOutput = ' خرید: $input روپیه = ${buyTotal.toStringAsFixed(3)} افغانی';
        });
      }
      if (value == 12) {
        setState(() {
          total = input * 1000 / double.parse(data[0]['metadata']['SellRopya'][0]);
          output = ' فروش: $input افغانی = ${total.toStringAsFixed(3)} روپیه';
          buyTotal = input * 1000 / double.parse(data[0]['metadata']['BuyRopya'][0]);
          buyOutput = ' خرید: $input افغانی = ${buyTotal.toStringAsFixed(3)} روپیه';
        });
      }
      if (value == 13) {
        setState(() {
          total = input * double.parse(data[0]['metadata']['SellDeham'][0]);
          output = ' فروش: $input درهم = ${total.toStringAsFixed(3)} افغانی';
          buyTotal = input * double.parse(data[0]['metadata']['BuyDeham'][0]);
          buyOutput = ' خرید: $input درهم = ${buyTotal.toStringAsFixed(3)} افغانی';
        });
      }
      if (value == 14) {
        setState(() {
          total = input / double.parse(data[0]['metadata']['SellDeham'][0]);
          output = ' فروش: $input افغانی = ${total.toStringAsFixed(3)} درهم';
          buyTotal = input / double.parse(data[0]['metadata']['BuyDeham'][0]);
          buyOutput = ' خرید: $input افغانی = ${buyTotal.toStringAsFixed(3)} درهم';
        });
      }
      if (value == 15) {
        setState(() {
          total = input * double.parse(data[0]['metadata']['SellReal'][0]);
          output = ' فروش: $input ریال سعودی = ${total.toStringAsFixed(3)} افغانی';
          buyTotal = input * double.parse(data[0]['metadata']['BuyReal'][0]);
          buyOutput = ' خرید: $input ریال سعودی = ${buyTotal.toStringAsFixed(3)} افغانی';
        });
      }
      if (value == 16) {
        setState(() {
          total = input / double.parse(data[0]['metadata']['SellReal'][0]);
          output = ' فروش: $input افغانی = ${total.toStringAsFixed(3)} ریال سعودی';
          buyTotal = input / double.parse(data[0]['metadata']['BuyReal'][0]);
          buyOutput = ' خرید: $input افغانی = ${buyTotal.toStringAsFixed(3)} ریال سعودی';
        });
      }
      if (value == 17) {
        setState(() {
          total = input * double.parse(data[0]['metadata']['SellFrank'][0]);
          output = ' فروش: $input فرانک = ${total.toStringAsFixed(3)} افغانی';
          buyTotal = input * double.parse(data[0]['metadata']['BuyFrank'][0]);
          buyOutput = ' خرید: $input فرانک = ${buyTotal.toStringAsFixed(3)} افغانی';
        });
      }
      if (value == 18) {
        setState(() {
          total = input / double.parse(data[0]['metadata']['SellFrank'][0]);
          output = ' فروش: $input افغانی = ${total.toStringAsFixed(3)} فرانک';
          buyTotal = input / double.parse(data[0]['metadata']['BuyFrank'][0]);
          buyOutput = ' خرید: $input افغانی = ${buyTotal.toStringAsFixed(3)} فرانک';
        });
      }
      if (value == 19) {
        setState(() {
          total = input * double.parse(data[0]['metadata']['Selldollarcanada'][0]);
          output = ' فروش: $input دالر کانادا = ${total.toStringAsFixed(3)} افغانی';
          buyTotal = input * double.parse(data[0]['metadata']['Buydollarcanada'][0]);
          buyOutput = ' خرید: $input دالر کانادا = ${buyTotal.toStringAsFixed(3)} افغانی';
        });
      }
      if (value == 20) {
        setState(() {
          total = input / double.parse(data[0]['metadata']['Selldollarcanada'][0]);
          output = ' فروش: $input افغانی = ${total.toStringAsFixed(3)} دالر کانادا';
          buyTotal = input / double.parse(data[0]['metadata']['Buydollarcanada'][0]);
          buyOutput = ' خرید: $input افغانی = ${buyTotal.toStringAsFixed(3)} دالر کانادا';
        });
      }
      if (value == 21) {
        setState(() {
          total = input * double.parse(data[0]['metadata']['SellastrDollar'][0]);
          output = ' فروش: $input دالر آسترالیا = ${total.toStringAsFixed(3)} افغانی';
          buyTotal = input * double.parse(data[0]['metadata']['BuyastrDollar'][0]);
          buyOutput = ' خرید: $input دالر آسترالیا = ${buyTotal.toStringAsFixed(3)} افغانی';
        });
      }
      if (value == 22) {
        setState(() {
          total = input / double.parse(data[0]['metadata']['SellastrDollar'][0]);
          output = ' فروش: $input افغانی = ${total.toStringAsFixed(3)} دالر آسترالیا';
          buyTotal = input / double.parse(data[0]['metadata']['BuyastrDollar'][0]);
          buyOutput = ' خرید: $input افغانی = ${buyTotal.toStringAsFixed(3)} دالر آسترالیا';
        });
      }
      if (value == 23) {
        setState(() {
          total = input * double.parse(data[0]['metadata']['Sellcrone'][0]);
          output = ' فروش: $input کرون = ${total.toStringAsFixed(3)} افغانی';
          buyTotal = input * double.parse(data[0]['metadata']['Buycrone'][0]);
          buyOutput = ' خرید: $input کرون = ${buyTotal.toStringAsFixed(3)} افغانی';
        });
      }
      if (value == 24) {
        setState(() {
          total = input / double.parse(data[0]['metadata']['Sellcrone'][0]);
          output = ' فروش: $input افغانی = ${total.toStringAsFixed(3)} کرون';
          buyTotal = input / double.parse(data[0]['metadata']['Buycrone'][0]);
          buyOutput = ' خرید: $input افغانی = ${buyTotal.toStringAsFixed(3)} کرون';
        });
      }
      if (value == 25) {
        setState(() {
          total = input * double.parse(data[0]['metadata']['SellDatoTo'][0]);
          output = ' فروش: $input دالر = ${total.toStringAsFixed(3)} تومن';
          buyTotal = input * double.parse(data[0]['metadata']['BuyDatoTo'][0]);
          buyOutput = ' خرید: $input دالر = ${buyTotal.toStringAsFixed(3)} تومن';
        });
      }
      if (value == 26) {
        setState(() {
          total = input * double.parse(data[0]['metadata']['SellCaToDo'][0]);
          output = ' فروش: $input دالر = ${total.toStringAsFixed(3)} کالدار';
          buyTotal = input * double.parse(data[0]['metadata']['BuyCaToDo'][0]);
          buyOutput = ' خرید: $input دالر = ${buyTotal.toStringAsFixed(3)} کالدار';
        });
      }
      if (value == 27) {
        setState(() {
          total = input * double.parse(data[0]['metadata']['SellDoToDar'][0]);
          output = ' فروش: $input دالر = ${total.toStringAsFixed(3)} درهم';
          buyTotal = input * double.parse(data[0]['metadata']['BuyDoToDar'][0]);
          buyOutput = ' خرید: $input دالر = ${buyTotal.toStringAsFixed(3)} درهم';
        });
      }
      if (value == 28) {
        setState(() {
          total = input * double.parse(data[0]['metadata']['SelldorToYu'][0]);
          output = ' فروش: $input دالر = ${total.toStringAsFixed(3)} یورو';
          buyTotal = input * double.parse(data[0]['metadata']['BuydorToYu'][0]);
          buyOutput = ' خرید: $input دالر = ${buyTotal.toStringAsFixed(3)} یورو';
        });
      }
    }
  }

  int value = 1;
  double total = 0;
  double buyTotal = 0;
  double input = 0;

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext ctx) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Column(
          textDirection: TextDirection.rtl,
          // align the text to the left instead of centered
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              child: Container(
                margin: EdgeInsets.all(10),
                width: double.infinity,
                child: DropdownButton(
                  isExpanded: true,
                  underline: Container(),
                  items: [
                      DropdownMenuItem(
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Row(
                            children: <Widget>[
                              Image.asset('images/usa.png', width: 35, height: 35,),
                              Text('دالر به افغانی'),
                              Image.asset('images/afg.png', width: 35, height: 35,)
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                        ),
                        value: 1,
                      ),
                      DropdownMenuItem(
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Row(
                            children: <Widget>[
                              Image.asset('images/afg.png', width: 35, height: 35,),
                              Text('افغانی به دالر'),
                              Image.asset('images/usa.png', width: 35, height: 35,)
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                        ),
                        value: 2,
                      ),
                      DropdownMenuItem(
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Row(
                            children: <Widget>[
                              Image.asset('images/euro.png', width: 35, height: 35,),
                              Text('یورو به افغانی'),
                              Image.asset('images/afg.png', width: 35, height: 35,)
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                        ),
                        value: 3,
                      ),
                      DropdownMenuItem(
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Row(
                            children: <Widget>[
                              Image.asset('images/afg.png', width: 35, height: 35,),
                              Text('افغانی به یورو'),
                              Image.asset('images/euro.png', width: 35, height: 35,)
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                        ),
                        value: 4,
                      ),
                      DropdownMenuItem(
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Row(
                            children: <Widget>[
                              Image.asset('images/pound.png', width: 35, height: 35,),
                              Text('پوند به افغانی'),
                              Image.asset('images/afg.png', width: 35, height: 35,)
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                        ),
                        value: 5,
                      ),
                      DropdownMenuItem(
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Row(
                            children: <Widget>[
                              Image.asset('images/afg.png', width: 35, height: 35,),
                              Text('افغانی به پوند'),
                              Image.asset('images/pound.png', width: 35, height: 35,)
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                        ),
                        value: 6,
                      ),
                      DropdownMenuItem(
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Row(
                            children: <Widget>[
                              Image.asset('images/toman.png', width: 35, height: 35,),
                              Text('تومان به افغانی'),
                              Image.asset('images/afg.png', width: 35, height: 35,)
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                        ),
                        value: 7,
                      ),
                      DropdownMenuItem(
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Row(
                            children: <Widget>[
                              Image.asset('images/afg.png', width: 35, height: 35,),
                              Text('افغانی به تومان'),
                              Image.asset('images/toman.png', width: 35, height: 35,)
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                        ),
                        value: 8,
                      ),
                      DropdownMenuItem(
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Row(
                            children: <Widget>[
                              Image.asset('images/caldar.png', width: 35, height: 35,),
                              Text('کالدار به افغانی'),
                              Image.asset('images/afg.png', width: 35, height: 35,)
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                        ),
                        value: 9,
                      ),
                      DropdownMenuItem(
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Row(
                            children: <Widget>[
                              Image.asset('images/afg.png', width: 35, height: 35,),
                              Text('افغانی به کالدار'),
                              Image.asset('images/caldar.png', width: 35, height: 35,)
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                        ),
                        value: 10,
                      ),
                      DropdownMenuItem(
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Row(
                            children: <Widget>[
                              Image.asset('images/rupees.png', width: 35, height: 35,),
                              Text('روپیه هندی به افغانی'),
                              Image.asset('images/afg.png', width: 35, height: 35,)
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                        ),
                        value: 11,
                      ),
                      DropdownMenuItem(
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Row(
                            children: <Widget>[
                              Image.asset('images/afg.png', width: 35, height: 35,),
                              Text('افغانی به روپیه هندی'),
                              Image.asset('images/rupees.png', width: 35, height: 35,)
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                        ),
                        value: 12,
                      ),
                      DropdownMenuItem(
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Row(
                            children: <Widget>[
                              Image.asset('images/darham.png', width: 35, height: 35,),
                              Text('درهم به افغانی'),
                              Image.asset('images/afg.png', width: 35, height: 35,)
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                        ),
                        value: 13,
                      ),
                      DropdownMenuItem(
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Row(
                            children: <Widget>[
                              Image.asset('images/afg.png', width: 35, height: 35,),
                              Text('افغانی به درهم'),
                              Image.asset('images/darham.png', width: 35, height: 35,)
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                        ),
                        value: 14,
                      ),
                      DropdownMenuItem(
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Row(
                            children: <Widget>[
                              Image.asset('images/riyal.png', width: 35, height: 35,),
                              Text('ریال سعودی به افغانی'),
                              Image.asset('images/afg.png', width: 35, height: 35,)
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                        ),
                        value: 15,
                      ),
                      DropdownMenuItem(
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Row(
                            children: <Widget>[
                              Image.asset('images/afg.png', width: 35, height: 35,),
                              Text('افغانی به ریال سعودی'),
                              Image.asset('images/riyal.png', width: 35, height: 35,)
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                        ),
                        value: 16,
                      ),
                      DropdownMenuItem(
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Row(
                            children: <Widget>[
                              Image.asset('images/frank.png', width: 35, height: 35,),
                              Text('فرانک سویس به افغانی'),
                              Image.asset('images/afg.png', width: 35, height: 35,)
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                        ),
                        value: 17,
                      ),
                      DropdownMenuItem(
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Row(
                            children: <Widget>[
                              Image.asset('images/afg.png', width: 35, height: 35,),
                              Text('افغانی به فرانک سویس'),
                              Image.asset('images/frank.png', width: 35, height: 35,)
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                        ),
                        value: 18,
                      ),
                      DropdownMenuItem(
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Row(
                            children: <Widget>[
                              Image.asset('images/canada.png', width: 35, height: 35,),
                              Text('دالر کانادا به افغانی'),
                              Image.asset('images/afg.png', width: 35, height: 35,)
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                        ),
                        value: 19,
                      ),
                      DropdownMenuItem(
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Row(
                            children: <Widget>[
                              Image.asset('images/afg.png', width: 35, height: 35,),
                              Text('افغانی به دالر کانادا'),
                              Image.asset('images/canada.png', width: 35, height: 35,)
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                        ),
                        value: 20,
                      ),
                      DropdownMenuItem(
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Row(
                            children: <Widget>[
                              Image.asset('images/australia.png', width: 35, height: 35,),
                              Text('دالر آسترالیا به افغانی'),
                              Image.asset('images/afg.png', width: 35, height: 35,)
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                        ),
                        value: 21,
                      ),
                      DropdownMenuItem(
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Row(
                            children: <Widget>[
                              Image.asset('images/afg.png', width: 35, height: 35,),
                              Text('افغانی به دالر آسترالیا'),
                              Image.asset('images/australia.png', width: 35, height: 35,)
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                        ),
                        value: 22,
                      ),
                      DropdownMenuItem(
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Row(
                            children: <Widget>[
                              Image.asset('images/crone.png', width: 35, height: 35,),
                              Text('کرون ناروی به افغانی'),
                              Image.asset('images/afg.png', width: 35, height: 35,)
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                        ),
                        value: 23,
                      ),
                      DropdownMenuItem(
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Row(
                            children: <Widget>[
                              Image.asset('images/afg.png', width: 35, height: 35,),
                              Text('افغانی به کرون ناروی'),
                              Image.asset('images/crone.png', width: 35, height: 35,)
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                        ),
                        value: 24,
                      ),
                      DropdownMenuItem(
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Row(
                            children: <Widget>[
                              Image.asset('images/usa.png', width: 35, height: 35,),
                              Text('دالر به تومان'),
                              Image.asset('images/toman.png', width: 35, height: 35,)
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                        ),
                        value: 25,
                      ),
                      DropdownMenuItem(
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Row(
                            children: <Widget>[
                              Image.asset('images/usa.png', width: 35, height: 35,),
                              Text('دالر به کالدار'),
                              Image.asset('images/caldar.png', width: 35, height: 35,)
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                        ),
                        value: 26,
                      ),
                      DropdownMenuItem(
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Row(
                            children: <Widget>[
                              Image.asset('images/usa.png', width: 35, height: 35,),
                              Text('دالر به درهم'),
                              Image.asset('images/darham.png', width: 35, height: 35,)
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                        ),
                        value: 27,
                      ),
                      DropdownMenuItem(
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Row(
                            children: <Widget>[
                              Image.asset('images/usa.png', width: 35, height: 35,),
                              Text('دالر به یورو'),
                              Image.asset('images/euro.png', width: 35, height: 35,)
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                        ),
                        value: 28,
                      ),
                  ],
                  onChanged: (newValue){
                    setState(() {
                      value = newValue;
                      output = '';
                      buyOutput = '';
                    });
                  },
                  value: value,
                ),
              ),
            ),
            Card(
              elevation: 10,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: TextField(
                            decoration: const InputDecoration(
                                helperText: "!مقدار ارز را وارد کنید"),
                            style: Theme.of(context).textTheme.body1,
                            keyboardType: TextInputType.number,
                            controller: controller,
                            onChanged: (value) {
                              input = double.parse(value);
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 30),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: RaisedButton(
                          shape: StadiumBorder(),
                            color: Colors.blueAccent,
                            onPressed: () {
                              setState(() {
                                calculating = true;
                              });
                              _calculate();
                            },
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(0.0),
                            elevation: 3.5,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                              child: Text('محاسبه کردن',
                                  style: TextStyle(fontSize: 15)),
                            )),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Center(
                      child: calculating == true ? CircularProgressIndicator() : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(output, style: TextStyle(fontSize: 16),),
                          Text(buyOutput, style: TextStyle(fontSize: 16),),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
