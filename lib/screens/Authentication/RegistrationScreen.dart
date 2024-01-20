import 'package:emrergency/consts/AppColors.dart';
import 'package:emrergency/consts/AppStrings.dart';
import 'package:emrergency/screens/Authentication/MoreInfoScreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool visibility=true;
  final _formKey=GlobalKey<FormState>();
  DateTime selectedDateTime=DateTime.now();
  TextEditingController nameController=TextEditingController();
  TextEditingController firstNameController=TextEditingController();
  TextEditingController dateOfBirthController=TextEditingController();
  TextEditingController residenceController=TextEditingController();
  TextEditingController contact1Controller=TextEditingController();

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
                margin: const EdgeInsets.only(right: 20),
                child: Text(AppStrings.enterVerifiableInformation,
                  style: const TextStyle(color: AppColors.darkRedColor,
                      fontWeight: FontWeight.bold,fontSize: 18),),
              ),
              const SizedBox(height: 20,),
              textBox(text: AppStrings.name, label: AppStrings.name, icon: Icons.person, textVisibility: true, controller:nameController),
              textBox(text: AppStrings.firstName, label: AppStrings.firstName, icon: Icons.person, textVisibility: true, controller:firstNameController),
              InkWell(
                 onTap: (){
                   _selectDateTime(context);
                 },
                  child: textBox(text: AppStrings.dateOfBirth, label: AppStrings.dateOfBirth, icon: Icons.date_range, textVisibility: false, controller:dateOfBirthController)),
              textBox(text: AppStrings.placeOfResidence, label: AppStrings.placeOfResidence, icon: Icons.home, textVisibility: true, controller:residenceController),
              textBox(text: AppStrings.contact1, label: AppStrings.contact1, icon: Icons.phone, textVisibility: true, controller: contact1Controller),
              InkWell(
                onTap: (){
                 if(_formKey.currentState!.validate()){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>MoreInfoScreen(name: nameController.text, firstName: firstNameController.text, residence: residenceController.text, dateOfBirth: dateOfBirthController.text, contact1: contact1Controller.text,)));
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
    required TextEditingController controller,
    required String text,
    required String label,
    required IconData icon,
    required bool textVisibility,
  }) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: TextFormField(
        controller: controller,
        autofocus: false,
        enabled: textVisibility,
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

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDateTime,
      firstDate: DateTime(1955),
      lastDate: DateTime(2101),
    ).then((value){
      dateOfBirthController.text=DateFormat('yyyy-MM-dd').format(value!.toLocal());
    });
    if (picked != null && picked != selectedDateTime) {
      final TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDateTime),
      );
      if (selectedTime != null) {
        setState(() {
          selectedDateTime = DateTime(picked.year, picked.month, picked.day, selectedTime.hour, selectedTime.minute);
        });
      }
    }
  }


}
