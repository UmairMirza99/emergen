import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<bool> checkUserConnection() async {
  bool activeConnection = false;
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      activeConnection = true;
    }
  } on SocketException catch (_) {
    activeConnection = false;
  }
  return activeConnection;
}

Future<String?> uploadImageToFirebaseStorage({
  required File imageFile,
  required String folderName,
  required String imageName,
}) async {
  try {
    // Create a unique path for the image in the storage bucket
    String imagePath = '$folderName/$imageName';

    // Reference to the Firebase Storage bucket
    Reference storageReference = FirebaseStorage.instance.ref().child(imagePath);

    // Upload the image to Firebase Storage
    UploadTask uploadTask = storageReference.putFile(imageFile);

    // Wait for the upload to complete
    await uploadTask.whenComplete(() => null);

    // Get the download URL
    String downloadUrl = await storageReference.getDownloadURL();

    // Return the download URL
    return downloadUrl;
  } catch (e) {
    Fluttertoast.showToast(msg: 'Error uploading image.');
    print('Error uploading image: $e');
    return null;
  }
}

