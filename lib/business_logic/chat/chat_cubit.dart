import 'dart:io';

import 'package:doctor_appointment/business_logic/chat/chat_state.dart';
import 'package:doctor_appointment/data/model/messgemodel.dart';
import 'package:doctor_appointment/data/repositary/chat_repositary.dart';
import 'package:doctor_appointment/main.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepositary chatRepositary;
  List<MessageModel> listMessageModel = [];
  List<MessageModel> listCardMessageModel = [];
  //File? file;
  ChatCubit(this.chatRepositary) : super(const ChatStateLoading());

  viewAllMessages(String reciever) async {
    listMessageModel.clear();
    var response = await chatRepositary.viewAllMessagesData({
      "sender": myBox!.get("userId").toString(),
      "receiver": reciever,
    });

    if (response['status'] == 'success') {
      listMessageModel =
          response['data']
              .map<MessageModel>((e) => MessageModel.fromJson(e))
              .toList()
              .cast<MessageModel>();

      print("listMessageModel ====================== $listMessageModel");
      emit(
        ChatStateLoaded(
          listMessageModel: listMessageModel,
          listCardMessageModel: [],
        ),
      );
    } else if (response['status'] == 'failure') {
      emit(const ChatStateError(errorMessage: "No Messages Data .."));
    } else {
      emit(
        const ChatStateNoInternet(
          errorInternetMessage: "No Internet Connection ..",
        ),
      );
    }
  }

  viewCardMessages() async {
    listCardMessageModel.clear();
    var response = await chatRepositary.viewCardMessagesData({
      "userId": myBox!.get("userId").toString(),
      // "receiver": reciever,
    });

    if (response['status'] == 'success') {
      listCardMessageModel =
          response['data']
              .map<MessageModel>((e) => MessageModel.fromJson(e))
              .toList()
              .cast<MessageModel>();

      print("listMessageModel ====================== $listCardMessageModel");
      emit(
        ChatStateLoaded(
          listMessageModel: [],
          listCardMessageModel: listCardMessageModel,
        ),
      );
    } else if (response['status'] == 'failure') {
      emit(const ChatStateError(errorMessage: "No Messages Data .."));
    } else {
      emit(
        const ChatStateNoInternet(
          errorInternetMessage: "No Internet Connection ..",
        ),
      );
    }
  }

  sendMessages(
    String reciever,
    TextEditingController message,
    File? file,
  ) async {
    //  statusRequest = StatusRequest.loading;
    // update();
    Map dataMessage = {
      "sender": myBox!.get("userId").toString(),
      "receiver": reciever,
      "message": message.text.trim(),
    };
    var response = await chatRepositary.sendMessageData(
      dataMessage,
      // ignore: prefer_if_null_operators
      file,
    );

    if (response['status'] == "success") {
      message.clear();

      //emit(const ChatStateLoading());
      viewAllMessages(reciever);
    } else {
      emit(const ChatStateError(errorMessage: "No Messages Data .."));
    }
  }

  refreshPage() {
    emit(const ChatStateLoading());
    // viewCardMessages();
  }
}
