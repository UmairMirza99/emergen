class RegistrationModel {
  String name,
      firstName,
      dateOfBirth,
      placeOfResidence,
      contact1,
      profession,
      maritalStatus,
      childrenNumber,
      contact2,
      emailAddress,
      password,
      confirmPassword,
      signature,
  qrCode,
      uid;
  bool block=false;

  RegistrationModel(
      {required this.name,
        required this.firstName,
        required this.dateOfBirth,
        required this.placeOfResidence,
        required this.contact1,
        required this.profession,
        required this.maritalStatus,
        required this.childrenNumber,
        required this.contact2,
        required this.emailAddress,
        required this.password,
        required this.confirmPassword,
        required this.signature,
        required this.uid,
        required this.qrCode,
        required this.block});

  factory RegistrationModel.fromJson(Map<String, dynamic> json) {
    return RegistrationModel(
        name: json['name'],
        firstName: json['firstName'],
        dateOfBirth: json['dateOfBirth'],
        placeOfResidence: json['placeOfResidence'],
        contact1: json['contact1'],
        profession: json['profession'],
        maritalStatus: json['maritalStatus'],
        childrenNumber: json['childrenNumber'],
        contact2: json['contact2'],
        emailAddress: json['emailAddress'],
        password: json['password'],
        confirmPassword: json['confirmPassword'],
        signature: json['signature'],
        uid: json['uid'],
        block: json['block'], qrCode: json['qrCode']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'firstName': firstName,
      'dateOfBirth': dateOfBirth,
      'placeOfResidence': placeOfResidence,
      'contact1': contact1,
      'profession': profession,
      'maritalStatus': maritalStatus,
      'childrenNumber': childrenNumber,
      'contact2': contact2,
      'emailAddress': emailAddress,
      'password': password,
      'confirmPassword': confirmPassword,
      'signature': signature,
      'uid': uid,
      'block': block,
      'qrCode':qrCode
    };
  }
}
