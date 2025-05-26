// ignore_for_file: deprecated_member_use, must_be_immutable
import 'dart:io';
import 'package:doctor_appointment/business_logic/chat/chat_cubit.dart';
import 'package:doctor_appointment/business_logic/chat/chat_state.dart';
import 'package:doctor_appointment/constants/callservices.dart';
import 'package:doctor_appointment/constants/fileupload.dart';
import 'package:doctor_appointment/constants/notifications.dart';
import 'package:doctor_appointment/data/model/doctormodel.dart';
import 'package:doctor_appointment/main.dart';
import 'package:doctor_appointment/presentation/widgets/chat/buildinputdata.dart';
import 'package:doctor_appointment/presentation/widgets/chat/cupertino.dart';
import 'package:doctor_appointment/presentation/widgets/chat/customappbar.dart';
import 'package:doctor_appointment/presentation/widgets/chat/custommessagebubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class ChatPage extends StatefulWidget {
  DoctorModel? listDoctorModel;
  String? targetToken;
  ChatPage({super.key, this.listDoctorModel, this.targetToken});
  @override
  // ignore: library_private_types_in_public_api
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late TextEditingController textController;
  late ScrollController scrollController;
  FocusNode focusNode = FocusNode();
  File? file;
  CallServices callServices = CallServices();

  @override
  void initState() {
    startOnInital(context, "chat", widget.listDoctorModel!.doctorId!);
    myRequestPermission();
    initialState();
    textController = TextEditingController();
    context.read<ChatCubit>().viewAllMessages(
      widget.listDoctorModel!.doctorId!,
    );

    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void initialState() {
    focusNode.addListener(() {
      if (focusNode.hasFocus) {}
    });
    scrollController = ScrollController();
    scrollController.addListener(() {});
  }

  makeAnimation() {
    if (scrollController.positions.isEmpty) {
      return;
    }
    scrollController.animateTo(
      scrollController.position.minScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  chooseImageGallery() async {
    file = await takePhotoWithGallery();
    print('file from gallery ================ $file');
    setState(() {});
  }

  chooseImageCamera() async {
    file = await takePhotoWithCamera();
    print('file from gallery ================ $file');
    setState(() {});
  }

  removeFile() {
    if (file != null) {
      file = null;
      print('file from remove ================ $file');
    } else {
      print('no file to remove');
    }
    setState(() {});
  }

  chooseImageOption() {
    showAttachmentOptions(
      context,
      chooseImageGallery,
      chooseImageCamera,
      removeFile,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ChatCubit>(context); // Access the ChatCubit
    final theme = Theme.of(context); // Get theme data

    return Scaffold(
      backgroundColor: theme.colorScheme.surface, // Softer background
      appBar: customAppBar(
        "Dr. ${widget.listDoctorModel!.doctorName}",
        theme,
        () {
          Navigator.of(context).pop();
          // Navigator.of(context).pushNamed(AppRotes.chatListScreen);
        },
        () {
          callServices.onUserLogin(
            myBox!.get("userId").toString(),
            myBox!.get("userName"),
          );
          ZegoUIKitPrebuiltCallInvitationService().send(
            resourceID: "faresZegoApp",
            //callID: "1",
            invitees: [
              ZegoCallUser(
                widget.listDoctorModel!.doctorId!,
                "Dr ${widget.listDoctorModel!.doctorName!}",
              ),
            ],
            isVideoCall: false,
          );
        },

        () {
          callServices.onUserLogin(
            myBox!.get("userId").toString(),
            myBox!.get("userName"),
          );
          ZegoUIKitPrebuiltCallInvitationService().send(
            resourceID: "faresZegoApp",
            //callID: "1",
            invitees: [
              ZegoCallUser(
                widget.listDoctorModel!.doctorId!,
                "Dr ${widget.listDoctorModel!.doctorName!}",
              ),
            ],
            isVideoCall: true,
          );
        },
      ),
      body: Column(
        children: [
          // --- Message List ---
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                if (state is ChatStateLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ChatStateLoaded) {
                  return ListView.builder(
                    shrinkWrap: true,
                    controller: scrollController,
                    reverse: true, // Show latest messages at the bottom
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 8.0,
                    ),
                    itemCount: state.listMessageModel.length,
                    itemBuilder: (context, index) {
                      return ContextMenuExample(
                        onPressed: () {},
                        child: MessageBubble(
                          messageModel: state.listMessageModel[index],
                        ),
                      );
                    },
                  );
                } else if (state is ChatStateError) {
                  return Center(
                    child: Text(
                      state.errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                } else if (state is ChatStateNoInternet) {
                  return Center(
                    child: Text(
                      state.errorInternetMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                } else {
                  return const Center(child: Text("No Messages Yet .."));
                }
              },
            ),
          ),

          Divider(height: 1.0, color: theme.dividerColor.withOpacity(0.5)),
          buildInputDataAres(
            theme,
            textController,
            () {
              // if (textController.text.trim().isEmpty) {
              //   return; // Don't send empty messages
              // }
              if (file != null) {
                cubit.sendMessages(
                  widget.listDoctorModel!.doctorId!,
                  textController,
                  file!, // Global variable to hold the selected image file
                );
              } else {
                if (textController.text.trim().isEmpty) {
                  return; // Don't send empty messages
                } else {
                  cubit.sendMessages(
                    widget.listDoctorModel!.doctorId!,
                    textController,
                    null, // Global variable to hold the selected image file
                  );
                }
              }
              sendFCMMessage(
                context,
                "${myBox!.get("userName")}",
                textController.text,
                "fares",
                widget.targetToken!,
                "chat",
              );

              file = null;
              textController.clear();
              makeAnimation();
            },
            () {
              chooseImageOption();
            },
            context,
          ),
        ],
      ),
    );
  }
}
