import 'dart:async';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_museum/lan/locale_keys.g.dart';
import 'package:video_player/video_player.dart';
import 'package:easy_localization/easy_localization.dart';
import 'VideoUpdate.dart';
import 'image_update.dart';

class ViewData extends StatefulWidget {
  const ViewData({Key? key, required this.number}) : super(key: key);

  final String number;

  @override
  _ViewDataState createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  String num = '0';
  String description = '';
  String image = '';
  String video = '';

  bool isVideo = false;

  VideoPlayerController? _controller;
  VideoPlayerController? _toBeDisposed;

  final ImagePicker _picker = ImagePicker();
  final TextEditingController descController = TextEditingController();
  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();

  Future<void> _playVideo(XFile? file) async {
    if (file != null && mounted) {
      await _disposeVideoController();
      late VideoPlayerController controller;
      if (kIsWeb) {
        controller = VideoPlayerController.network(file.path);
      } else {
        controller = VideoPlayerController.file(File(file.path));
      }
      _controller = controller;
      const double volume = kIsWeb ? 0.0 : 1.0;
      await controller.setVolume(volume);
      await controller.initialize();
      await controller.setLooping(true);
      await controller.play();
      setState(() {});
    }
  }

  Future<void> _onImageButtonPressed(ImageSource source,
      {BuildContext? context, bool isMultiImage = false}) async {
    if (_controller != null) {
      await _controller!.setVolume(0.0);
    }
    if (isVideo) {
      final XFile? file = await _picker.pickVideo(
          source: source, maxDuration: const Duration(seconds: 10));
      await _playVideo(file);
    } else if (isMultiImage) {}
  }

  @override
  void deactivate() {
    if (_controller != null) {
      _controller!.setVolume(0.0);
      _controller!.pause();
    }
    super.deactivate();
  }

  @override
  void dispose() {
    _disposeVideoController();
    maxWidthController.dispose();
    maxHeightController.dispose();
    super.dispose();
  }

  Future<void> _disposeVideoController() async {
    if (_toBeDisposed != null) {
      await _toBeDisposed!.dispose();
    }
    _toBeDisposed = _controller;
    _controller = null;
  }

  int textLength = 0;

  final picker = ImagePicker();
  File? videoFile;

  Future<String> pickVideo() async {
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    setState(() {
      videoFile = File(pickedFile!.path);
    });
    return pickedFile!.path;
  }

