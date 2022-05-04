import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:smart_museum/lan/locale_keys.g.dart';
class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('asd'),
      ),
      body: Center(
        child:
        InkWell(
          onTap: ()async{
            await context.setLocale(const Locale('en'));

          },
            child:
          Text(LocaleKeys.Almonds.tr()),
        ),
      ),
    );
  }
}
