import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/services.dart';
import 'package:qrapp/form/form.dart';

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var qrText = "";

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Kapat", true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Bum';
    }

    if (!mounted) return;

    setState(() {
      qrText = barcodeScanRes;
        if(qrText != "-1"){
          Navigator.push(context, MaterialPageRoute(builder: (context) => MyForm(qrText))).then((gelenDeger){
          qrText = gelenDeger;
          print("qr Deger : $qrText");
        });
        }
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("QR Code"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: RaisedButton(onPressed: () => scanQR() ,child: Text("Okut"),
            color: Colors.lightBlue,),
          )
        ],
      ),
    ));
  }
}
