import 'package:doctor_appointment/constants/colors.dart';
import 'package:doctor_appointment/constants/customexternalicon.dart';
import 'package:doctor_appointment/constants/styles.dart';
import 'package:flutter/material.dart';

class UserIntro extends StatelessWidget {
  final String one;
  final String two;
  final void Function() onPressedSearch;
  final void Function() onPressedChat;

  const UserIntro({
    super.key,
    required this.one,
    required this.two,
    required this.onPressedSearch,
    required this.onPressedChat,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(one, style: meduimStyle.copyWith(color: MyColors.black)),
            Text(two, style: largeStyle.copyWith(color: MyColors.black)),
          ],
        ),
        const Spacer(),
        IconButton(onPressed: onPressedSearch, icon: const Icon(Icons.search)),
        //const  CircleAvatar(backgroundImage: AssetImage('assets/person.jpeg')),
        IconButton(
          onPressed: onPressedChat,
          icon: const Icon(MyFlutterApp.chat, size: 20.0),
        ),
      ],
    );
  }
}

// class CategoryIcon extends StatelessWidget {
//   IconData icon;
//   String text;

//   CategoryIcon({super.key, required this.icon, required this.text});

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       splashColor: (MyColors.bg01),
//       onTap: () {},
//       child: Padding(
//         padding: const EdgeInsets.all(4.0),
//         child: Column(
//           children: [
//             Container(
//               width: 50,
//               height: 50,
//               decoration: BoxDecoration(
//                 color: (MyColors.bg),
//                 borderRadius: BorderRadius.circular(50),
//               ),
//               child: Icon(icon, color: (MyColors.primary)),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               text,
//               style: const TextStyle(
//                 color: (MyColors.primary),
//                 fontSize: 12,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
