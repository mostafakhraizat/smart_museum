
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smart_museum/loginpage.dart';
import 'package:easy_localization/easy_localization.dart';

import 'lan/codegen_loader.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(
    path: 'assets/lan',
    supportedLocales: const[
      Locale('ar'),
      Locale('en'),
      Locale('fr'),
      Locale('ja')
    ],
    fallbackLocale:const Locale('en'),
    assetLoader:const CodegenLoader(),
    child:const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  const LoginPage(),
    );
  }
}

