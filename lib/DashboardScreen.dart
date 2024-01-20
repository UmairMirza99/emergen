import 'package:emrergency/screens/HomeScreens/SignalorScreen/HomeScreen.dart';
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
                  child: Container(
                    alignment: Alignment.center,
                    child: Center(child: Text(AppStrings.report,style: const TextStyle(color: AppColors.blueColor,fontWeight: FontWeight.bold,fontSize: 16),),),
                  ),
                ),
                Expanded(
                  flex:5,
                  child: Container(
                    alignment: Alignment.center,
                    child: Center(child: Text(AppStrings.complaints,style: const TextStyle(color: AppColors.blueColor,fontWeight: FontWeight.bold,fontSize: 16),),),
                  ),
                ),
                Expanded(
                  flex:5,
                  child: Container(
                    alignment: Alignment.center,
                    child: Center(child: Text(AppStrings.managingProject,style: const TextStyle(color: AppColors.blueColor,fontWeight: FontWeight.bold,fontSize: 16),),),
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
