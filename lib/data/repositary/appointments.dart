import 'package:doctor_appointment/link_api.dart';
import '../web_services(API)/crud.dart';

class AppointmentsRepositary {
  final Crud crud;

  AppointmentsRepositary(this.crud);

  viewAppointmentsData(String userId) async {
    var response = await crud.getDataFromServer(AppLink.viewAppointments, {
      "userId": userId,
    });
    return response.fold((l) => l, (r) => r);
  }

  cancelAppointmentsData(String userId, String doctorId) async {
    var response = await crud.getDataFromServer(AppLink.cancelAppointments, {
      "userId": userId,
      "doctorId": doctorId,
    });
    return response.fold((l) => l, (r) => r);
  }

  viewCancelAppointmentsData(String userId) async {
    var response = await crud.getDataFromServer(
      AppLink.viewCancelAppointments,
      {"userId": userId},
    );
    return response.fold((l) => l, (r) => r);
  }

  getAppointmentToday(String userId) async {
    var response = await crud.getDataFromServer(AppLink.todayAppointments, {
      "userId": userId,
    });
    return response.fold((l) => l, (r) => r);
  }

  // viewRatingDoctorData(String userId) async {
  //   var response = await crud.getDataFromServer(AppLink.viewRatingDoctor, {
  //     "userId": userId,
  //   });
  //   return response.fold((l) => l, (r) => r);
  // }

  addAppointmentToday(String doctorId, String userId, String date) async {
    var response = await crud.getDataFromServer(AppLink.addAppointments, {
      "doctorId": doctorId,
      "userId": userId,
      "date": date,
    });
    return response.fold((l) => l, (r) => r);
  }

  autoDeleteAppointment(String userId) async {
    var response = await crud.getDataFromServer(
      AppLink.autoDeleteAppointments,
      {"userId": userId},
    );
    return response.fold((l) => l, (r) => r);
  }

  editAppointment(
    String userId,
    String doctorId,
    String appointmentDate,
  ) async {
    var response = await crud.getDataFromServer(AppLink.editAppointments, {
      "userId": userId,
      "doctorId": doctorId,
      "appointmentDate": appointmentDate,
    });
    return response.fold((l) => l, (r) => r);
  }
}
