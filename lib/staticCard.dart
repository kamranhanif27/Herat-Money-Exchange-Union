import 'package:flutter/material.dart';


class StaticCurrencyCard extends StatelessWidget {

  final String curName;
  final String curBuy;
  final String curSell;
  final String image;

  StaticCurrencyCard({this.curName, this.curBuy, this.curSell, this.image});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: SizedBox(
                  width: 10,
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 5.0, bottom: 5.0, left:5.0, right: 5.0),
                  child: Text(curSell),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(curBuy),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 5.0, bottom: 5.0, right: 5),
                  child: Text(curName, textDirection: TextDirection.rtl,),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(top: 5.0, left: 5.0, right: 15.0),
                  child: ClipRRect(
                    borderRadius: new BorderRadius.circular(50.0),

                    child: Image.asset(
                      image,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
//              Expanded(
//                flex: 2,
//                child: Padding(
//                  padding: const EdgeInsets.only(top: 5.0, left: 8.0, right: 10.0),
//                  child:
//                  CircleAvatar(
//                    backgroundColor: Colors.white,
//                    backgroundImage: ExactAssetImage(image),
//                    radius: 20,
//                  ),
//                ),
//              ),
            ],

          ),
        ),
      ),
    );
  }
}
