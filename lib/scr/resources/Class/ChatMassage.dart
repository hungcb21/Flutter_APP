import 'dart:math';

class ChatMessage{
  int timeStamp;
  String senderId,name,content,uid,pictureLink;
  bool picture;

  ChatMessage(this.timeStamp, this.senderId, this.name, this.content, this.uid,
      this.pictureLink, this.picture);
  ChatMessage.fromJson(Map<String,dynamic> json)
  {
    timeStamp=json["timeStamp"];
    senderId=json["senderId"];
    name=json["name"];
    picture=json["picture"];
    uid=json["uid"];
    pictureLink=json["pictureLink"];
  }
  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = Map<String,dynamic>();
    data["timeStamp"]= timeStamp;
    data['name']=name;
    data['picture']= picture;
    data['uid']=uid;
    data['senderId']=senderId;
    data['pictureLink']=pictureLink;
    return data;
  }
}