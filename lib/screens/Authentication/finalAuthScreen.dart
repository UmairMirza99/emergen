import 'dart:typed_data';
import 'dart:io';


import 'package:emrergency/Model/RegistrationModel.dart';
import 'package:emrergency/consts/AppColors.dart';
import 'package:emrergency/consts/AppStrings.dart';
import 'package:emrergency/consts/GlobalFunction.dart';
import 'package:emrergency/firebaseServices/FirebseAuthFunction.dart';
import 'package:emrergency/screens/Authentication/BarCodeSignatureScreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';

class FinalAuthScreen extends StatefulWidget {
  FinalAuthScreen({super.key,required this.name,required this.firstName,required this.residence,required this.dateOfBirth,required this.contact1,required this.profession,required this.maritalStatus,required this.childeren,required this.emailAddress,required this.contact});
  String name,firstName,dateOfBirth,residence,contact1,profession,maritalStatus,childeren,contact,emailAddress;
  @override
  State<FinalAuthScreen> createState() => _FinalAuthScreenState();
}

class _FinalAuthScreenState extends State<FinalAuthScreen> {
  bool visibility=true;
  final _formKey=GlobalKey<FormState>();
bool loading=false;
  TextEditingController passwordController=TextEditingController();
  TextEditingController confirmPasswordController=TextEditingController();
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.red,
    exportBackgroundColor: Colors.blue,
  );

// INITIALIZE. RESULT IS A WIDGET, SO IT CAN BE DIRECTLY USED IN BUILD METHOD

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
                  child: Text(AppStrings.itsAlmostOver,
                    style: const TextStyle(color: AppColors.darkRedColor,
                        fontWeight: FontWeight.bold,fontSize: 20),),
                ),
                const SizedBox(height: 20,),
                textBox(text: AppStrings.password, label: AppStrings.password, icon: Icons.lock, textVisibility: false, type: TextInputType.text),
                textBox(text: AppStrings.confirmPassword, label: AppStrings.confirmPassword, icon: Icons.lock, textVisibility: false, type: TextInputType.text),
                const SizedBox(height: 5,),
                Container(
                  margin: const EdgeInsets.only(left:10),
                    alignment: Alignment.centerLeft,
                    child: const Text('Signature',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: AppColors.darkRedColor),)),
                const SizedBox(height: 5,),
                Signature(
                  controller: _controller,
                  width: 300,
                  height: 150,
                  backgroundColor: Colors.lightBlueAccent,
                ),
                const SizedBox(height: 20,),
                InkWell(
                  onTap: () async {
                    if(_formKey.currentState!.validate() && _controller.isNotEmpty ){
                      if(passwordController.text==confirmPasswordController.text){
                       if(loading!=true){
                         try{
                         setState(() {
                           loading=true;
                         });
                         var image = await _controller.toImage();
                        ByteData? data = await image?.toByteData();
                         Uint8List listData = data!.buffer.asUint8List();
                        setState(() {});
                          await uploadImageToFirebaseStorage(
                              imageFile:await convertUint8ListToFile(listData),
                              folderName: 'signatures',
                              imageName:
                              DateTime.now().millisecond.toString())
                              .then((value) {
                            if (value != null) {
                              RegistrationModel model = RegistrationModel(
                                  name: widget.name,
                                  firstName: widget.firstName,
                                  dateOfBirth: widget.dateOfBirth,
                                  placeOfResidence: widget.residence,
                                  contact1: widget.contact1,
                                  profession: widget.profession,
                                  maritalStatus: widget.maritalStatus,
                                  childrenNumber: widget.childeren,
                                  contact2: widget.contact,
                                  emailAddress: widget.emailAddress,
                                  password: passwordController.text,
                                  confirmPassword: confirmPasswordController.text,
                                  signature: value,
                                  uid: '',
                                  qrCode: '',
                                  block: false);
                              FirebaseAuthentication()
                                  .signupMethod(data: model, context: context).then((value){
                                setState(() {
                                  loading=false;
                                });
                              });
                            }
                          });
                       }
                           catch(e){
                             setState(() {
                               loading=false;
                             });
                             print(e);
                         Fluttertoast.showToast(msg: e.toString());
                           }
                       }else{
                         setState(() {
                           loading=false;
                         });
                         //xnnn
                       }
                      }else{
                        setState(() {
                          loading=false;
                        });
                        Fluttertoast.showToast(msg: 'Password not match');
                      }
                    }else{
                      setState(() {
                        loading=false;
                      });
                      Fluttertoast.showToast(msg: 'Empty fields');
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                    height: 50,decoration:  BoxDecoration(color:AppColors.darkRedColor,borderRadius: BorderRadius.circular(10)),
                    child: Center(child:
                    loading?
                        const CircularProgressIndicator(color: AppColors.whiteColor,):
                    Text(AppStrings.following,style: const TextStyle(color: AppColors.whiteColor,fontWeight: FontWeight.bold),)),
                  ),
                ),
              ],),
          ),
        ),
      ),
    ),);
  }
  Future<File> convertUint8ListToFile(Uint8List uint8List) async {
    // Get the app's documents directory
    Directory appDocDir = await getApplicationDocumentsDirectory();

    // Specify the file path where you want to save the file within the app's documents directory
    String filePath = '${appDocDir.path}/${DateTime.now().millisecond.toString()}.png';

    // Create a File object
    File fileImage = File(filePath);

    // Write the Uint8List data to the file
    await fileImage.writeAsBytes(uint8List);
print(filePath);
   return File(filePath);
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
