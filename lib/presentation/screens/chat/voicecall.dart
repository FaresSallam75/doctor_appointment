// import 'package:flutter/material.dart';
// import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

// class VoiceCall extends StatelessWidget {
//   final String doctorId;
//   final String doctorName;
//   const VoiceCall({
//     super.key,
//     required this.doctorId,
//     required this.doctorName,
//   });

//   @override

//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         MaterialButton(
//           onPressed: () {
//             ZegoUIKitPrebuiltCallInvitationService().send(
//               resourceID: "faresZegoApp",
//               callID: "1",
//               invitees: [ZegoCallUser(doctorId, doctorName)],
//               isVideoCall: false,
//             );
//           },
//           child: Text("Title"),
//         ),

//         // ZegoSendCallInvitationButton(
//         //   callID: "1",
//         //   isVideoCall: false,
//         //   //You need to use the resourceID that you created in the subsequent steps.
//         //   //Please continue reading this document.
//         //   resourceID: "faresZegoApp",
//         //   invitees: [ZegoUIKitUser(id: doctorId, name: doctorName)],
//         // ),
//       ],
//     );
//   }
// }

// // faresZegoApp

// // ZegoSendCallInvitationButton(
// //    isVideoCall: true,
// //    //You need to use the resourceID that you created in the subsequent steps.
// //    //Please continue reading this document.
// //    resourceID: "zegouikit_call",
// //    invitees: [
// //       ZegoUIKitUser(
// //          id: targetUserID,
// //          name: targetUserName,
// //       ),
// //       ...
// //       ZegoUIKitUser(
// //          id: targetUserID,
// //          name: targetUserName,
// //       )
// //    ],
// // )



// // ZegoUIKitPrebuiltCall(
// //       appID:
// //           MyConst
// //               .appId, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
// //       appSign:
// //           MyConst
// //               .appSign, // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
// //       userID: doctorId,
// //       userName: doctorName,

// //       callID: "1",
// //       // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
// //       config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall(),
// //       //..onOnlySelfInRoom = (context) => Navigator.of(context).pop(),
// //     );