import 'package:doctor_appointment/constants/showalertdialog.dart';
import 'package:flutter/material.dart';

class CustomButtonAppointment extends StatelessWidget {
  final void Function()? onPressedOk;
  final void Function()? onPressedCancel;
  final Widget onPressedReschedule;

  const CustomButtonAppointment({
    super.key,
    required this.onPressedOk,
    required this.onPressedCancel,
    required this.onPressedReschedule,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: OutlinedButton(
            child: const Text('Cancel'),
            onPressed: () {
              functionShowAlertDialog(
                context,
                "Cancel",
                "Are you sure to cancel this appointment",
                "OK",
                "Cancel",
                onPressedOk,
                onPressedCancel,
              );
            },
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: ElevatedButton(
            child: Text("Reschedule"),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => onPressedReschedule),
              );
            },
          ),
        ),
      ],
    );
  }
}

class CustomElvatedButton extends StatelessWidget {
  final String text;
  final void Function()? onPressedDelete;

  const CustomElvatedButton({
    super.key,
    required this.text,
    required this.onPressedDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressedDelete, child: Text(text));
  }
}

class CustomElevetedButtonReschedule extends StatelessWidget {
  final void Function()? onPressed;
  final String text;

  const CustomElevetedButtonReschedule({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1E63E9),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        child: Text(text, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
