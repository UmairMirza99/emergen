import 'package:emrergency/consts/AppColors.dart';
import 'package:emrergency/consts/AppStrings.dart';
import 'package:emrergency/screens/HomeScreens/SignalorScreen/signalerScreen3.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Signalor2Screen extends StatefulWidget {
  const Signalor2Screen({super.key});

  @override
  State<Signalor2Screen> createState() => _Signalor2ScreenState();
}

class _Signalor2ScreenState extends State<Signalor2Screen> {
  bool visibility=true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: AppColors.blackColor,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 20,),
              const SizedBox(height: 20,),
              textBox(text: AppStrings.nameOrNickName, label: AppStrings.nameOrNickName, icon: Icons.person, textVisibility: true, type: TextInputType.text),
              textBox(text: AppStrings.approximateAge, label: AppStrings.approximateAge, icon: Icons.date_range, textVisibility: true, type: TextInputType.text),
              textBox(text: AppStrings.placeOfResidence, label: AppStrings.placeOfResidence, icon: Icons.home, textVisibility: true, type: TextInputType.text),
              textBox(text: AppStrings.sizeM, label: AppStrings.sizeM, icon: Icons.format_size, textVisibility: true, type: TextInputType.text),
              textBox(text: AppStrings.year, label: AppStrings.year, icon: Icons.countertops_outlined, textVisibility: true, type: TextInputType.text),
              const SizedBox(height: 20,),
              InkWell(
                onTap: (){
Navigator.push(context, MaterialPageRoute(builder: (context)=>const Signalor3Screen()));
                },
                child: Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width/2,
                  height: 50,decoration: const BoxDecoration(color:AppColors.darkRedColor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(),
                      Text(AppStrings.following,style: const TextStyle(color: AppColors.whiteColor,fontWeight: FontWeight.bold),),
                      const Icon(Icons.arrow_forward_ios,color: AppColors.whiteColor,size: 18,)
                    ],
                  ),
                ),
              ),
            ],),
        ),
      ),
    ));
  }
  Widget textBox({
    required String text,
    required String label,
    required IconData icon,
    required bool textVisibility,
    required TextInputType type,
  }) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: TextFormField(
        autofocus: false,
        keyboardType: type,
        validator: (value) {
          if (value!.length < 1) {
            return '$label missing';
          }
        },
        obscureText:label==AppStrings.passwords? visibility:false,
        // obscureText: showPassword,
        decoration: InputDecoration(
          suffixIcon: label == AppStrings.passwords
              ? InkWell(
              onTap: () {
                if(visibility){
                  setState(() {
                    visibility=false;
                  });
                }else{
                  setState(() {
                    visibility=true;
                  });
                }
              },
              child: Icon(
                  visibility?
                  Icons.visibility_off:Icons.visibility))
              : Icon(icon),
          filled: true,
          fillColor: AppColors.whiteColor,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.blackColor),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: AppColors.darkRedColor),
            borderRadius: BorderRadius.circular(10),
          ),
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
