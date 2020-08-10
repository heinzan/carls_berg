
import 'package:carlsberg/view/event_view.dart';
import 'package:carlsberg/view/redeem_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _StateHomeView();
  }

}

class _StateHomeView extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(

        title: Text('Home' , style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 40 , left: 20 , right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EventView()),
                  );
                },
                  child: Container(
                    height: MediaQuery.of(context).size.height/4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white, boxShadow: <BoxShadow>[
                      BoxShadow(
                          blurRadius: 8,
                          offset: Offset(3, 3),
                          color: Colors.teal.withOpacity(0.1))
                    ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.width * 0.3,
                          width: double.infinity,
                          child: Center(
                            child: Image.asset(
                              "assets/images/event.png",
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            'Event',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal),
                          ),
                        )
                      ],
                    ),
                  )),
            ),
            Padding(padding: EdgeInsets.only(left: 20)),
            Expanded(
              child: InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RedeemView()),
                  );
                },
                  child: Container(
                    height: MediaQuery.of(context).size.height/4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white, boxShadow: <BoxShadow>[
                      BoxShadow(
                          blurRadius: 8,
                          offset: Offset(3, 3),
                          color: Colors.teal.withOpacity(0.1))
                    ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.width * 0.3,
                          width: double.infinity,
                          child: Center(
                            child: Image.asset(
                              "assets/images/redem.jpeg",
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            'Redeem',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal),
                          ),
                        )
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),

    );
  }

}