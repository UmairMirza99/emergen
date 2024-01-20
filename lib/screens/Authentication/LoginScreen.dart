import 'package:emrergency/consts/AppColors.dart';
import 'package:emrergency/consts/AppStrings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'RegistrationScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool visibility=true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.blackColor,
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(children: [
              const SizedBox(height: 20,),
              Container(height: 100,width: 100,
              decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('images/logo.png',),fit: BoxFit.cover),color: AppColors.whiteColor),
              ),
              const SizedBox(height: 10,),
              Text(AppStrings.firstNames,style: const TextStyle(color: AppColors.darkRedColor,fontWeight: FontWeight.bold,fontSize: 25),),
              const SizedBox(height: 50,),
              textBox(text: 'Email', label: 'Email', icon: Icons.email, textVisibility: true),
              textBox(text: AppStrings.passwords, label:AppStrings.passwords, icon: Icons.visibility, textVisibility: false),
              const SizedBox(height: 20,),
              Container(
                margin: const EdgeInsets.all(5),
                height: 50,decoration: BoxDecoration(color:AppColors.darkRedColor,borderRadius: BorderRadius.circular(10)),
              child: Center(child: Text(AppStrings.following,style: const TextStyle(color: AppColors.whiteColor,fontWeight: FontWeight.bold),),),
              ),
              const SizedBox(height: 10,),
              InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const RegistrationScreen()));
                  },
                  child: Text(AppStrings.ifYouNotHaveAccount,style: const TextStyle(color: AppColors.whiteColor,fontSize: 12),))
            ],),
          ),
        ),
      ),
    );
  }

  Widget textBox({
    required String text,
    required String label,
    required IconData icon,
    required bool textVisibility,
  }) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: TextFormField(
        autofocus: false,
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
