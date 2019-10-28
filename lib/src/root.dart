import 'package:flutterdemo/src/blocs/global.dart';
import 'package:flutterdemo/src/ui/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class FlutterDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Provider(
      builder: (BuildContext context) => GlobalBloc(),
      dispose: (BuildContext context, GlobalBloc bloc) => bloc.dispose(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
           brightness: Brightness.dark,             
        ),
        home: HomeScreen(),
      ),
    );
  }
}
