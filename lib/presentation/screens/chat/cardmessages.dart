import 'package:doctor_appointment/business_logic/chat/chat_cubit.dart';
import 'package:doctor_appointment/business_logic/chat/chat_state.dart';
import 'package:doctor_appointment/constants/colors.dart';
import 'package:doctor_appointment/constants/styles.dart';
import 'package:doctor_appointment/data/model/doctormodel.dart';
import 'package:doctor_appointment/link_api.dart';
import 'package:doctor_appointment/presentation/screens/chat/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';

// ignore: must_be_immutable
class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  void initState() {
    context.read<ChatCubit>().viewCardMessages();
    refresh();
    //context.read<ChatCubit>().refreshPage();
    super.initState();
  }

  void refresh() {
    context.read<ChatCubit>().refreshPage();
    setState(() {});
  }

  goToPageChat(DoctorModel? listDoctorModel) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => ChatPage(listDoctorModel: listDoctorModel),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F4F2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop();
            // Navigator.of(context).pushReplacementNamed(AppRotes.homePage);
          },
        ), //Icon(Icons.menu, color: Colors.brown),
        title: Text(
          "Chats", //'Salonek',
          style: TextStyle(color: Colors.brown, fontSize: 22),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code, color: Colors.brown),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.favorite_border, color: Colors.brown),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          if (state is ChatStateLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ChatStateLoaded) {
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemCount: state.listCardMessageModel.length,
              itemBuilder:
                  (context, index) => InkWell(
                    onTap: () {
                      goToPageChat(
                        DoctorModel.fromJson(
                          state.listCardMessageModel[index].toJson(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              "${AppLink.viewDoctorsImages}/${state.listCardMessageModel[index].doctorImage!}",
                            ),
                            radius: 25,
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.listCardMessageModel[index].doctorName!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  state.listCardMessageModel[index].text!,
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ],
                            ),
                          ),
                          if (state.listCardMessageModel[index].date != null)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  Jiffy.parse(
                                    state.listCardMessageModel[index].date!,
                                  ).jm,
                                  style: smallStyle.copyWith(
                                    // ignore: deprecated_member_use
                                    color: MyColors.grey02,
                                    fontSize: 13.0,
                                  ),
                                ),
                                // if (chat.containsKey('unread'))
                                //   Container(
                                //     margin: EdgeInsets.only(top: 5),
                                //     padding: EdgeInsets.symmetric(
                                //       horizontal: 6,
                                //       vertical: 2,
                                //     ),
                                //     decoration: BoxDecoration(
                                //       color: Colors.redAccent,
                                //       borderRadius: BorderRadius.circular(10),
                                //     ),
                                //     child: Text(
                                //       '${chat['unread']}',
                                //       style: TextStyle(color: Colors.white, fontSize: 12),
                                //     ),
                                //   ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
            );
          } else if (state is ChatStateError) {
            return Center(child: Text(state.errorMessage));
          } else {
            return Center(child: Text("No Internet Connection .."));
          }
        },
      ),
    );
  }
}
