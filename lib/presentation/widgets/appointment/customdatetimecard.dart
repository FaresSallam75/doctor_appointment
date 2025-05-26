import 'package:doctor_appointment/constants/colors.dart';
import 'package:flutter/material.dart';

class DateTimeCard extends StatelessWidget {
  final String date;
  final String time;
  const DateTimeCard({super.key, required this.date, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: (MyColors.bg03),
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.calendar_today,
                color: (MyColors.primary),
                size: 15,
              ),
              const SizedBox(width: 5),
              Text(
                date,
                //'Mon, July 29',
                style: const TextStyle(
                  fontSize: 12,
                  color: (MyColors.primary),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.access_alarm,
                color: (MyColors.primary),
                size: 17,
              ),
              const SizedBox(width: 5),
              Text(
                time,
                //'11:00 ~ 12:10',
                style: const TextStyle(
                  color: (MyColors.primary),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
