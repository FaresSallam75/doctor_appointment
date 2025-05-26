import 'package:doctor_appointment/business_logic/doctors/doctor_state.dart';
import 'package:doctor_appointment/constants/handlingdata.dart';
import 'package:doctor_appointment/constants/statusrequest.dart';
import 'package:doctor_appointment/data/model/doctormodel.dart';
import 'package:doctor_appointment/data/model/search.dart';
import 'package:doctor_appointment/data/repositary/doctor_repositary.dart';
import 'package:doctor_appointment/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorCubit extends Cubit<DoctorState> {
  final DoctorRepositary doctorRepositary;
  DoctorCubit(this.doctorRepositary) : super(DoctorStateLoading());

  List<DoctorModel> listDoctorModel = [];
  List<SearchedDoctorModel> listSearchedDoctorModel = [];
  Map<String, dynamic> doctorData = {};
  List listDoctorDeatils = [];
  List listRatingDoctors = [];

  Future<List<DoctorModel>> getAllDoctors() async {
    var response = await doctorRepositary.viewAllDoctorsData();
    StatusRequest statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        List data = response["data"];
        print(
          "======================== ===================================== ",
        );
        listDoctorModel =
            data.map((data) => DoctorModel.fromJson(data)).toList();
        print(
          "All Doctors Get Scuuessfully=========================$listDoctorModel",
        );
        emit(
          DoctorStateLoaded(
            listDoctorModel: listDoctorModel,
            listSearchedDoctorModel: [],
          ),
        );
      } else {
        emit(DoctorStateError(errorMessage: "Status Failure"));
      }
    } else {
      emit(DoctorStateNoInternet(errorInternetMessage: "Internet Failure"));
    }
    return listDoctorModel;
  }

  Future<List<SearchedDoctorModel>> getSearchedDoctors(String search) async {
    var response = await doctorRepositary.getSearchedDoctorsData(search);
    StatusRequest statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        List data = response["data"];
        listSearchedDoctorModel =
            data.map((data) => SearchedDoctorModel.fromJson(data)).toList();
        emit(
          DoctorStateLoaded(
            listDoctorModel: [],
            listSearchedDoctorModel: listSearchedDoctorModel,
          ),
        );
      } else {
        emit(DoctorStateError(errorMessage: "Status Failure"));
      }
    } else {
      emit(DoctorStateNoInternet(errorInternetMessage: "Internet Failure"));
    }
    return listSearchedDoctorModel;
  }

  getDoctorDetails(String doctorId) async {
    var response = await doctorRepositary.viewDoctorDetailsData({
      "doctorId": doctorId,
    });
    StatusRequest statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        doctorData = response['data'];
        doctorData.entries.map((e) => {e.key: e.value}).toList();
        listDoctorDeatils = doctorData.values.toList();
        print(" listDoctorDeatils ==================== $listDoctorDeatils");
      } else {
        emit(DoctorStateError(errorMessage: "Status Failure"));
      }
    } else {
      emit(DoctorStateNoInternet(errorInternetMessage: "Internet Failure"));
    }
  }

  ratingDoctor(String doctorId, String comment, String rating) async {
    var response = await doctorRepositary.ratingDoctorsData({
      "userId": myBox!.get("userId"),
      "doctorId": doctorId,
      "comment": comment,
      "rating": rating,
    });
    StatusRequest statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        print("Doctor Rating Was Successfully ....");
      } else {
        emit(DoctorStateError(errorMessage: "No Rated Doctor"));
      }
    } else {
      emit(DoctorStateNoInternet(errorInternetMessage: "Internet Failure"));
    }
  }

  Future<List> viewRatingDoctor() async {
    var response = await doctorRepositary.viewRatingDoctorData(
      myBox!.get("userId").toString(),
    );
    StatusRequest statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == "success") {
        List data = response['data'];
        listRatingDoctors = data.map((e) => e).toList();

        print("listRatingDoctors ==================== $listRatingDoctors");
      } else {
        emit(
          DoctorStateError(
            errorMessage: "Status Failure Beckend Error .......",
          ),
        );
      }
    } else {
      emit(DoctorStateError(errorMessage: "statusRequest Not Scccess ...."));
    }
    return listRatingDoctors;
  }

  refreshPage() {
    emit(DoctorStateLoading());
  }
}
