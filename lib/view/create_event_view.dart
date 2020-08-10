import 'package:carlsberg/viewmodel/event_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateEventView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _StateCreateEventView();
  }

}

class _StateCreateEventView extends State<CreateEventView> {
  TextEditingController _eventNameController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _pointController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ChangeNotifierProvider(
      create: (context) => EventViewModel(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          title: Text('Create Event' , style: TextStyle(color: Colors.white),),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.all(12)),
              Container(

                padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
                child: Material(

                  elevation: 5.0,
                  child: TextField(
                    style: TextStyle(height: 1.5),

                    maxLines: null,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            left: 12.0, bottom: 12, top: 6),
                        labelText: 'Event name',
                        fillColor: Colors.green,
                        focusColor: Colors.green,
                        hoverColor: Colors.green,
                        border: InputBorder.none),
                    controller: _eventNameController,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
                child: Material(
                  elevation: 5.0,
                  child: TextField(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 12.0),

                        labelText: 'Event date',
                        fillColor: Colors.green,
                        focusColor: Colors.green,
                        hoverColor: Colors.green,
                        border: InputBorder.none),
                    controller: _dateController,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
                child: Material(
                  elevation: 5.0,
                  child: TextField(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 12.0),

                        labelText: 'Point',
                        fillColor: Colors.green,
                        focusColor: Colors.green,
                        hoverColor: Colors.green,
                        border: InputBorder.none),
                    controller: _pointController,
                  ),
                ),
              ),
              Consumer<EventViewModel>(
                builder: (context, model, child) {
                  return Container(
                    child: RaisedButton(

                        color: Colors.green,
                        child: Text("Create" , style: TextStyle(color: Colors.white),),
                        onPressed: () async {
                          var success = await model.createEvent(
                              _eventNameController.text, _pointController.text,
                              _dateController.text);
                          if (success) {
                            model.getEventList();
                            showSuccessDialog(context);
                          }else{
                            showErrorDialog(context);
                          }
                        }),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showSuccessDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 130,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Column(
                        children: <Widget>[
                          Text("Successfully created an event.", style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.green ,
                              fontSize: 18),),

                        ],
                      ),
                    ),

                    SizedBox(
                      child: RaisedButton(
                        color: Colors.green,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "OK",
                          style: TextStyle(color: Colors.white),
                        ),

                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
    Navigator.pop(context);
  }

  void showErrorDialog(BuildContext context) async{
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 130,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Column(
                        children: <Widget>[
                          Text("Something wrong.Please try again", style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.red ,
                              fontSize: 18),),

                        ],
                      ),
                    ),

                    SizedBox(
                      child: RaisedButton(
                        color: Colors.red,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Try again",
                          style: TextStyle(color: Colors.white),
                        ),

                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}