import 'dart:io';

import 'package:barcode_scan/gen/protos/protos.pbenum.dart';
import 'package:barcode_scan/model/android_options.dart';
import 'package:barcode_scan/model/scan_options.dart';
import 'package:barcode_scan/model/scan_result.dart';
import 'package:barcode_scan/platform_wrapper.dart';
import 'package:carlsberg/viewmodel/event_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class RedeemView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _StateRedeemView();
  }

}

class _StateRedeemView extends State<RedeemView>{
  ScanResult scanResult;

  final _flashOnController = TextEditingController(text: "Flash on");
  final _flashOffController = TextEditingController(text: "Flash off");
  final _cancelController = TextEditingController(text: "Cancel");

  TextEditingController _pointController = TextEditingController();

  var _aspectTolerance = 0.00;
  var _numberOfCameras = 0;
  var _selectedCamera = -1;
  var _useAutoFocus = true;
  var _autoEnableFlash = false;

  static final _possibleFormats = BarcodeFormat.values.toList()
    ..removeWhere((e) => e == BarcodeFormat.unknown);

  List<BarcodeFormat> selectedFormats = [..._possibleFormats];

  @override
  // ignore: type_annotate_public_apis
  initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      _numberOfCameras = await BarcodeScanner.numberOfCameras;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EventViewModel(),
      child: Consumer<EventViewModel>(
        builder: (context , model , child){
          return Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.white, //change your color here
              ),
              title: Text('Redeem' , style: TextStyle(color: Colors.white),),
              centerTitle: true,
            ),
            body: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 12 , right: 12 , top: 6),
                  child: Card(
                    margin: EdgeInsets.all(8),
                    child: Column(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(top: 16)),
                        Row(
                          children: <Widget>[
                            Padding(padding: EdgeInsets.only(left: 60)),
                            Expanded(
                              flex: 1,
                              child: Text('Employee ID' , style: TextStyle(fontWeight: FontWeight.w700 , fontSize: 18),),
                            ),
                            Expanded(
                                flex: 1,
                                child: Text(scanResult != null
                                    ? scanResult.rawContent
                                    : "00000" , style: TextStyle(fontWeight: FontWeight.w400 , fontSize: 18)))
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(top: 12)),
                        Row(
                          children: <Widget>[
                            Padding(padding: EdgeInsets.only(left: 60)),
                            Expanded(
                              flex: 1,
                              child: Text('Point' ,style: TextStyle(fontWeight: FontWeight.w700 , fontSize: 18)),
                            ),
                            Expanded(
                                flex: 1,
                                child: TextField(
                                  decoration: new InputDecoration(border: InputBorder.none,
                                    hintText: 'Enter point',),

                                    keyboardType: TextInputType.number,
                                  controller: _pointController,
                                )

                            )
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 12)),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: FlatButton(
                      textColor: Colors.white,
                      color: Colors.green,
                      onPressed: () async{
                        var success =await model.redeemPoint(scanResult.rawContent, _pointController.text);
                          if(success){
                            showSuccessDialog(context);
                          }

                      },
                      child: Text('REDEEM')),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
                child: Icon(FontAwesomeIcons.qrcode),
                onPressed: () {
                  scan();
                }),
          );
        },
      ),
    );
  }

  Future scan() async {
    try {
      var options = ScanOptions(
        strings: {
          "cancel": _cancelController.text,
          "flash_on": _flashOnController.text,
          "flash_off": _flashOffController.text,
        },
        restrictFormat: selectedFormats,
        useCamera: _selectedCamera,
        autoEnableFlash: _autoEnableFlash,
        android: AndroidOptions(
          aspectTolerance: _aspectTolerance,
          useAutoFocus: _useAutoFocus,
        ),
      );

      var result = await BarcodeScanner.scan(options: options);

      setState(() => scanResult = result);
    } on PlatformException catch (e) {
      var result = ScanResult(
        type: ResultType.Error,
        format: BarcodeFormat.unknown,
      );

      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          result.rawContent = 'The user did not grant the camera permission!';
        });
      } else {
        result.rawContent = 'Unknown error: $e';
      }
      setState(() {
        scanResult = result;
      });
    }
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
                          Text("Successful redeem point", style: TextStyle(
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
  }
}