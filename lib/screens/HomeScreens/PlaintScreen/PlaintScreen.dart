import 'dart:io';

import 'package:emrergency/consts/AppStrings.dart';
import 'package:emrergency/consts/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Model/PlaintsModel.dart';
import '../../../consts/AppColors.dart';
import '../../../consts/GlobalFunction.dart';

class PlainScreen extends StatefulWidget {
  const PlainScreen({super.key});

  @override
  State<PlainScreen> createState() => _PlainScreenState();
}

class _PlainScreenState extends State<PlainScreen> {
  XFile? file;
  bool video=false;
  bool loading=false;
TextEditingController messageController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(children: <Widget>[
          Text(AppStrings.plainTopText,style: const TextStyle(color: AppColors.darkRedColor,fontSize: 16),),
          Container(
              alignment: Alignment.centerLeft,
              child: const Icon(Icons.edit_calendar,color: AppColors.whiteColor,)),
          Container(
            child: textBox(text: '', label: '', textVisibility:true, controller: messageController)
          ),
          Container(
              alignment: Alignment.centerLeft,
              child: Text(AppStrings.plainCenterText,style: const TextStyle(color: AppColors.darkRedColor,fontSize: 16),)),
          const SizedBox(height: 10,),
          SizedBox(
            height: 150,
            child: Row(children: [
              Expanded(
                child: InkWell(
                  onTap: (){

                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: const Text('Source'),
                                    content: const Text('Select file source!!'),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            pickImageVideo(true);
                                          },
                                          child: const Text('Image')),
                                      TextButton(
                                          onPressed: () {
                                            pickImageVideo(false);
                                          },
                                          child: const Text('Video')),
                                    ],
                                  ));

                      },
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(image:
                    file!=null?
                    video!=true?
                    DecorationImage(image: FileImage(File(file!.path))):null:null,),
                    child:
                    file!=null?
                    video?
                    const Icon(Icons.video_camera_back,color: AppColors.darkRedColor,size: 35,):
                    const SizedBox()
                        :
                    const Text('+ Photo/Video',style: TextStyle(color: AppColors.blueColor,fontWeight: FontWeight.bold),),
                  ),
                ),
              ),
              Expanded(child: Container(
                margin: const EdgeInsets.all(5),
                color: Colors.white,
              )),
            ],),

          ),
          const SizedBox(height: 20,),
          InkWell(
            onTap: () async {
              if(messageController.text.isNotEmpty&& file!=null){
                if(loading!=true){
                    try {
                      setState(() {
                        loading = true;
                      });
                      await uploadImageToFirebaseStorage(
                              imageFile: File(file!.path),
                              folderName: 'PlaintsImage',
                              imageName: file!.name)
                          .then((value) {
                        if (value != null) {
                          String uid = firestore.collection('Plaints').id;
                          PlaintsModel model = PlaintsModel(
                              uid: uid,
                              message: messageController.text,
                              path: value,
                              payment: false);
                          firestore
                              .collection('Plaints')
                              .doc(uid)
                              .set(model.toJson()).then((value) {
                                Fluttertoast.showToast(msg: 'Submitted');
                                setState(() {
                                  messageController.text='';
                                  file=null;
                                });
                          });
                        } else {
                          setState(() {
                            loading = false;
                          });
                        }
                      });
                    } catch (e) {
                      setState(() {
                        loading = false;
                      });
                      Fluttertoast.showToast(msg: e.toString());
                    }
                  }else{
                  Fluttertoast.showToast(msg: 'In Process.');
                }
                } else{
                Fluttertoast.showToast(msg: 'Add message and image/video');
              }
            },
            child: Container(
              alignment: Alignment.center,
              height: 50,
              decoration: BoxDecoration(color: AppColors.darkRedColor,borderRadius: BorderRadius.circular(10)),
              child:
              loading?
              const CircularProgressIndicator(color: AppColors.whiteColor,):
              const Text('Envoyez',style: TextStyle(color: AppColors.whiteColor,fontWeight: FontWeight.bold),),
            ),
          ),
          const SizedBox(height: 30,)

        ],),
      ),
    );
  }
  pickImageVideo(bool image) async {
    if(image){
      await ImagePicker().pickImage(source: ImageSource.gallery).then((value){
        if(value!=null){
          setState(() {
            video=false;
            file=value;
          });
          Navigator.pop(context);
        }
      });
    }else{
      await ImagePicker().pickVideo(source: ImageSource.gallery).then((value){
        if(value!=null){
          setState(() {
            video=true;
            file=value;
          });
          Navigator.pop(context);
        }
      });
    }

  }

  Widget textBox({
    required String text,
    required String label,
    required bool textVisibility,
    required TextEditingController controller
  }) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: TextFormField(
        controller: controller,
        maxLines: 10,
        autofocus: false,
        style: const TextStyle(color: AppColors.whiteColor),
        validator: (value) {
          if (value!.isEmpty) {
            return '$label missing';
          }
        },
        // obscureText: showPassword,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.blackColor),
            borderRadius: BorderRadius.circular(10),
          ),
            border: InputBorder.none,
          // enabledBorder: UnderlineInputBorder(
          //   borderSide: const BorderSide(color: AppColors.darkRedColor),
          //   borderRadius: BorderRadius.circular(10),
          // ),
          label: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.darkRedColor,
            ),
          ),
        ),
      ),
    );
  }
}
