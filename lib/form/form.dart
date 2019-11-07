import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrapp/api/api.dart';
import 'package:qrapp/data_state/data_state.dart';

class MyForm extends StatefulWidget {
  final String qrText;

  MyForm(this.qrText);

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _ad = TextEditingController();
  final _soyad = TextEditingController();
  final _mail = TextEditingController();
  final _tel = TextEditingController();

  GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<DataState>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Form Page"),
      ),
      body: Form(
        key: _key,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: TextFormField(
                controller: _ad,
                decoration: InputDecoration(
                    hintText: "Ad", border: OutlineInputBorder()),
                onChanged: (string) {
                  data.isim = string;
                },
                validator: (deger){
                  return deger.length < 1 
                  ? "Bu alan boş bırakılamaz"
                  : null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: TextFormField(
                controller: _soyad,
                decoration: InputDecoration(
                    hintText: "Soyad", border: OutlineInputBorder()),
                onChanged: (string) {
                  data.soyad = string;
                },
                validator: (deger){
                  return deger.length < 1 
                  ? "Bu alan boş bırakılamaz"
                  : null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: TextFormField(
                controller: _mail,
                decoration: InputDecoration(
                    hintText: "e-Mail", border: OutlineInputBorder()),
                onChanged: (string) {
                  data.mail = string;
                },
                validator: (deger){
                  return deger.length < 1 
                  ? "Bu alan boş bırakılamaz"
                  : null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: TextFormField(
                controller: _tel,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: "Telefon", border: OutlineInputBorder()),
                onChanged: (string) {
                  data.tel = string;
                },
                validator: (deger){
                  return deger.length < 1 
                  ? "Bu alan boş bırakılamaz"
                  : null;
                },
              ),
            ),
            RaisedButton(
                onPressed: () async {
                  print(widget.qrText);
                  print(data.isim);
                  print(data.soyad);
                  print(data.mail);
                  print(data.tel);
                  
                  if(_key.currentState.validate()){
                     if(await MyApi.postData(eventID: widget.qrText,isim: data.isim,soyad: data.soyad,mail: data.mail,telefon: data.tel)){
                       Navigator.pop(context,'-1');
                     }
                  }
                },
                child: Text("Gönder"))
          ],
        ),
      ),
    );
  }
}
