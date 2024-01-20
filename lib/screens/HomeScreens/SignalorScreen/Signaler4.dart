import 'package:emrergency/consts/AppColors.dart';
import 'package:emrergency/consts/AppStrings.dart';
import 'package:emrergency/screens/HomeScreens/SignalorScreen/FinalResult.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Signaler4 extends StatefulWidget {
  const Signaler4({super.key});

  @override
  State<Signaler4> createState() => _Signaler4State();
}

class _Signaler4State extends State<Signaler4> {
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
                child: Container(
                  margin: const EdgeInsets.all(5),
                  alignment: Alignment.center,
                  child: const Text('+ Photo/Video',style: TextStyle(color: AppColors.blueColor,fontWeight: FontWeight.bold),),
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
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const FinalResult()));
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
}
