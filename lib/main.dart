import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrapp/data_state/data_state.dart';
import 'package:qrapp/myapp/myapp.dart';

main() => runApp(MultiProvider(
  providers: [
    ChangeNotifierProvider(
      builder: (context) => DataState(),
    )
  ],
  child: MaterialApp(home: MyApp()),
));
