import 'package:emrergency/consts/AppColors.dart';
import 'package:emrergency/consts/AppStrings.dart';
import 'package:emrergency/screens/HomeScreens/SignalorScreen/Signaler4.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Signalor3Screen extends StatefulWidget {
  const Signalor3Screen({super.key});

  @override
  State<Signalor3Screen> createState() => _Signalor3ScreenState();
}

class _Signalor3ScreenState extends State<Signalor3Screen> {
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
              const SizedBox(height: 20,),
              Text(AppStrings.centerText,style: const TextStyle(color: AppColors.darkRedColor,fontWeight: FontWeight.bold,fontSize: 17),),
              const SizedBox(height: 20,),
              textBox(text: '', label: AppStrings.year, icon: Icons.send, textVisibility: true, type: TextInputType.text),
              const SizedBox(height: 20,),
              Container(
                  alignment: Alignment.centerLeft,
                  child: const Text('Urgent?',style: TextStyle(color: AppColors.darkRedColor,fontWeight: FontWeight.bold,fontSize: 16),)),
              const SizedBox(
                height: 50,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Text('Oui',style: TextStyle(color: AppColors.blueColor),),
                    Checkbox(value: true, onChanged: (change){

                    })
                  ],),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Text('Non',style: TextStyle(color: AppColors.blueColor),),
                    Checkbox(value: true, onChanged: (change){

                    })
                  ],),
                ],),
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
              : InkWell(
            onTap: (){
              if(text==''){
Navigator.push(context, MaterialPageRoute(builder: (context)=>const Signaler4()));
              }
            },
              child: Icon( icon)),
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
