import 'package:emrergency/consts/AppColors.dart';
import 'package:emrergency/consts/AppStrings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'finalAuthScreen.dart';

class MoreInfoScreen extends StatefulWidget {
  MoreInfoScreen({super.key,required this.name,required this.firstName,required this.residence,required this.dateOfBirth,required this.contact1});
  String name,firstName,dateOfBirth,residence,contact1;

  @override
  State<MoreInfoScreen> createState() => _MoreInfoScreenState();
}

class _MoreInfoScreenState extends State<MoreInfoScreen> {
  bool visibility=true;
  final _formKey=GlobalKey<FormState>();
  TextEditingController professionController=TextEditingController();
  TextEditingController maritalStatusController=TextEditingController();
  TextEditingController childrenController=TextEditingController();
  TextEditingController contact2Controller=TextEditingController();
  TextEditingController emailAddressController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: AppColors.blackColor,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 20,),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(right: 20),
                  child: Text(AppStrings.beMoreSpecificIts,
                    style: const TextStyle(color: AppColors.darkRedColor,
                        fontWeight: FontWeight.bold,fontSize: 20),),
                ),
                const SizedBox(height: 20,),
                textBox(text: AppStrings.profession, label: AppStrings.profession, icon: Icons.account_box_outlined, textVisibility: true, type: TextInputType.text, controller: professionController),
                textBox(text: AppStrings.maritalStatus, label: AppStrings.maritalStatus, icon: Icons.male, textVisibility: true, type: TextInputType.text, controller: maritalStatusController),
                textBox(text: AppStrings.childrenNumber, label: AppStrings.childrenNumber, icon: Icons.child_care, textVisibility: true, type: TextInputType.text, controller: childrenController),
                textBox(text: AppStrings.contact2, label: AppStrings.contact2, icon: Icons.phone, textVisibility: true, type: TextInputType.text, controller: contact2Controller),
                textBox(text: AppStrings.mailAddress, label: AppStrings.mailAddress, icon: Icons.email, textVisibility: true, type: TextInputType.text, controller: emailAddressController),
                InkWell(
                  onTap: (){
                    if(_formKey.currentState!.validate()){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>FinalAuthScreen(name: widget.name, firstName: widget.firstName, residence: widget.residence, dateOfBirth: widget.dateOfBirth, contact1: widget.contact1, profession: professionController.text, maritalStatus: maritalStatusController.text, childeren: childrenController.text, emailAddress: emailAddressController.text, contact: contact2Controller.text,)));
                    }
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
      ),
    ));
  }
  Widget textBox({
    required String text,
    required String label,
    required IconData icon,
    required bool textVisibility,
    required TextInputType type,
    required TextEditingController controller
  }) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: TextFormField(
        controller: controller,
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
