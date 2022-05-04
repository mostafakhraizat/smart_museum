import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_museum/video_network.dart';
import 'package:easy_localization/easy_localization.dart';
import 'edit.dart';
import 'lan/locale_keys.g.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool english=true,french=false,arabic=false,chinese=false;
  @override
  void initState() {
    getData();
    getDesc1();
    getDesc2();
    getDesc3();
    getDesc4();
    getDesc5();


    getVideo2();

    getImage1();
    getImage2();
    getImage3();
    getImage4();
    getImage5();


    super.initState();
  }

  String data = '0';
  String description1 = '';
  String description2 = '';
  String description3 = '';
  String description4 = '';
  String description5 = '';



  String video1 = '';
  String video2 = '';
  String video3 = '';
  String video4 = '';
  String video5 = '';





  String image1 = '';
  String image2 = '';
  String image3 = '';
  String image4 = '';
  String image5 = '';


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            foregroundColor: Colors.indigo,
            backgroundColor: Colors.white,
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (w) => const EditData()));
                  },
                  child: Text(
                    LocaleKeys.edit.tr(),
                    style: const TextStyle(color: Colors.indigo),
                  ))
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: ()async{
                        setState(() {
                          english=true;
                          french=false;
                          arabic=false;
                          chinese=false;

                        });
                        await context.setLocale(const Locale('en'));
                      },
                      child: Container(
                        height: 32,
                        width: 75,
                        child: Center(
                          child: Text(LocaleKeys.english.tr(),style: TextStyle(color: english?Colors.white:Colors.indigo),),
                        ),
                        decoration: BoxDecoration(
                          color: english?Colors.indigo:Colors.indigo.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12)
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: ()async{
                        setState(() {
                          english=false;
                          french=false;
                          arabic=true;
                          chinese=false;

                        });
                        await context.setLocale(const Locale('ar'));
                      },
                      child: Container(
                        height: 32,
                        width: 75,
                        child: Center(
                          child: Text(LocaleKeys.arabic.tr(),style: TextStyle(color: arabic?Colors.white:Colors.indigo),),
                        ),
                        decoration: BoxDecoration(
                          color: arabic?Colors.indigo:Colors.indigo.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12)
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: ()async{
                        setState(() {
                          english=false;
                          french=true;
                          arabic=false;
                          chinese=false;

                        });
                        await context.setLocale(const Locale('fr'));

                      },
                      child: Container(
                        height: 32,
                        width: 75,
                        child: Center(
                          child: Text(LocaleKeys.french.tr(),style: TextStyle(color: french?Colors.white:Colors.indigo),),
                        ),
                        decoration: BoxDecoration(
                          color: french?Colors.indigo:Colors.indigo.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12)
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: ()async{
                        setState(() {
                          english=false;
                          french=false;
                          arabic=false;
                          chinese=true;
                        });
                          await context.setLocale(const Locale('ja'));
                      },
                      child: Container(
                        height: 32,
                        width: 75,
                        child: Center(
                          child: Text(LocaleKeys.chinese.tr(),style: TextStyle(color: chinese?Colors.white:Colors.indigo),),
                        ),
                        decoration: BoxDecoration(
                          color: chinese?Colors.indigo:Colors.indigo.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12)
                        ),
                      ),
                    ),

                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: FutureBuilder(
                      future: getData(),
                      builder: (con, text) {
                        if (text.data.toString() == "1") {
                          return Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 22,
                                  ),
                                  Text(
                                     LocaleKeys.checked.tr(),
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  const Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                    size: 32,
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 22,
                                  ),
                                  Text(
                                    LocaleKeys.radius1.tr(),
                                    style: const TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              FutureBuilder(future:getImage1(),
                                builder: (context,data) {
                                  if(data.data.toString()==''){
                                    return ClipRRect(
                                        borderRadius: BorderRadius.circular(22),
                                        child: Image.asset('assets/checked.png',
                                            fit: BoxFit.cover));
                                  }else{
                                    if(data.data.toString().length<10){
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }else{
                                      return ClipRRect(
                                          borderRadius: BorderRadius.circular(22),
                                          child: Image.network(data.data.toString(),
                                            fit: BoxFit.fill,height: 200,));
                                    }
                                  }
                                }
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 22,
                                  ),
                                  Text(
                                    LocaleKeys.info.tr(),
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  const Icon(
                                    Icons.info,
                                    color: Colors.green,
                                    size: 32,
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Divider(),
                              const SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap:(){
                                  getVideo1().then((value) {
                                    Future.delayed(const Duration(seconds: 1),(){
                                      if(value.toString()==''){
                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Video not set')));
                                      }else{
                                        Navigator.of(context).push(MaterialPageRoute(builder: (c)=>VideoPlayNetwork(path: value.toString(),)));
                                      }
                                    });
                                  });
                                },
                                child: Container(
                                    decoration: const BoxDecoration(
                                        color: Color(0xfff6f5f8),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    width: MediaQuery.of(context).size.width,
                                    height: 70,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const SizedBox(width: 16),
                                          Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                color: const Color(0xffe9793d)
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10))),
                                            child: const Center(
                                                child: Icon(Icons.video_file,
                                                    color: Color(0xffe9793d),
                                                    size: 22)),
                                          ),
                                          const SizedBox(width: 20),
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                 Text(
                                                  LocaleKeys.video.tr(),
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontFamily: 'steve'),
                                                ),
                                                Text(LocaleKeys.open.tr(),
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'steve',
                                                        fontWeight:
                                                            FontWeight.bold))
                                              ])
                                        ])),
                              ),
                              
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                  decoration: const BoxDecoration(
                                      color: Color(0xfff6f5f8),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  width: MediaQuery.of(context).size.width,
                                  height: 70,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(width: 16),
                                        Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.blue.withOpacity(0.1),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10))),
                                          child: const Center(
                                              child: Icon(Icons.info_outline,
                                                  color: Colors.blue,
                                                  size: 22)),
                                        ),
                                        const SizedBox(width: 20),
                                        Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                               Text(
                                                LocaleKeys.description.tr(),
                                                style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontFamily: 'steve'),
                                              ),
                                              FutureBuilder(
                                                  builder: (cont, ext) {
                                                return Text(description1,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'steve',
                                                        fontWeight:
                                                            FontWeight.bold));
                                              })
                                            ])
                                      ])),
                            ],
                          );
                        } else if (text.data.toString() == "2") {
                          return Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 22,
                                  ),
                                  Text(
                                     LocaleKeys.checked.tr(),
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  const Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                    size: 32,
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 22,
                                  ),
                                  Text(
                        LocaleKeys.radius2.tr(),

                                    style: const TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              FutureBuilder(future:getImage2(),
                                  builder: (context,data) {
                                    if(data.data.toString()==''){
                                      return ClipRRect(
                                          borderRadius: BorderRadius.circular(22),
                                          child: Image.asset('assets/checked.png',
                                              fit: BoxFit.cover));
                                    }else{
                                      if(data.data.toString().length<10){
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }else{
                                        return ClipRRect(
                                            borderRadius: BorderRadius.circular(22),
                                            child: Image.network(data.data.toString(),
                                              fit: BoxFit.fill,height: 200,));
                                      }
                                    }
                                  }
                              ),

                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 22,
                                  ),
                                  Text(
                                    LocaleKeys.info.tr(),
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  const Icon(
                                    Icons.info,
                                    color: Colors.green,
                                    size: 32,
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Divider(),
                              const SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap:(){
                                  getVideo2().then((value) {
                                    Future.delayed(const Duration(seconds: 1),(){
                                      if(value.toString()==''){
                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Video not set')));
                                      }else{
                                        Navigator.of(context).push(MaterialPageRoute(builder: (c)=>VideoPlayNetwork(path: value.toString(),)));
                                      }
                                    });
                                  });
                                },
                                child: Container(
                                    decoration: const BoxDecoration(
                                        color: Color(0xfff6f5f8),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    width: MediaQuery.of(context).size.width,
                                    height: 70,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const SizedBox(width: 16),
                                          Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                color: const Color(0xffe9793d)
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10))),
                                            child: const Center(
                                                child: Icon(Icons.video_file,
                                                    color: Color(0xffe9793d),
                                                    size: 22)),
                                          ),
                                          const SizedBox(width: 20),
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                 Text(
                                                  LocaleKeys.video.tr(),
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontFamily: 'steve'),
                                                ),
                                                Text(LocaleKeys.open.tr(),
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'steve',
                                                        fontWeight:
                                                            FontWeight.bold))
                                              ])
                                        ])),
                              ),
                              
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                  decoration: const BoxDecoration(
                                      color: Color(0xfff6f5f8),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  width: MediaQuery.of(context).size.width,
                                  height: 70,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(width: 16),
                                        Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.blue.withOpacity(0.1),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10))),
                                          child: const Center(
                                              child: Icon(Icons.info_outline,
                                                  color: Colors.blue,
                                                  size: 22)),
                                        ),
                                        const SizedBox(width: 20),
                                        Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                               Text(
                                                LocaleKeys.description.tr(),
                                                style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontFamily: 'steve'),
                                              ),
                                              FutureBuilder(
                                                  builder: (cont, ext) {
                                                return Text(description2,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'steve',
                                                        fontWeight:
                                                            FontWeight.bold));
                                              })
                                            ])
                                      ])),
                            ],
                          );
                        } else if (text.data.toString() == "3") {
                          return Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 22,
                                  ),
                                  Text(
                                     LocaleKeys.checked.tr(),
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  const Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                    size: 32,
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 22,
                                  ),
                                  Text(
                                    LocaleKeys.radius3.tr(),

                                    style: const TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              FutureBuilder(future:getImage3(),
                                  builder: (context,data) {
                                    if(data.data.toString()==''){
                                      return ClipRRect(
                                          borderRadius: BorderRadius.circular(22),
                                          child: Image.asset('assets/checked.png',
                                              fit: BoxFit.cover));
                                    }else{
                                      if(data.data.toString().length<10){
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }else{
                                        return ClipRRect(
                                            borderRadius: BorderRadius.circular(22),
                                            child: Image.network(data.data.toString(),
                                              fit: BoxFit.fill,height: 200,));
                                      }
                                    }
                                  }
                              ),

                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 22,
                                  ),
                                  Text(
                                    LocaleKeys.info.tr(),
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  const Icon(
                                    Icons.info,
                                    color: Colors.green,
                                    size: 32,
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Divider(),
                              const SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap:(){
                                  getVideo3().then((value) {
                                    Future.delayed(const Duration(seconds: 1),(){
                                      if(value.toString()==''){
                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Video not set')));
                                      }else{
                                        Navigator.of(context).push(MaterialPageRoute(builder: (c)=>VideoPlayNetwork(path: value.toString(),)));
                                      }
                                    });
                                  });
                                },
                                child: Container(
                                    decoration: const BoxDecoration(
                                        color: Color(0xfff6f5f8),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    width: MediaQuery.of(context).size.width,
                                    height: 70,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const SizedBox(width: 16),
                                          Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                color: const Color(0xffe9793d)
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10))),
                                            child: const Center(
                                                child: Icon(Icons.video_file,
                                                    color: Color(0xffe9793d),
                                                    size: 22)),
                                          ),
                                          const SizedBox(width: 20),
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                 Text(
                                                  LocaleKeys.video.tr(),
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontFamily: 'steve'),
                                                ),
                                                Text(LocaleKeys.open.tr(),
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'steve',
                                                        fontWeight:
                                                            FontWeight.bold))
                                              ])
                                        ])),
                              ),
                              
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                  decoration: const BoxDecoration(
                                      color: Color(0xfff6f5f8),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  width: MediaQuery.of(context).size.width,
                                  height: 70,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(width: 16),
                                        Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.blue.withOpacity(0.1),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10))),
                                          child: const Center(
                                              child: Icon(Icons.info_outline,
                                                  color: Colors.blue,
                                                  size: 22)),
                                        ),
                                        const SizedBox(width: 20),
                                        Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                               Text(
                                                LocaleKeys.description.tr(),
                                                style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontFamily: 'steve'),
                                              ),
                                              FutureBuilder(
                                                  builder: (cont, ext) {
                                                return Text(description3,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'steve',
                                                        fontWeight:
                                                            FontWeight.bold));
                                              })
                                            ])
                                      ])),
                            ],
                          );
                        } else if (text.data.toString() == "4") {
                          return Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 22,
                                  ),
                                  Text(
                                     LocaleKeys.checked.tr(),
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  const Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                    size: 32,
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 22,
                                  ),
                                  Text(
                                    LocaleKeys.radius4.tr(),

                                    style: const TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              FutureBuilder(future:getImage4(),
                                  builder: (context,data) {
                                    if(data.data.toString()==''){
                                      return ClipRRect(
                                          borderRadius: BorderRadius.circular(22),
                                          child: Image.asset('assets/checked.png',
                                              fit: BoxFit.cover));
                                    }else{
                                      if(data.data.toString().length<10){
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }else{
                                        return ClipRRect(
                                            borderRadius: BorderRadius.circular(22),
                                            child: Image.network(data.data.toString(),
                                              fit: BoxFit.fill,height: 200,));
                                      }
                                    }
                                  }
                              ),

                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 22,
                                  ),
                                  Text(
                                    LocaleKeys.info.tr(),
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  const Icon(
                                    Icons.info,
                                    color: Colors.green,
                                    size: 32,
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Divider(),
                              const SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap:(){
                                  getVideo4().then((value) {
                                    Future.delayed(const Duration(seconds: 1),(){
                                      if(value.toString()==''){
                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Video not set')));
                                      }else{
                                        Navigator.of(context).push(MaterialPageRoute(builder: (c)=>VideoPlayNetwork(path: value.toString(),)));
                                      }
                                    });
                                  });
                                },
                                child: Container(
                                    decoration: const BoxDecoration(
                                        color: Color(0xfff6f5f8),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    width: MediaQuery.of(context).size.width,
                                    height: 70,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const SizedBox(width: 16),
                                          Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                color: const Color(0xffe9793d)
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10))),
                                            child: const Center(
                                                child: Icon(Icons.video_file,
                                                    color: Color(0xffe9793d),
                                                    size: 22)),
                                          ),
                                          const SizedBox(width: 20),
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                 Text(
                                                  LocaleKeys.video.tr(),
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontFamily: 'steve'),
                                                ),
                                                Text(LocaleKeys.open.tr(),
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'steve',
                                                        fontWeight:
                                                            FontWeight.bold))
                                              ])
                                        ])),
                              ),
                              
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                  decoration: const BoxDecoration(
                                      color: Color(0xfff6f5f8),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  width: MediaQuery.of(context).size.width,
                                  height: 70,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(width: 16),
                                        Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.blue.withOpacity(0.1),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10))),
                                          child: const Center(
                                              child: Icon(Icons.info_outline,
                                                  color: Colors.blue,
                                                  size: 22)),
                                        ),
                                        const SizedBox(width: 20),
                                        Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                               Text(
                                                LocaleKeys.description.tr(),
                                                style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontFamily: 'steve'),
                                              ),
                                              FutureBuilder(
                                                  builder: (cont, ext) {
                                                return Text(description4,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'steve',
                                                        fontWeight:
                                                            FontWeight.bold));
                                              })
                                            ])
                                      ])),
                            ],
                          );
                        } else if (text.data.toString() == "5") {
                          return Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 22,
                                  ),
                                  Text(
                                     LocaleKeys.checked.tr(),
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  const Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                    size: 32,
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 22,
                                  ),
                                  Text(
                                    LocaleKeys.radius5.tr(),

                                    style: const TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              FutureBuilder(future:getImage5(),
                                  builder: (context,data) {
                                   if(data.hasData){
                                     if(data.data.toString()==''){
                                       return ClipRRect(
                                           borderRadius: BorderRadius.circular(22),
                                           child: Image.asset('assets/checked.png',
                                               fit: BoxFit.cover));
                                     }else{
                                       if(data.data.toString().length<10){
                                         return const Center(
                                           child: CircularProgressIndicator(),
                                         );
                                       }else{
                                         return ClipRRect(
                                             borderRadius: BorderRadius.circular(22),
                                             child: Image.network(data.data.toString(),
                                               fit: BoxFit.fill,height: 200,));
                                       }
                                     }
                                   }else{
                                     return const Center(
                                       child: CircularProgressIndicator(),
                                     );
                                   }
                                  }
                              ),

                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 22,
                                  ),
                                  Text(
                                    LocaleKeys.info.tr(),
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  const Icon(
                                    Icons.info,
                                    color: Colors.green,
                                    size: 32,
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Divider(),
                              const SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap:(){
                                  getVideo5().then((value) {
                                    Future.delayed(const Duration(seconds: 1),(){
                                      if(value.toString()==''){
                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Video not set')));
                                      }else{
                                        Navigator.of(context).push(MaterialPageRoute(builder: (c)=>VideoPlayNetwork(path: value.toString(),)));
                                      }
                                    });
                                  });
                                },
                                child: Container(
                                    decoration: const BoxDecoration(
                                        color: Color(0xfff6f5f8),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    width: MediaQuery.of(context).size.width,
                                    height: 70,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const SizedBox(width: 16),
                                          Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                color: const Color(0xffe9793d)
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10))),
                                            child: const Center(
                                                child: Icon(Icons.video_file,
                                                    color: Color(0xffe9793d),
                                                    size: 22)),
                                          ),
                                          const SizedBox(width: 20),
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                 Text(
                                                  LocaleKeys.video.tr(),
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontFamily: 'steve'),
                                                ),
                                                Text(LocaleKeys.open.tr(),
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'steve',
                                                        fontWeight:
                                                            FontWeight.bold))
                                              ])
                                        ])),
                              ),
                              
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                  decoration: const BoxDecoration(
                                      color: Color(0xfff6f5f8),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  width: MediaQuery.of(context).size.width,
                                  height: 70,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(width: 16),
                                        Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.blue.withOpacity(0.1),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10))),
                                          child: const Center(
                                              child: Icon(Icons.info_outline,
                                                  color: Colors.blue,
                                                  size: 22)),
                                        ),
                                        const SizedBox(width: 20),
                                        Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                               Text(
                                                LocaleKeys.description.tr(),
                                                style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontFamily: 'steve'),
                                              ),
                                              FutureBuilder(
                                                future:getDesc5(),
                                                  builder: (cont, ext) {
                                                return Text(description5,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'steve',
                                                        fontWeight:
                                                            FontWeight.bold));
                                              })
                                            ])
                                      ])),
                            ],
                          );
                        } else {
                          return Column(
                            children: [
                              const SizedBox(
                                height: 100,
                              ),
                              Lottie.asset('assets/robot.json'),
                              Row(
                                children: const [
                                  SizedBox(
                                    width: 22,
                                  ),
                                  Text('No statue marked,'),
                                  Text(
                                    '  still looking...',
                                    style: TextStyle(
                                        color: Colors.indigo,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                ],
                              ),
                            ],
                          );
                        }
                      }),
                ),
              ],
            ),
          )),
    );
  }

  Future<String> getData() async {
    FirebaseDatabase.instance.ref('statue number').get().then((value) {
      setState(() {
        data = value.value.toString();
      });
    });
    return data;
  }

  Future<String> getDesc1() async {
    FirebaseDatabase.instance
        .ref('Data')
        .child('1')
        .child('description')
        .get()
        .then((value) {
      setState(() {
        description1 = value.value.toString();
      });
    });
    return description1;
  }

  Future<String> getDesc2() async {
    FirebaseDatabase.instance
        .ref('Data')
        .child('2')
        .child('description')
        .get()
        .then((value) {
      setState(() {
        description2 = value.value.toString();
      });
    });
    return description2;
  }

  Future<String> getDesc3() async {
    FirebaseDatabase.instance
        .ref('Data')
        .child('3')
        .child('description')
        .get()
        .then((value) {
      setState(() {
        description3 = value.value.toString();
      });
    });
    return description3;
  }

  Future<String> getDesc4() async {
    FirebaseDatabase.instance
        .ref('Data')
        .child('4')
        .child('description')
        .get()
        .then((value) {
      setState(() {
        description4 = value.value.toString();
      });
    });
    return description4;
  }

  Future<String> getDesc5() async {
    FirebaseDatabase.instance
        .ref('Data')
        .child('5')
        .child('description')
        .get()
        .then((value) {
      setState(() {
        description5 = value.value.toString();
      });
    });
    return description5;
  }



  Future<String> getVideo1() async {
    FirebaseDatabase.instance
        .ref('Data')
        .child('1')
        .child('video')
        .get()
        .then((value) {
      setState(() {
        video1 = value.value.toString();
      });
    });
    return video1;
  }

  Future<String> getVideo2() async {
    FirebaseDatabase.instance
        .ref('Data')
        .child('2')
        .child('video')
        .get()
        .then((value) {
      setState(() {
        video2 = value.value.toString();
      });
    });
    return video2;
  }

  Future<String> getVideo3() async {
    FirebaseDatabase.instance
        .ref('Data')
        .child('3')
        .child('video')
        .get()
        .then((value) {
      setState(() {
        video3 = value.value.toString();
      });
    });
    return video3;
  }

  Future<String> getVideo4() async {
    FirebaseDatabase.instance
        .ref('Data')
        .child('4')
        .child('video')
        .get()
        .then((value) {
      setState(() {
        video4 = value.value.toString();
      });
    });
    return video4;
  }

  Future<String> getVideo5() async {
    FirebaseDatabase.instance
        .ref('Data')
        .child('5')
        .child('video')
        .get()
        .then((value) {
      setState(() {
        video5 = value.value.toString();
      });
    });
    return video5;
  }








  Future<String> getImage1() async {
    FirebaseDatabase.instance
        .ref('Data')
        .child('1')
        .child('image')
        .get()
        .then((value) {
      setState(() {
        image1 = value.value.toString();
      });

    });
    print('imagei' + image1);
    return image1;
  }

  Future<String> getImage2() async {
    FirebaseDatabase.instance
        .ref('Data')
        .child('2')
        .child('image')
        .get()
        .then((value) {
      setState(() {
        image2 = value.value.toString();
      });
    });
    return image2;
  }

  Future<String> getImage3() async {
    FirebaseDatabase.instance
        .ref('Data')
        .child('3')
        .child('image')
        .get()
        .then((value) {
      setState(() {
        image3 = value.value.toString();
      });
    });
    return image3;
  }

  Future<String> getImage4() async {
    FirebaseDatabase.instance
        .ref('Data')
        .child('4')
        .child('image')
        .get()
        .then((value) {
      setState(() {
        image4 = value.value.toString();
      });
    });
    return image4;
  }

  Future<String> getImage5() async {
    FirebaseDatabase.instance
        .ref('Data')
        .child('5')
        .child('image')
        .get()
        .then((value) {
      setState(() {
        image5 = value.value.toString();
      });
    });
    return image5;
  }




}
