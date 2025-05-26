import 'package:doctor_appointment/business_logic/homepage/categories_state.dart';
import 'package:doctor_appointment/constants/handlingdata.dart';
import 'package:doctor_appointment/constants/statusrequest.dart';
import 'package:doctor_appointment/data/model/categories.dart';
import 'package:doctor_appointment/data/model/doctormodel.dart';
import 'package:doctor_appointment/data/repositary/categories_repositary.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final CategoriesRepositary categoriesRepositary;

  List<CategoriesModel> categoriesModelLoaded = [];

  List<DoctorModel> listDoctorCategoeies = [];

  //late StatusRequest statusRequest;
  CategoriesCubit(this.categoriesRepositary) : super(const CategoriesLoading());

  Future<List<CategoriesModel>> fetchCategories() async {
    var response = await categoriesRepositary.getCategoriesData();
    StatusRequest statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == "success") {
        categoriesModelLoaded.clear();
        List data = response['data'];
        categoriesModelLoaded.addAll(
          data.map((e) => CategoriesModel.fromJson(e)),
        );
        emit(
          CategoriesLoaded(
            listCategoriesLoaded: categoriesModelLoaded,
            listDoctorCategoriesLoaded: const [],
          ),
        );
      } else {
        emit(const CategoriesServerError());
      }
    } else {
      emit(const CategoriesError(messageError: "failed. Try again."));
    }

    return categoriesModelLoaded;
  }

  Future<List<DoctorModel>> getDoctorCategories(String categoryId) async {
    listDoctorCategoeies.clear();
    var response = await categoriesRepositary.viewDoctorCategoriesData(
      categoryId,
    );
    StatusRequest statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == "success") {
        List data = response['data'];
        listDoctorCategoeies.addAll(data.map((e) => DoctorModel.fromJson(e)));
        emit(
          CategoriesLoaded(
            listDoctorCategoriesLoaded: listDoctorCategoeies,
            listCategoriesLoaded: const [],
          ),
        );
      } else {
        emit(
          const CategoriesError(
            messageError: "Failed to load Data Status Failure",
          ),
        );
      }
    } else {
      emit(
        const CategoriesError(
          messageError: "something went wrong with the server",
        ),
      );
    }
    return listDoctorCategoeies;
  }
}
