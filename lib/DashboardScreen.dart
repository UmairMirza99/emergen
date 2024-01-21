import 'package:emrergency/screens/HomeScreens/PlaintScreen/PlaintScreen.dart';
import 'package:emrergency/screens/HomeScreens/SignalorScreen/HomeScreen.dart';
import 'package:emrergency/screens/HomeScreens/Suivi_Du/Suivi1Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'consts/AppColors.dart';
import 'consts/AppStrings.dart';

class DashboardScreens extends StatefulWidget {
   const DashboardScreens({super.key});
  @override
  State<DashboardScreens> createState() => _DashboardScreensState();
}

class _DashboardScreensState extends State<DashboardScreens> {
  Widget screen=const HomeScreen();
  int currentIndex=0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.blackColor,
        appBar: AppBar(
          backgroundColor: AppColors.blackColor,
          leading: const Icon(Icons.menu,color: AppColors.blueColor,),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(children: [
            Container(height: 60,
              color: Colors.white,
              child: Row(children: [
                Expanded(
                  flex:5,
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        currentIndex=0;
                        screen=const HomeScreen();
                      });
                    },
                    child: Container(
                      color:currentIndex==0?AppColors.blueColor:AppColors.whiteColor,
                      alignment: Alignment.center,
                      child: Center(child: Text(AppStrings.report,style:  TextStyle(color: currentIndex==0?AppColors.whiteColor:AppColors.blueColor,fontWeight: FontWeight.bold,fontSize: 16),),),
                    ),
                  ),
                ),
                Expanded(
                  flex:5,
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        currentIndex=1;
                        screen=const PlainScreen();
                      });
                    },
                    child: Container(
                      color: currentIndex==1?AppColors.blueColor:AppColors.whiteColor,
                      alignment: Alignment.center,
                      child: Center(child: Text(AppStrings.complaints,style:  TextStyle(color: currentIndex==1?AppColors.whiteColor:AppColors.blueColor,fontWeight: FontWeight.bold,fontSize: 16),),),
                    ),
                  ),
                ),
                Expanded(
                  flex:5,
                  child:InkWell(
                    onTap: (){
                      setState(() {
                        currentIndex=2;
                        screen=const Suivi1Screen();
                      });
                    },
                    child: Container(
                      color: currentIndex==2?AppColors.blueColor:AppColors.whiteColor,
                      alignment: Alignment.center,
                      child: Center(child: Text(AppStrings.managingProject,style:  TextStyle(color: currentIndex==2?AppColors.whiteColor:AppColors.blueColor,fontWeight: FontWeight.bold,fontSize: 16),),),
                    ),
                  ),
                ),
              ],),
            ),
            Expanded(child: screen)
          ],),
        ),
      ),
    );
  }
}
