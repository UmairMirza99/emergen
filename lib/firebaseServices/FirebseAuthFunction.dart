import 'package:emrergency/Model/RegistrationModel.dart';
import 'package:emrergency/screens/Authentication/BarCodeSignatureScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../consts/consts.dart';

class FirebaseAuthentication{
  Future<UserCredential?> signupMethod({
    required RegistrationModel data,
    required BuildContext context
  }) async {
    UserCredential? userCredential;
    try {
      userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: data.emailAddress,
        password: data.password,
      ).then((value) async {
        currentUser=value.user;
        if (value.user!.uid.isNotEmpty){
          await storeUserData(model:data, context: context).then((value) {
            Fluttertoast.showToast(msg: "Account has been created");
          });
          // here go tp another screen
        }
      });
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message.toString());
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
    return userCredential;
  }
  Future storeUserData({required RegistrationModel model,required BuildContext context
  }) async {
    String uid=firestore.collection(userCollection).id;
    await firestore.collection(userCollection).doc(uid).set(
        {
          'name': model.name,
          'firstName': model.firstName,
          'dateOfBirth': model.dateOfBirth,
          'placeOfResidence': model.placeOfResidence,
          'contact1': model.contact1,
          'profession': model.profession,
          'maritalStatus': model.maritalStatus,
          'childrenNumber': model.childrenNumber,
          'contact2': model.contact2,
          'emailAddress': model.emailAddress,
          'password': model.password,
          'confirmPassword': model.confirmPassword,
          'signature': model.signature,
          'uid': uid,
          'block': model.block,
          'qrCode':model.qrCode
        }
    )
    .then((value) {
      Fluttertoast.showToast(msg: 'Register successfully.');
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>  BarCodeSignatureScreen()), (route) => false).then((value){
        FirebaseAuth.instance.signOut();
      });
    });
  }


}