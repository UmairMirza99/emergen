import 'package:emrergency/consts/AppColors.dart';
import 'package:emrergency/consts/AppStrings.dart';
import 'package:emrergency/DashboardScreen.dart';
import 'package:flutter/material.dart';

import 'SinalerScreen2.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // return LoginScreen();
    return  Scaffold(
      backgroundColor: AppColors.blackColor,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 100,),
          Container(
            alignment: Alignment.center,
            height: 170,
            width: 170,
            decoration: const BoxDecoration(color: AppColors.whiteColor,shape: BoxShape.circle),

          child: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const Signalor2Screen()));
            },
            child: Container(height: 120,width: 120,
              decoration: const BoxDecoration(color: AppColors.darkRedColor,shape: BoxShape.circle),
            ),
          ),
          ),
            const SizedBox(height: 15,),
            Text(AppStrings.buttonBottomText,style: TextStyle(color: AppColors.darkRedColor,fontSize: 15,fontWeight: FontWeight.bold),)
        ],),
      ),
    );
  }
}
