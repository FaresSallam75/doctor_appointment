import 'dart:async';

import 'package:doctor_appointment/business_logic/homepage/appointment_state.dart';
import 'package:doctor_appointment/constants/handlingdata.dart';
import 'package:doctor_appointment/constants/route.dart';
import 'package:doctor_appointment/constants/showalertdialog.dart';
import 'package:doctor_appointment/constants/statusrequest.dart';
import 'package:doctor_appointment/data/model/appointments.dart';
import 'package:doctor_appointment/data/repositary/appointments.dart';
import 'package:doctor_appointment/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  final AppointmentsRepositary appointmentsRepositary;
  List<AppointmentsModel> listAppointments = [];
  List listRatingDoctors = [];

  AppointmentCubit(this.appointmentsRepositary)
    : super(AppointmentStateLoading());

  Future<List<AppointmentsModel>> getViewAppointmentsData() async {
    var response = await appointmentsRepositary.viewAppointmentsData(
      myBox!.get("userId").toString(),
    );
    StatusRequest statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == "success") {
        listAppointments.clear();
        List data = response['data'];
        listAppointments.addAll(data.map((e) => AppointmentsModel.fromJson(e)));
        emit(
          AppointmentStateLoaded(
            appointments: listAppointments,
            // todayAppointments: const [],
            // listCancelAppointments: const [],
          ),
        );
      } else {
        emit(AppointmentStateError());
      }
    } else {
      emit(AppointmentStateError());
    }
    return listAppointments;
  }

  refresh() {
    if (listAppointments.isEmpty) return;
    Timer.periodic(
      const Duration(seconds: 30),
      (_) => getViewAppointmentsData(),
    );
  }

  cancelAppointment(String doctorId) async {
    var response = await appointmentsRepositary.cancelAppointmentsData(
      myBox!.get("userId").toString(),
      doctorId,
    );
    StatusRequest statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == "success") {
        emit(AppointmentStateLoading());
        getViewAppointmentsData();
      } else {
        emit(AppointmentStateError());
      }
    } else {
      emit(AppointmentStateError());
    }
  }

  addAppoinment(
    String doctorId,
    String userId,
    String date,
    BuildContext context,
  ) async {
    var response = await appointmentsRepositary.addAppointmentToday(
      doctorId,
      userId,
      date,
    );
    StatusRequest statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == "success") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Appointment Confirmed Successfully ')),
        );
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil(AppRotes.homePage, (route) => false);
        // emit(AppointmentStateLoading());
        // getViewAppointmentsData();
      } else {
        functionShowAlertDialog(
          context,
          "Alert",
          "You Already Have Appointment With This Doctor Before",
          "OK",
          "Cancel",
          () {
            Navigator.of(context).pop();
          },
          () {
            Navigator.of(context).pop();
          },
        );
        emit(AppointmentStateError());
      }
    } else {
      emit(AppointmentStateError());
    }
  }

  editAppoinment(
    String userId,
    String doctorId,
    String date,
    BuildContext context,
  ) async {
    var response = await appointmentsRepositary.editAppointment(
      userId,
      doctorId,
      date,
    );
    StatusRequest statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == "success") {
        Navigator.of(context).pushReplacementNamed(AppRotes.homePage);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Appointment Date Changed Successfully '),
          ),
        );
        emit(AppointmentStateError());
      }
    } else {
      emit(AppointmentStateError());
    }
  }

  // autoDeleteAppoinments() async {
  //   await appointmentsRepositary.autoDeleteAppointment(
  //     myBox!.get("userId").toString(),
  //   );
  // }

  refreshAppointments() {
    emit(AppointmentStateLoading());
    getViewAppointmentsData();
  }

  // viewRatingDoctor() async {
  //   var response = await appointmentsRepositary.viewRatingDoctorData(
  //     myBox!.get("userId"),
  //   );
  //   StatusRequest statusRequest = handlingData(response);
  //   if (statusRequest == StatusRequest.success) {
  //     if (response['status'] == "success") {
  //       List data = response['data'];

  //       listRatingDoctors = data;

  //       print("data==================================");
  //       print(
  //         "listRatingDoctors ==================== ${listRatingDoctors[0]['doctor_id']}",
  //       );
  //       print(
  //         "listRatingDoctors ==================== ${listRatingDoctors[1]['doctor_id']}",
  //       );
  //       print("data==================================");
  //     } else {
  //       emit(AppointmentStateError());
  //     }
  //   } else {
  //     emit(AppointmentStateError());
  //   }
  // }
}
