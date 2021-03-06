import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:moneyexchangeunion/card.dart';

class ListData extends StatefulWidget {
  @override
  _ListDataState createState() => _ListDataState();
}

class _ListDataState extends State<ListData> {
  StreamController _dataController;

  Future<List<dynamic>> _getData({String date}) async {
    if(date == null || date == ''){
      Response response =
      await get('http://heratexchangeunion.com/wp-json/wp/v2/momentexchange');

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data;
      } else {
        print(response.statusCode);
        return null;
      }
    }else {
      String newDate = date.split(' ')[0];
      Response response =
      await get('http://heratexchangeunion.com/wp-json/wp/v2/momentexchange?after=${newDate}T00:00:00&before=${newDate}T23:59:60');

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data;
      } else {
        print(response.statusCode);
        return null;
      }
    }

  }

  loadData({String date}) async {
    _getData(date: date).then((res){
      _dataController.add(res);
    });
  }

  ScrollController controller;
  int listSize = 2;
  bool lastOne = false;
  void _scrollListener() {
    if (controller.position.extentAfter < 1) {
      if(lastOne != true) {
        setState(() {
          listSize +=1;
        });
      }else if (lastOne == true) {
        return null;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _dataController = StreamController();
    loadData();
    controller = new ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Card(
          elevation: 10,
          color: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              //sizebox
              Expanded(
                child: IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.date_range),
                  onPressed: () => {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(2000, 1, 1),
                        maxTime: DateTime(2022, 12, 31),
                        onChanged: (date) {print('change $date');},
                        onConfirm: (date) {print(loadData(date: date.toString()));},
                        currentTime: DateTime.now(), locale: LocaleType.en)
                  },
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    " فروش",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "خرید",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ), ////sizebox
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "ارز",
                    textDirection: TextDirection.rtl,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "کشور",
                    textDirection: TextDirection.rtl,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),//country name
            ],
          ),
        ),
      ),
