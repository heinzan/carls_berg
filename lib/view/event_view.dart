import 'package:carlsberg/view/create_event_view.dart';
import 'package:carlsberg/viewmodel/event_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _StateEventView();
  }

}

class _StateEventView extends State<EventView> {
  EventViewModel _eventViewModel = EventViewModel();

  @override
  void initState() {
    // TODO: implement initState
    _eventViewModel.getEventList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ChangeNotifierProvider(
      create: (context) => _eventViewModel,
      child: Consumer<EventViewModel>(
        builder: (context , model , child){
          return Scaffold(
            appBar: AppBar(
              title: Text('Event'),
            ),
            body:  ListView.builder(
                    itemCount: model.eventList.length,
                    itemBuilder: (context , index){
                      return Container(
                        padding: EdgeInsets.all(4),
                        child: Card(
                          elevation: 2,
                          child: Container(
                            height: MediaQuery.of(context).size.height /7,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(4),
                                  height: double.infinity,
                                  width: 100,
                                  child: Image.asset('assets/images/default.png'  , fit: BoxFit.fill, ),
                                ),
                                Padding(padding: EdgeInsets.only(left: 4)),
                                Container(
                                  padding: EdgeInsets.all(4),
                                  child: Text(model.eventList[index].eventName , style: TextStyle(fontSize: 16 , fontWeight: FontWeight.w700),),
                                )
                              ],
                            ),
                          ) ,
                        ),
                      );
                    }),

            floatingActionButton: FloatingActionButton(
                child: Icon(Icons.event , color: Colors.white,),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateEventView())).then((value){
                      model.getEventList();
                  });


                }),
          );
        },
      ),
    );
  }
}