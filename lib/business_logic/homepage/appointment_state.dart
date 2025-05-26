// ignore_for_file: must_be_immutable

import 'package:doctor_appointment/constants/statusrequest.dart';
import 'package:doctor_appointment/data/model/appointments.dart';
import 'package:equatable/equatable.dart';

class AppointmentState extends Equatable {
  late StatusRequest statusRequest;
  @override
  List<Object?> get props => [statusRequest];
  AppointmentState({required this.statusRequest});
}

class AppointmentStateLoading extends AppointmentState {
  AppointmentStateLoading() : super(statusRequest: StatusRequest.loading);
  @override
  List<Object?> get props => [statusRequest];
}

class AppointmentStateLoaded extends AppointmentState {
  List<AppointmentsModel> appointments = [];
  // List<AppointmentsModel> todayAppointments = [];
  // List<AppointmentsModel> listCancelAppointments = [];

  AppointmentStateLoaded({
    required this.appointments,
    // required this.todayAppointments,
    // required this.listCancelAppointments,
  }) : super(statusRequest: StatusRequest.success);
  @override
  List<Object?> get props => [
    statusRequest,
    appointments,
    // todayAppointments,
    // listCancelAppointments,
  ];
}

class AppointmentStateError extends AppointmentState {
  AppointmentStateError() : super(statusRequest: StatusRequest.failure);
  @override
  List<Object?> get props => [statusRequest];
}
