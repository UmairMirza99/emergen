import 'package:emrergency/DashboardScreen.dart';
import 'package:emrergency/Model/RegistrationModel.dart';
import 'package:emrergency/consts/AppColors.dart';
import 'package:emrergency/consts/AppStrings.dart';
import 'package:emrergency/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

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
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(color: AppColors.whiteColor),
                child:PrettyQrView.data(
                  data: firebaseAuth.currentUser!.uid,
                  decoration: const PrettyQrDecoration(
                    image: PrettyQrDecorationImage(
                      image: AssetImage('images/flutter.png'),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(right: 20),
                child: Text(AppStrings.lastScreenBottomText,
                  style: const TextStyle(color: AppColors.whiteColor,
                      fontWeight: FontWeight.bold,fontSize: 14),),
              ),
const SizedBox(height: 20,),
InkWell(
  onTap: (){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>DashboardScreens()), (route) => false);
  },
  child: Container(
    alignment: Alignment.centerRight,
    height: 50,child: Container(
    alignment: Alignment.center,
    width: 80,decoration: BoxDecoration(color: AppColors.darkRedColor,borderRadius: BorderRadius.circular(5)),child: Icon(Icons.arrow_forward,color: AppColors.whiteColor,size: 25,),),),
)
            ],)
      ),
    ));
  }
}
