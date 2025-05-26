import '../web_services(API)/crud.dart';
import 'package:doctor_appointment/link_api.dart';

class DoctorRepositary {
  final Crud crud;
  DoctorRepositary(this.crud);

  viewAllDoctorsData() async {
    var response = await crud.getDataFromServer(AppLink.viewAllDoctor, {});
    return response.fold((l) => l, (r) => r);
  }

  viewDoctorDetailsData(Map data) async {
    var response = await crud.getDataFromServer(
      AppLink.viewDoctorDetails,
      data,
    );
    return response.fold((l) => l, (r) => r);
  }

  ratingDoctorsData(Map data) async {
    var response = await crud.getDataFromServer(AppLink.ratingDoctor, data);
    return response.fold((l) => l, (r) => r);
  }

  viewRatingDoctorData(String userId) async {
    var response = await crud.getDataFromServer(AppLink.viewRatingDoctor, {
      "userId": userId,
    });
    return response.fold((l) => l, (r) => r);
  }

  getSearchedDoctorsData(String search) async {
    var response = await crud.getDataFromServer(AppLink.getSearhedDoctor, {
      "search": search,
    });
    return response.fold((l) => l, (r) => r);
  }
}
