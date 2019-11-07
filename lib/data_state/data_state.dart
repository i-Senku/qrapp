import 'package:flutter/cupertino.dart';

class DataState with ChangeNotifier{

  String _isim;
  String _soyad;
  String _tel;
  String _mail;

  String get isim => _isim;

  set isim(String value) {
    _isim = value;
    notifyListeners();
  }

  String get soyad => _soyad;

  set soyad(String value) {
    _soyad = value;
    notifyListeners();
  }

  String get tel => _tel;

  set tel(String value) {
    _tel = value;
    notifyListeners();
  }

  String get mail => _mail;

  set mail(String value) {
    _mail = value;
    notifyListeners();
  }

}