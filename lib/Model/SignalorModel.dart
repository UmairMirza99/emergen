class SignalorModel{
  String nickName,uid,approximateAge,placeOfResidence,sizeM,year,message,path,payment;
  bool urgent;

  SignalorModel(
      {required this.uid,
      required this.nickName,
      required this.approximateAge,
      required this.placeOfResidence,
      required this.sizeM,
      required this.year,
      required this.message,
      required this.path,
      required this.payment,
      required this.urgent});

  factory SignalorModel.fromJson(json){
    return SignalorModel(
       uid: json['uid'],
        nickName: json['nickName'],
        approximateAge: json['approximateAge'],
        placeOfResidence: json['placeOfResidence'],
        sizeM: json['sizeM'],
        year: json['year'],
        message: json['message'],
        path: json['path'],
        payment: json['payment'],
        urgent: json['urgent']
    );
  }
  Map<String,dynamic> toJson(){
    return
  {
  'uid':uid,
  'nickName':nickName,
  'approximateAge':approximateAge,
  'placeOfResidence':placeOfResidence,
  'sizeM':sizeM,
  'year':year,
  'message':message,
  'path':path,
  'payment':payment,
  'urgent':urgent
  };
}
}