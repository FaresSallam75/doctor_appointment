import 'package:doctor_appointment/constants/colors.dart';
import 'package:doctor_appointment/constants/styles.dart';
import 'package:doctor_appointment/link_api.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class CustomBodyAppointments extends StatelessWidget {
  final String doctorImage;
  final String doctorName;
  final String doctorSpecialization;
  final String appointmentDate;
  final bool isCancel;
  final String appointmentStatus;
  const CustomBodyAppointments({
    super.key,
    required this.doctorImage,
    required this.doctorName,
    required this.doctorSpecialization,
    required this.appointmentDate,
    required this.isCancel,
    required this.appointmentStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                "${AppLink.viewDoctorsImages}/$doctorImage",
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dr. $doctorName",
                  style: meduimStyle.copyWith(color: MyColors.header01),
                ),
                const SizedBox(height: 5),
                Text(
                  "$doctorSpecialization Clinic",
                  style: smallStyle.copyWith(
                    color: MyColors.purple02,
                    fontSize: 13.0,
                  ),
                ),
              ],
            ),
          ],
        ),

        if (Jiffy.parse(appointmentDate).date ==
            Jiffy.parse(DateTime.now().toString()).date)
          if (isCancel)
            const Positioned(
              top: 15.0,
              right: 5.0,
              child: Text("Today"),
              //  CircleAvatar(
              //   radius: 5.0,
              //   backgroundColor: MyColors.secondColor,
              // ),
            ),
        if (Jiffy.parse(appointmentDate).date <
                Jiffy.parse(DateTime.now().toString()).date &&
            appointmentStatus == "0")
          const Positioned(top: 15.0, right: 5.0, child: Text("Missed")),
      ],
    );
  }
}
