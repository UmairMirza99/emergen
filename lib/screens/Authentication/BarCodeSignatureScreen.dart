import 'package:emrergency/consts/AppColors.dart';
import 'package:emrergency/consts/AppStrings.dart';
import 'package:flutter/material.dart';

class BarCodeSignatureScreen extends StatefulWidget {
  const BarCodeSignatureScreen({super.key});

  @override
  State<BarCodeSignatureScreen> createState() => _BarCodeSignatureScreenState();
}

class _BarCodeSignatureScreenState extends State<BarCodeSignatureScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: AppColors.blackColor,
      body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(right: 20),
                child: Text(AppStrings.barcodeSignature,
                  style: const TextStyle(color: AppColors.darkRedColor,
                      fontWeight: FontWeight.bold,fontSize: 20),),
              ),
              const SizedBox(height: 20,),
              Container(
                height: 200,
                width: 200,
                decoration: const BoxDecoration(color: AppColors.whiteColor),
              ),
              SizedBox(height: 20,),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(right: 20),
                child: Text(AppStrings.lastScreenBottomText,
                  style: const TextStyle(color: AppColors.darkRedColor,
                      fontWeight: FontWeight.bold,fontSize: 14),),
              ),

            ],)
      ),
    ));
  }
}
