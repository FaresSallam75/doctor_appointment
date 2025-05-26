import 'dart:io';

import '../web_services(API)/crud.dart';
import 'package:doctor_appointment/link_api.dart';

class ChatRepositary {
  final Crud crud;
  const ChatRepositary(this.crud);

  viewAllMessagesData(Map data) async {
    var response = await crud.getDataFromServer(AppLink.viewMessages, data);
    return response.fold((l) => l, (r) => r);
  }

  viewCardMessagesData(Map data) async {
    var response = await crud.getDataFromServer(AppLink.viewCardMessages, data);
    return response.fold((l) => l, (r) => r);
  }

  sendMessageData(Map data, [File? file]) async {
    // ignore: prefer_typing_uninitialized_variables
    var response;
    if (file == null) {
      response = await crud.getDataFromServer(AppLink.sendMessages, data);
    } else {
      response = await crud.postRequestWithFile(
        AppLink.sendMessages,
        data,
        file,
      );
    }

    return response.fold((l) => l, (r) => r);
  }
}
