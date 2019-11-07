import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrapp/api/api.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/services.dart';
import 'package:qrapp/data_state/data_state.dart';

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var qrText = "Okut";
  var isOpen=false;

  final _ad = TextEditingController();
  final _soyad = TextEditingController();
  final _mail = TextEditingController();
  final _tel = TextEditingController();

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
      showDialog(context: context, builder: (context) {
          var data = Provider.of<DataState>(context);
          return AlertDialog(
              title: Text("Form"),
              content: Form(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _ad,
                        decoration: InputDecoration(
                            hintText: "Ad",
                            border: OutlineInputBorder(
                            )
                        ),
                        onChanged: (string) {
                          data.isim = string;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _soyad,
                        decoration: InputDecoration(
                            hintText: "Soyad",
                            border: OutlineInputBorder(
                            )
                        ),
                        onChanged: (string) {
                          data.soyad = string;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _mail,
                        decoration: InputDecoration(
                            hintText: "e-Mail",
                            border: OutlineInputBorder(
                            )
                        ),
                        onChanged: (string) {
                          data.mail = string;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _tel,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: "Telefon",
                            border: OutlineInputBorder(
                            )
                        ),
                        onChanged: (string) {
                          data.tel = string;
                        },
                      ),
                    ),

                  ],
                ),
              ),
              actions: <Widget>[
              FlatButton(
              onPressed: () => Navigator.pop(context),
        child: Text("Kapat")),
        FlatButton(
        onPressed: () async{
          print(qrText);
          print(data.isim);
          print(data.soyad);
          print(data.mail);
          print(data.tel);
        print(await MyApi.postData(eventID: qrText,isim: data.isim,soyad: data.soyad,mail: data.mail,telefon: data.tel));
        },
        child: Text("Gönder"))
        ],
        );
        }

      );
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
            child: RaisedButton(onPressed: () => scanQR() ,child: Text(qrText),
            color: Colors.lightBlue,),
          )
        ],
      ),
    ));
  }
}
