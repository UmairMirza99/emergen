import 'dart:convert';
import 'dart:io';
import 'package:emrergency/DashboardScreen.dart';
import 'package:emrergency/Model/SignalorModel.dart';
import 'package:emrergency/consts/AppColors.dart';
import 'package:emrergency/consts/AppStrings.dart';
import 'package:emrergency/consts/GlobalFunction.dart';
import 'package:emrergency/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class FinalResult extends StatefulWidget {
  FinalResult({super.key,required this.video,required this.yearController,required this.sizeMController,required this.placeOfResidenceController,required this.approximateAgeController,required this.nickNameController,required this.message,required this.urgent,required this.file});
  String nickNameController,approximateAgeController,placeOfResidenceController,sizeMController,yearController,message;
  XFile file;
  bool urgent,video;

  @override
  State<FinalResult> createState() => _FinalResultState();
}

class _FinalResultState extends State<FinalResult> {
  bool loading=false;
  var paymentIntent;
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: AppColors.blackColor,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          const SizedBox(height: 50,),
          Text(AppStrings.finalResulScreenTop,style: const TextStyle(color: AppColors.blueColor,fontSize: 16,fontWeight: FontWeight.bold),),
          const SizedBox(height: 50,),
          Container(
              alignment: Alignment.centerLeft,
              child: Text(AppStrings.avidence,style: const TextStyle(color: AppColors.darkRedColor,fontSize: 16,fontWeight: FontWeight.bold),)),
          Container(
            height: 200,
            child: Row(children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(image:
                  widget.file!=null?
                  widget.video!=true?
                  DecorationImage(image: FileImage(File(widget.file.path))):null:null,),
                  child:
                  widget.file!=null?
                  widget.video?
                  const Icon(Icons.video_camera_back,color: AppColors.darkRedColor,size: 35,):
                  const SizedBox()
                      :
                  const Text('+ Photo/Video',style: TextStyle(color: AppColors.blueColor,fontWeight: FontWeight.bold),),
                ),
              ),
              Expanded(child: Container(
                margin: const EdgeInsets.all(5),
                color: Colors.white,
              )),
            ],),
          ),
          const SizedBox(height: 10,),
          Container(
              alignment: Alignment.topLeft,
              child: Text(AppStrings.bottomText,style: const TextStyle(color: AppColors.darkRedColor,fontWeight: FontWeight.bold),)),
          const SizedBox(height: 30,),
          InkWell(
            onTap: () async {
              makePayment();

              /// Uploading Data Function Without stripe run here
             // try{
             //   setState(() {
             //     loading=true;
             //   });
             //   await uploadImageToFirebaseStorage(imageFile: File(widget.file.path),
             //       folderName: 'injuryImages', imageName: widget.file.name).then((value){
             //     String uid=firestore.collection('Signaler').id;
             //     SignalorModel model=SignalorModel(
             //         uid: uid,
             //         nickName: widget.nickNameController,
             //         approximateAge: widget.approximateAgeController,
             //         placeOfResidence: widget.placeOfResidenceController,
             //         sizeM: widget.sizeMController,
             //         year: widget.yearController,
             //         message: widget.message, path: value ?? '', payment: 'false', urgent: widget.urgent
             //     );
             //     firestore.collection('Signaler').doc(uid).set(
             //         model.toJson()
             //     ).then((value){
             //       setState(() {
             //         loading=false;
             //       });
             //       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const DashboardScreens()), (route) => false);
             //       Fluttertoast.showToast(msg: 'Submitted');
             //     });
             //   });
             // }catch(e){
             //   setState(() {
             //     loading=false;
             //   });
             //   Fluttertoast.showToast(msg: e.toString());
             // }
            },
            child: Container(
              alignment: Alignment.center,
              height: 50,
              decoration: BoxDecoration(color: AppColors.darkRedColor,borderRadius: BorderRadius.circular(10)),
              child:
                  loading?
                      const CircularProgressIndicator(color: AppColors.whiteColor,):
              const Text('Submit',style: TextStyle(color: AppColors.whiteColor,fontWeight: FontWeight.bold),),
            ),
          ),
          SizedBox(height: 50,),
          // InkWell(
              // onTap: (){
              //   print('yes');
              //   makePayment();
              // },
              // child: Container(height: 20,color: Colors.red,))
        ],),
      ),
    ),);
  }
  Future<void> makePayment() async {
    try {
      // STEP 1: Create Payment Intent
      paymentIntent = await createPaymentIntent('100', 'USD');

      // STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          style: ThemeMode.light,
          merchantDisplayName: 'Your Merchant Name',
        ),
      )
          .then((value) {
        print(value);
      });

      // STEP 3: Display Payment sheet
      displayPaymentSheet();
    } catch (err) {
      throw Exception(err.toString());
    }
  }
  createPaymentIntent(String amount, String currency) async {
    try {
      // Request body
      Map<String, dynamic> body = {
        'amount': '10',
        'currency': currency,
      };

      // Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer your_secret_key', // Replace with your actual test secret key
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }
  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 100.0,
                  ),
                  SizedBox(height: 10.0),
                  Text("Payment Successful!"),
                ],
              ),
            ));

        paymentIntent = null;
      }).onError((error, stackTrace) {
        throw Exception(error);
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      const AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                Text("Payment Failed"),
              ],
            ),
          ],
        ),
      );
    } catch (e) {
      print('$e');
    }
  }
}