//      body: _myListView(context),
      body: RefreshIndicator(
        onRefresh: () => loadData(),
        child: StreamBuilder(
          stream: _dataController.stream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List<dynamic> data = snapshot.data;
              if(data.length > 0 ) {
                return ListView.builder(
                  controller: controller,
                  itemCount: listSize,
                  itemBuilder: (context, i) {
                    if ((data.length - 1) == i) {

                      lastOne = true;

                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0, bottom: 5.0),
                          child: Center(child: Text(snapshot.data[i]['title']['rendered'], textAlign: TextAlign.center)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 5.0),
                          child: Center(child: Text(snapshot.data[i]['date'] + ' تغییر نرخ به زمان')),
                        ),
                        CurrencyCard(
                          curName: snapshot.data[i]['metadata']['Dollar'][0],
                          image: 'images/usa.png',
                          curBuy: snapshot.data[i]['metadata']['BuyDollar'][0],
                          curSell: snapshot.data[i]['metadata']['SellDollar'][0],
                        ),
                        CurrencyCard(
                          curName: snapshot.data[i]['metadata']['Yuro'][0],
                          image: 'images/euro.png',
                          curBuy: snapshot.data[i]['metadata']['BuyYuro'][0],
                          curSell: snapshot.data[i]['metadata']['SellYuro'][0],
                        ),
                        CurrencyCard(
                          curName: snapshot.data[i]['metadata']['pond'][0],
                          image: 'images/pound.png',
                          curBuy: snapshot.data[i]['metadata']['Buypuond'][0],
                          curSell: snapshot.data[i]['metadata']['Sellpuond'][0],
                        ),
                        CurrencyCard(
                          curName: snapshot.data[i]['metadata']['toman'][0],
                          image: 'images/toman.png',
                          curBuy: snapshot.data[i]['metadata']['BuyToman'][0],
                          curSell: snapshot.data[i]['metadata']['sellToman'][0],
                        ),
                        CurrencyCard(
                          curName: snapshot.data[i]['metadata']['caldar'][0],
                          image: 'images/caldar.png',
                          curBuy: snapshot.data[i]['metadata']['Buycaldar'][0],
                          curSell: snapshot.data[i]['metadata']['Sellcaldar'][0],
                        ),
                        CurrencyCard(
                          curName: snapshot.data[i]['metadata']['ropya'][0],
                          image: 'images/rupees.png',
                          curBuy: snapshot.data[i]['metadata']['BuyRopya'][0],
                          curSell: snapshot.data[i]['metadata']['SellRopya'][0],
                        ),
                        CurrencyCard(
                          curName: snapshot.data[i]['metadata']['Deham'][0],
                          image: 'images/darham.png',
                          curBuy: snapshot.data[i]['metadata']['BuyDeham'][0],
                          curSell: snapshot.data[i]['metadata']['SellDeham'][0],
                        ),
                        CurrencyCard(
                          curName: snapshot.data[i]['metadata']['Real'][0],
                          image: 'images/riyal.png',
                          curBuy: snapshot.data[i]['metadata']['BuyReal'][0],
                          curSell: snapshot.data[i]['metadata']['SellReal'][0],
                        ),
                        CurrencyCard(
                          curName: snapshot.data[i]['metadata']['Frank'][0],
                          image: 'images/frank.png',
                          curBuy: snapshot.data[i]['metadata']['BuyFrank'][0],
                          curSell: snapshot.data[i]['metadata']['SellFrank'][0],
                        ),
                        CurrencyCard(
                          curName: snapshot.data[i]['metadata']['dollarcanada'][0],
                          image: 'images/canada.png',
                          curBuy: snapshot.data[i]['metadata']['Buydollarcanada'][0],
                          curSell: snapshot.data[i]['metadata']['Selldollarcanada'][0],
                        ),
                        CurrencyCard(
                          curName: snapshot.data[i]['metadata']['astrDollar'][0],
                          image: 'images/australia.png',
                          curBuy: snapshot.data[i]['metadata']['BuyastrDollar'][0],
                          curSell: snapshot.data[i]['metadata']['SellastrDollar'][0],
                        ),
                        CurrencyCard(
                          curName: snapshot.data[i]['metadata']['crone'][0],
                          image: 'images/crone.png',
                          curBuy: snapshot.data[i]['metadata']['Buycrone'][0],
                          curSell: snapshot.data[i]['metadata']['Sellcrone'][0],
                        ),
                        CurrencyCard(
                          curName: snapshot.data[i]['metadata']['DatoTo'][0],
                          image: 'images/usa.png',
                          curBuy: snapshot.data[i]['metadata']['BuyDatoTo'][0],
                          curSell: snapshot.data[i]['metadata']['SellDatoTo'][0],
                        ),
                        CurrencyCard(
                          curName: snapshot.data[i]['metadata']['CaToDo'][0],
                          image: 'images/usa.png',
                          curBuy: snapshot.data[i]['metadata']['BuyCaToDo'][0],
                          curSell: snapshot.data[i]['metadata']['SellCaToDo'][0],
                        ),
                        CurrencyCard(
                          curName: snapshot.data[i]['metadata']['DoToDar'][0],
                          image: 'images/usa.png',
                          curBuy: snapshot.data[i]['metadata']['BuyDoToDar'][0],
                          curSell: snapshot.data[i]['metadata']['SellDoToDar'][0],
                        ),
                        CurrencyCard(
                          curName: snapshot.data[i]['metadata']['dorToYu'][0],
                          image: 'images/usa.png',
                          curBuy: snapshot.data[i]['metadata']['BuydorToYu'][0],
                          curSell: snapshot.data[i]['metadata']['SelldorToYu'][0],
                        ),
                      ],
                    );
                  },
                );
              } else {
                return Center(
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      Center(
                        child: Container(
                          child: Center(child: Text('هیچ اطلاعاتی موجود نمیباشد!')),
                          height: MediaQuery.of(context).size.height / 1.4,
                      ),
                      ),
                    ],
                  ),
                );
              }
            }
            else if (snapshot.connectionState != ConnectionState.done) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (!snapshot.hasData) {
              return Center(
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    Center(
                      child: Container(
                        child: Center(child: Text('هیچ اطلاعاتی موجود نمیباشد!')),
                        height: MediaQuery.of(context).size.height / 1.4,
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}




