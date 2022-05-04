import 'package:flutter/material.dart';
import 'package:smart_museum/lan/locale_keys.g.dart';
import 'package:smart_museum/view_data.dart';
import 'package:easy_localization/easy_localization.dart';
class EditData extends StatefulWidget {
   const EditData({Key? key}) : super(key: key);

  @override
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
      backgroundColor: Colors.white,foregroundColor: Colors.indigo,
      elevation: 0,
      title: Text(LocaleKeys.editdata.tr()),
    ),

    body: Column(
      children: [
        const SizedBox(height: 10,),
        InkWell(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (c)=>ViewData(number: 1.toString(),)));
          },
          child: Container(
              decoration:  const BoxDecoration(
                  color: Color(0xfff6f5f8),
                  borderRadius:
                  BorderRadius.all(Radius.circular(20))),
              width: MediaQuery.of(context).size.width,
              height: 70,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                     const SizedBox(width: 16),
                    Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Colors.indigo
                                .withOpacity(0.1),
                            borderRadius:  const BorderRadius.all(
                                Radius.circular(10))),
                        child:  const Center(
                            child: Text('1',style: TextStyle(color:Colors.indigo, fontSize: 22),)
                        )),
                     const SizedBox(width: 20),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Statue 1",
                            style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'steve'),
                          ),
                          Text(LocaleKeys.edit.tr(),
                              style:  const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'steve',
                                  fontWeight: FontWeight.bold))
                        ])
                  ])),
        ),
        const SizedBox(height: 10,),
        InkWell(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (c)=>ViewData(number: 2.toString(),)));

          },
          child: Container(
              decoration:  const BoxDecoration(
                  color: Color(0xfff6f5f8),
                  borderRadius:
                  BorderRadius.all(Radius.circular(20))),
              width: MediaQuery.of(context).size.width,
              height: 70,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                     const SizedBox(width: 16),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          color: Colors.indigo
                              .withOpacity(0.1),
                          borderRadius:  const BorderRadius.all(
                              Radius.circular(10))),
                      child:  const Center(
                          child: Text('2',style: TextStyle(color:Colors.indigo, fontSize: 22),)
                              )),
                     const SizedBox(width: 20),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Statue 2",
                            style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'steve'),
                          ),
                          Text(LocaleKeys.edit.tr(),
                              style:  const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'steve',
                                  fontWeight: FontWeight.bold))
                        ])
                  ])),
        ),
        const SizedBox(height: 10,),
        InkWell(onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (c)=>ViewData(number: 3.toString(),)));

        },

          child: Container(
              decoration:  const BoxDecoration(
                  color: Color(0xfff6f5f8),
                  borderRadius:
                  BorderRadius.all(Radius.circular(20))),
              width: MediaQuery.of(context).size.width,
              height: 70,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                     const SizedBox(width: 16),
                    Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Colors.indigo
                                .withOpacity(0.1),
                            borderRadius:  const BorderRadius.all(
                                Radius.circular(10))),
                        child:  const Center(
                            child: Text('3',style: TextStyle(color:Colors.indigo, fontSize: 22),)
                        )),
                     const SizedBox(width: 20),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Statue 3",
                            style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'steve'),
                          ),
                          Text(LocaleKeys.edit.tr(),
                              style:  const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'steve',
                                  fontWeight: FontWeight.bold))
                        ])
                  ])),
        ),
        const SizedBox(height: 10,),
        InkWell(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (c)=>ViewData(number: 4.toString(),)));

          },
          child: Container(
              decoration:  const BoxDecoration(
                  color: Color(0xfff6f5f8),
                  borderRadius:
                  BorderRadius.all(Radius.circular(20))),
              width: MediaQuery.of(context).size.width,
              height: 70,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                     const SizedBox(width: 16),
                    Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Colors.indigo
                                .withOpacity(0.1),
                            borderRadius:  const BorderRadius.all(
                                Radius.circular(10))),
                        child:  const Center(
                            child: Text('4',style: TextStyle(color:Colors.indigo, fontSize: 22),)
                        )),
                     const SizedBox(width: 20),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Statue 4",
                            style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'steve'),
                          ),
                          Text(LocaleKeys.edit.tr(),
                              style:  const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'steve',
                                  fontWeight: FontWeight.bold))
                        ])
                  ])),
        ),
        const SizedBox(height: 10,),
        InkWell(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (c)=>ViewData(number: 5.toString(),)));

          },
          child: Container(
              decoration:  const BoxDecoration(
                  color: Color(0xfff6f5f8),
                  borderRadius:
                  BorderRadius.all(Radius.circular(20))),
              width: MediaQuery.of(context).size.width,
              height: 70,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                     const SizedBox(width: 16),
                    Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Colors.indigo
                                .withOpacity(0.1),
                            borderRadius:  const BorderRadius.all(
                                Radius.circular(10))),
                        child:  const Center(
                            child: Text('5',style: TextStyle(color:Colors.indigo, fontSize: 22),)
                        )),
                     const SizedBox(width: 20),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Statue 5",
                            style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'steve'),
                          ),
                          Text(LocaleKeys.edit.tr(),
                              style:  const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'steve',
                                  fontWeight: FontWeight.bold))
                        ])
                  ])),
        ),
      ],
    )
    ));
  }
}
