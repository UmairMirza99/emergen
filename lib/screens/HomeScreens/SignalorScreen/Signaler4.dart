import 'dart:io';

import 'package:emrergency/Model/SignalorModel.dart';
import 'package:emrergency/consts/AppColors.dart';
import 'package:emrergency/consts/AppStrings.dart';
import 'package:emrergency/consts/GlobalFunction.dart';
import 'package:emrergency/consts/consts.dart';
import 'package:emrergency/screens/HomeScreens/SignalorScreen/FinalResult.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class Signaler4 extends StatefulWidget {
   Signaler4({super.key,required this.yearController,required this.sizeMController,required this.placeOfResidenceController,required this.approximateAgeController,required this.nickNameController,required this.message,required this.urgent});
  String nickNameController,approximateAgeController,placeOfResidenceController,sizeMController,yearController,message;
  bool urgent;

  @override
  State<Signaler4> createState() => _Signaler4State();
}

class _Signaler4State extends State<Signaler4> {
  XFile? singleMedia;
  bool video=false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: AppColors.blackColor,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          const SizedBox(height: 50,),
          Text(AppStrings.topText,style: const TextStyle(color: AppColors.blueColor,fontSize: 16,fontWeight: FontWeight.bold),),
          const SizedBox(height: 50,),
          Container(
              alignment: Alignment.centerLeft,
              child: Text(AppStrings.avidence,style: const TextStyle(color: AppColors.darkRedColor,fontSize: 16,fontWeight: FontWeight.bold),)),
          Container(
            height: 200,
            child: Row(children: [
              Expanded(
                child: InkWell(
                  onTap: (){
                    showDialog(context: context, builder: (context)=>AlertDialog(
                      title: const Text('Source'),
                      content: const Text('Select file source!!'),
                      actions: [
                        TextButton(onPressed: (){
                          pickImageVideo(true);
                        }, child: const Text('Image')),
                        TextButton(onPressed: (){
                          pickImageVideo(false);
                        }, child: const Text('Video')),
                      ],
                    ));
                    },
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(image:
                    singleMedia!=null?
                        video!=true?
                    DecorationImage(image: FileImage(File(singleMedia!.path))):null:null,),
                    child:
                    singleMedia!=null?
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
              final singleMedia = this.singleMedia;
              if(singleMedia!=null){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>FinalResult(yearController:widget.yearController, sizeMController: widget.sizeMController, placeOfResidenceController: widget.placeOfResidenceController, approximateAgeController: widget.approximateAgeController, nickNameController: widget.nickNameController, message: widget.message, urgent:widget.urgent, file: singleMedia, video: video,)), (route) => false);
              }else{Fluttertoast.showToast(msg: 'Please select one image/video.');}
            },
            child: Container(
              alignment: Alignment.center,
              height: 50,
            decoration: BoxDecoration(color: AppColors.darkRedColor,borderRadius: BorderRadius.circular(10)),
              child: const Text('Submit',style: TextStyle(color: AppColors.whiteColor,fontWeight: FontWeight.bold),),
            ),
          ),
        ],),
      ),
    ),);
  }
  pickImageVideo(bool image) async {
    if(image){
     await ImagePicker().pickImage(source: ImageSource.gallery).then((value){
        if(value!=null){
         setState(() {
           video=false;
           singleMedia=value;
         });
         Navigator.pop(context);
        }
      });
    }else{
     await ImagePicker().pickVideo(source: ImageSource.gallery).then((value){
        if(value!=null){
          setState(() {
            video=true;
            singleMedia=value;
          });
          Navigator.pop(context);
        }
      });
    }

  }
}
