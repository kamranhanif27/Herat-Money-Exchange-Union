import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart';
import 'package:moneyexchangeunion/Scren/newDetail.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {



  Future<List<dynamic>> _getData() async {

    Response response =
    await get('http://heratexchangeunion.com/wp-json/wp/v2/posts?categories=27');

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data;
    } else {
      print(response.statusCode);
      return null;
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => _getData(),
        child: StreamBuilder(
          stream: _getData().asStream(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List<dynamic> data = snapshot.data;
              if(data.length > 0 ) {
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, i) {
                    return Container(
                      height: 250.0,
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                            builder: (BuildContext context) => NewsDetail(index: i,)
                          ));
                        },
                        child: Card(
                          elevation: 2.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              FadeInImage.assetNetwork(
                                fit: BoxFit.fill,
                                height: 200.0,
                                placeholder: 'images/image-placeholder.jpg',
                                image: snapshot.data[i]['better_featured_image']['media_details']['sizes']['medium']['source_url'],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  snapshot.data[i]['title']['rendered'],
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
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
            }else {
              return null;
            }
          },
        ),
      ),
    );
  }
}
