import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/scr/resources/Class/ChatMassage.dart';

Widget bubbleImageFromUser(ChatMessage chatMessage){
  return Bubble(
    margin: const BubbleEdges.only(top: 10.0),
    alignment: Alignment.topRight,
    nip: BubbleNip.rightBottom,
    color: Colors.black,
    child: Column(
      children: [
        Image.network(chatMessage.pictureLink),
        Text("${chatMessage.content}",style: TextStyle(color: Colors.white),textAlign: TextAlign.right,),
      ],
    )

  );
}
Widget bubbleImageFromFriend(ChatMessage chatMessage){
  return Bubble(
      margin: const BubbleEdges.only(top: 10.0),
      alignment: Alignment.topRight,
      nip: BubbleNip.rightBottom,
      color: Colors.yellow,
      child: Column(
        children: [
          Image.network(chatMessage.pictureLink),
          Text("${chatMessage.content}",style: TextStyle(color: Colors.white),textAlign: TextAlign.right,),
        ],
      )

  );
}
Widget bubbleTextFromUser(ChatMessage chatMessage){
  return Bubble(
    margin: const BubbleEdges.only(top: 10.0),
    alignment: Alignment.topRight,
    nip: BubbleNip.rightBottom,
    color: Colors.black,
    child: Text("${chatMessage.content}",style: TextStyle(color: Colors.white),textAlign: TextAlign.right,),

  );
}
Widget bubbleTextFromFriend(ChatMessage chatMessage){
  return Bubble(
    margin: const BubbleEdges.only(top: 10.0),
    alignment: Alignment.topRight,
    nip: BubbleNip.rightBottom,
    color: Colors.yellow,
    child: Text("${chatMessage.content}",style: TextStyle(color: Colors.white),textAlign: TextAlign.right,),

  );
}