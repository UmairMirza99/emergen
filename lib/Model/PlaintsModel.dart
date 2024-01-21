class PlaintsModel{
  String uid,message,path;
  bool payment=false;

  PlaintsModel({required this.uid, required this.message, required this.path, required this.payment});

  factory PlaintsModel.fromJson(json){
    return PlaintsModel(
        uid: json['uid'],
        message: json['message'],
        path: json['path'],
        payment: json['payment']
    );
  }

  Map<String,dynamic> toJson(){
    return {
      'uid':uid,
  'message':message,
  'path':path,
  'payment':payment
  };
}

}