  @override
  void initState() {
    getData();
    num = widget.number.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.indigo,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(LocaleKeys.editstatue.tr()),
      ),
      body: SingleChildScrollView(
        child: Column(
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
                  LocaleKeys.editstatue.tr() + "  " + num,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                ),
                const SizedBox(
                  width: 12,
                ),
              ],
            ),
            const SizedBox(
              height: 22,
            ),
            InkWell(
              onTap: () {
                FirebaseDatabase database = FirebaseDatabase.instance;
                database
                    .ref('Data')
                    .child(widget.number.toString())
                    .child('video')
                    .get()
                    .then((value) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (c) => VideoUpdate(
                            number: int.parse(
                              widget.number,
                            ),
                            video: value.value.toString(),
                          )));
                });
              },
              child: Container(
                  decoration: const BoxDecoration(
                      color: Color(0xfff6f5f8),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
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
                              color: const Color(0xffe9793d).withOpacity(0.1),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: const Center(
                              child: Icon(Icons.video_file,
                                  color: Color(0xffe9793d), size: 22)),
                        ),
                        const SizedBox(width: 20),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Text(
                                LocaleKeys.video.tr(),
                                style: const TextStyle(
                                    color: Colors.grey, fontFamily: 'steve'),
                              ),
                              Text(LocaleKeys.edit.tr(),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'steve',
                                      fontWeight: FontWeight.bold))
                            ])
                      ])),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                FirebaseDatabase.instance
                    .ref('Data')
                    .child(int.parse(widget.number).toString())
                    .child('image')
                    .get()
                    .then((value) {
                  print(value.value);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (c) => ImageUpdate(
                            number: int.parse(widget.number),
                            image: value.value.toString(),
                          )));
                });
              },
              child: Container(
                  decoration: const BoxDecoration(
                      color: Color(0xfff6f5f8),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
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
                              color: Colors.green.withOpacity(0.1),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: const Center(
                              child: Icon(Icons.image,
                                  color: Colors.green, size: 22)),
                        ),
                        const SizedBox(width: 20),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:  [
                              Text(
                            LocaleKeys.image.tr(),

                                style: const TextStyle(
                                    color: Colors.grey, fontFamily: 'steve'),
                              ),
                              Text(LocaleKeys.edit.tr(),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'steve',
                                      fontWeight: FontWeight.bold))
                            ])
                      ])),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        LocaleKeys.editstatue.tr() + "  "
                        + num +  "   " +  LocaleKeys.description.tr(),
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 14),
                      ),
                      content: TextFormField(
                        textInputAction: TextInputAction.done,
                        controller: descController,
                        onChanged: (value) {
                          setState(() {
                            textLength = value.length;
                          });
                        },
                        keyboardType: TextInputType.emailAddress,
                        autofocus: false,
                        decoration: InputDecoration(
                          suffixIcon: textLength > 0
                              ? const Icon(
                                  Icons.check_circle,
                                  color: Colors.indigo,
                                )
                              : const Icon(
                                  Icons.info_outline,
                                  color: Colors.grey,
                                ),
                          hintText: LocaleKeys.description.tr(),
                          contentPadding:
                              const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(
                                color: Colors.grey[900]!, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 1.0),
                          ),
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            FirebaseDatabase.instance
                                .ref('Data')
                                .child(widget.number.toString())
                                .child('description')
                                .set(descController.text);
                            setState(() {
                              description = descController.text;
                            });
                            Navigator.pop(context);
                          },
                          child: const Text('Save'),
                        ),
                      ],
                      semanticLabel: 'asda',
                    );
                  },
                );
              },
              child: Container(
                  decoration: const BoxDecoration(
                      color: Color(0xfff6f5f8),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
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
                              color: Colors.blue.withOpacity(0.1),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: const Center(
                              child: Icon(Icons.info_outline,
                                  color: Colors.blue, size: 22)),
                        ),
                        const SizedBox(width: 20),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Text(
                                LocaleKeys.description.tr(),
                                style: const TextStyle(
                                    color: Colors.grey, fontFamily: 'steve'),
                              ),
                              Builder(builder: (context) {
                                return Text(description,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'steve',
                                        fontWeight: FontWeight.bold));
                              })
                            ])
                      ])),
            ),
            const SizedBox(
              height: 10,
            ),
            // InkWell(
            //   onTap: (){
            //     uploadImagetFirebase(image_path).then((value) {
            //       Future.delayed(const Duration(seconds: 1), () {
            //         FirebaseDatabase.instance
            //             .ref('Data').child(widget.number.toString()).child('image')
            //             .set(value).then((value) {
            //           ScaffoldMessenger.of(context)
            //               .showSnackBar(const SnackBar(
            //               content:
            //               Text('Statue Data updated!')));
            //           Navigator.pop(context);
            //         });
            //       });
            //     }).onError((error, stackTrace) {
            //       ScaffoldMessenger.of(context)
            //           .showSnackBar(const SnackBar(
            //           content: Text(
            //               'Oups, something went wrong, please try again')));
            //     });
            //
            //     uploadImagetFirebase(video_path).then((value) {
            //       Future.delayed(const Duration(seconds:1), () {
            //         print('' + value);
            //         FirebaseDatabase.instance
            //             .ref('Data').child(widget.number.toString()).child('video')
            //             .set(value).then((value) {
            //           ScaffoldMessenger.of(context)
            //               .showSnackBar(const SnackBar(
            //               content:
            //               Text('Statue Data updated!')));
            //           Navigator.pop(context);
            //         });
            //       });
            //     }).onError((error, stackTrace) {
            //       ScaffoldMessenger.of(context)
            //           .showSnackBar(const SnackBar(
            //           content: Text(
            //               'Oups, something went wrong, please try again')));
            //     });
            //   },
            //   child: Container(
            //     margin: EdgeInsets.all(22),
            //     width: MediaQuery.of(context).size.width,
            //     height: 50,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(12),
            //       color: Colors.indigo
            //     ),
            //     child: Center(
            //       child: Text('Save',style: TextStyle(
            //         color: Colors.white
            //       ),),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    ));
  }

  Future<String> getData() async {
    FirebaseDatabase.instance
        .ref('Data')
        .child(widget.number.toString())
        .child('description')
        .get()
        .then((value) {
      setState(() {
        description = value.value.toString();
        descController.text = description.toString();
      });
    });

    return description;
  }
}
