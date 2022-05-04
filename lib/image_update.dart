import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:easy_localization/easy_localization.dart';

import 'lan/locale_keys.g.dart';
class ImageUpdate extends StatefulWidget {
  const ImageUpdate({Key? key, required this.number,required this.image}) : super(key: key);
  final int number;
  final String image;
  @override
  _ImageUpdateState createState() => _ImageUpdateState();
}

class _ImageUpdateState extends State<ImageUpdate> {
  final picker = ImagePicker();
  File? imageFile;
  File? videoFile;
  String imageUrl = '';
  String url = '';
  String urlPath = '';
  bool loading = false;

  Future<String> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile = File(pickedFile!.path);
    });
    return pickedFile!.path;
  }
  @override
  void initState() {
    getImage();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.indigo,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(LocaleKeys.imageUpdateStatue.tr() + " " + widget.number.toString()),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FutureBuilder(
                future: getImage(),
                builder: (context, snapshot) {
                  if(widget.image.isEmpty||widget.image.toString()=='null'){
                    if(imageFile==null){
                      return Image.network('https://i.imgur.com/sUFH1Aq.png');
                    }else{
                      return Image.file(imageFile!,height: 300,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fill,);
                    }
                  }else{
                    if(imageFile==null){
                      return Image.network(
                        widget.image,
                        height: 300,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fill,
                      );
                    }else{
                      return Image.file(imageFile!,height: 300,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fill,);
                    }
                  }


                  // if (imageUrl == '' ) {
                  //   if (imageFile == null) {
                  //     return Image.network('https://i.imgur.com/sUFH1Aq.png');
                  //   } else {
                  //     return Image.file(
                  //       imageFile!,
                  //       height: 300,
                  //       width: MediaQuery.of(context).size.width,
                  //       fit: BoxFit.fill,
                  //     );
                  //   }
                  // } else {
                  //   return Image.network(
                  //     url,
                  //     height: 300,
                  //     width: MediaQuery.of(context).size.width,
                  //     fit: BoxFit.fill,
                  //   );
                  // }
                }),
            const SizedBox(
              height: 12,
            ),
            Text(LocaleKeys.imageUpdateStatue.tr()),
            const SizedBox(
              height: 32
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  pickImage().then((value) {});
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: Center(
                    child: Text(LocaleKeys.editImage.tr()),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.indigo.withOpacity(0.2)),
                ),
              ),
            ),
            !loading
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          loading = true;
                        });
                        uploadImagetFirebase(imageFile!.path.toString())
                            .then((value) {
                          FirebaseDatabase.instance
                              .ref('Data')
                              .child(widget.number.toString())
                              .child('image')
                              .set(urlPath);
                          setState(() {
                            loading = false;
                          });
                        }).onError((error, stackTrace) {
                          loading = false;
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        child: Center(
                          child: Text(LocaleKeys.Save.tr()),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.indigo.withOpacity(0.2)),
                      ),
                    ),
                  )
                : const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  Future<String> uploadImagetFirebase(String imagePath) async {
    await FirebaseStorage.instance
        .ref(imagePath)
        .putFile(File(imagePath))
        .then((taskSnapshot) {
      print('steve');
      print(taskSnapshot.state.name);
      print(taskSnapshot.state);
      FirebaseStorage.instance.ref(imagePath).getDownloadURL().then((value) {
        setState(() {
          url = value;
        });
        FirebaseDatabase.instance
            .ref('Data')
            .child(widget.number.toString())
            .child('image')
            .set(url)
            .then((value) => Navigator.pop(context));
      }).onError((onError, s) {
        print('steve error0000' + onError.toString());
      });
    });
    return url;
  }

  Future<String> getImage() async {
    FirebaseDatabase database = FirebaseDatabase.instance;
    database
        .ref('Data')
        .child(widget.number.toString())
        .child('image')
        .get()
        .then((value) {
        imageUrl = value.value.toString();
    });
    return imageUrl;
  }
}
