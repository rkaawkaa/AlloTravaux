import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:allotravaux/constants/color_constants.dart';
import 'package:allotravaux/constants/constants.dart';

import '../store/message.dart';

class MessageComponent extends StatelessWidget {
  final int index;
  final DocumentSnapshot? document;

  const MessageComponent({super.key, required this.index, this.document});

  @override
  Widget build(BuildContext context) {
    if (document != null) {
      Message messageChat = Message.fromDocument(document!);

      var day = messageChat.date.substring(8, 10);
      var month = messageChat.date.substring(5, 7);
      var year = messageChat.date.substring(0, 4);

      var hoursMinutes = messageChat.date.substring(11, 16);

      var date = "$day/$month/$year • $hoursMinutes";

      if (messageChat.isMe) {
        // Right (my message)
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              width: 200,
              decoration: BoxDecoration(
                  color: ColorConstants.greyColor2,
                  borderRadius: BorderRadius.circular(8)),
              margin: EdgeInsets.only(
                  bottom: messageChat.isMe ? 20 : 10, right: 10),
              child: Text(
                messageChat.text,
                style: const TextStyle(color: ColorConstants.primaryColor),
              ),
            )
          ],
        );
      } else {
        // Left (peer message)
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                    width: 200,
                    decoration: BoxDecoration(
                        color: ColorConstants.primaryColor,
                        borderRadius: BorderRadius.circular(8)),
                    margin: const EdgeInsets.only(left: 10),
                    child: Text(
                      messageChat.text,
                      style: const TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
              // Time
              !messageChat.isMe
                  ? Container(
                      margin:
                          const EdgeInsets.only(left: 15, top: 5, bottom: 5),
                      child: Text(
                        date,
                        style: const TextStyle(
                            color: ColorConstants.greyColor,
                            fontSize: 12,
                            fontStyle: FontStyle.italic),
                      ),
                    )
                  : const SizedBox.shrink()
            ],
          ),
        );
      }
    } else {
      return const SizedBox.shrink();
    }
  }
}
