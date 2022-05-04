import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_museum/lan/locale_keys.g.dart';
import 'package:smart_museum/video_network.dart';
import 'package:smart_museum/video_play.dart';
import 'package:video_player/video_player.dart';
import 'package:easy_localization/easy_localization.dart';
class VideoUpdate extends StatefulWidget {
  const VideoUpdate({Key? key, required this.number,required this.video}) : super(key: key);
  final int number;
  final String video;
  @override
  _VideoUpdateState createState() => _VideoUpdateState();
}

class _VideoUpdateState extends State<VideoUpdate> {
  final picker = ImagePicker();
  File? videoFile;
  String videoUrl = '';
  String url = '';
  String urlPath='';
  bool loading = false;


  Future<String> pickVideo() async {
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if(pickedFile!=null){


        pickedFile.length().then((value) {
          if(value>10000000){
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Too large')));
          }else{
            setState(() {
              videoFile = File(pickedFile.path);
            });
          }
        });
      return pickedFile.path;
    }else{
      return '';
    }
  }
  VideoPlayerController? _controller;
  @override
  void initState() {
    _controller = VideoPlayerController.network(widget.video);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        foregroundColor: Colors.indigo,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(LocaleKeys.videoUpdateStatue.tr()+"  " + widget.number.toString()),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FutureBuilder(builder: (context,snapshot) {
              if(widget.video.isEmpty||widget.video.toString()=='null'){


                if(videoFile==null){
                  return Image.network('https://i.imgur.com/sUFH1Aq.png');
                }else{


                 return TextButton(onPressed: (){
                   Navigator.of(context).push(MaterialPageRoute(builder: (c)=>VideoPlayFile(file: videoFile!,)));
                   print(videoFile!.path);
                 },child: Text(LocaleKeys.play.tr()),);

                }
              }else{
                if(videoFile==null){

                  return TextButton(onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (c)=>VideoPlayNetwork(path: widget.video,)));
                    print(videoFile!.path);
                  },child: Text(LocaleKeys.play.tr()),);


                }else{

                  return TextButton(onPressed: (){
                    print(videoFile!.path);
                  },child: Text(LocaleKeys.play.tr()),);


                }
              }


            }),
            const SizedBox(
              height: 12,
            ),
            Text(LocaleKeys.videoUpdateStatue.tr()),
            const SizedBox(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  pickVideo().then((value) {
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child:  Center(
                    child: Text(LocaleKeys.editVideo.tr()),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.indigo.withOpacity(0.2)),
                ),
              ),
            ),
            !loading?Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  if(videoFile==null){
                    ScaffoldMessenger.of(context).showSnackBar( SnackBar(content:  Text(LocaleKeys.selectVid.tr())));
                  }else{
                    setState(() {
                      loading = true;
                    });
                    uploadImagetFirebase1(videoFile!.path.toString())
                        .then((value) {
                      FirebaseDatabase.instance
                          .ref('Data')
                          .child(widget.number.toString())
                          .child('video')
                          .set(urlPath);
                      setState(() {
                        loading = false;
                      });
                    }).onError((error, stackTrace) {
                      loading = false;
                    });
                  }
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
            ):const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
  Future<String> uploadImagetFirebase(String videoPath) async {
    await FirebaseStorage.instance
        .ref(videoPath)
        .putFile(File(videoPath))
        .then((taskSnapshot) {
      print('steve');
      print(taskSnapshot.state.name);
      print(taskSnapshot.state);

      if (taskSnapshot.state == TaskState.success) {
        FirebaseStorage.instance.ref(videoPath).getDownloadURL().then((value) {
          setState(() {
            url = value;
          });
        }).onError((onError, s) {
          print('steve errorr' + onError.toString()+s.toString());
        });
      }
    });
    setState(() {
      urlPath=url;
    });
    print('url' + urlPath);
    return urlPath;
  }
  Future<String> uploadImagetFirebase1(String videoPath) async {
    await FirebaseStorage.instance
        .ref(videoPath)
        .putFile(File(videoPath))
        .then((taskSnapshot) {
      print('steve');
      print(taskSnapshot.state.name);
      print(taskSnapshot.state);
      FirebaseStorage.instance.ref(videoPath).getDownloadURL().then((value) {
        setState(() {
          url = value;
        });
        FirebaseDatabase.instance
            .ref('Data')
            .child(widget.number.toString())
            .child('video')
            .set(url)
            .then((value) => Navigator.pop(context));
      }).onError((onError, s) {
        print('steve error0000' + onError.toString());
      });
    });
    return url;
  }

}
