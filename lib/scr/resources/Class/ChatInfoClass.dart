class ChatInfo {
  String friendName, friendId, createId, lastMessage, createName;
  int lastUpdate,createDate;


  ChatInfo(this.friendName, this.friendId, this.createId, this.lastMessage,
      this.createName, this.lastUpdate, this.createDate);

  ChatInfo.fromJson(Map<String,dynamic> json)
  {
    friendId=json["friendId"];
    friendName=json["friendName"];
    friendName=json["createId"];
    createName=json["createName"];
    lastMessage=json["lastMessage"];
    createDate=json["createDate"];
    lastUpdate=json["lastUpdate"];
  }
  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = Map<String,dynamic>();
    data["friendId"]= friendId;
    data['friendName']=friendName;
    data['friendName']= friendName;
    data['createName']=createName;
    data['lastMessage']=lastMessage;
    data['lastUpdate']=lastUpdate;
    data['createDate']=createDate;
    return data;
  }
}
