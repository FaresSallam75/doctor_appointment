import 'package:doctor_appointment/constants/statusrequest.dart';
import 'package:doctor_appointment/data/model/categories.dart';
import '../web_services(API)/crud.dart';
import 'package:doctor_appointment/link_api.dart';

class CategoriesRepositary {
  final Crud crud;

  List<CategoriesModel> categoriesModel = [];
  CategoriesRepositary(this.crud);

  StatusRequest statusRequest = StatusRequest.none;

  getCategoriesData() async {
    //statusRequest = StatusRequest.loading;
    var response = await crud.getDataFromServer(AppLink.viewCategories, {});

    return response.fold((l) => l, (r) => r);
    // if (response['status'] == "success") {
    //   // dealing with If data comes from database (List)
    //   List data = response['data'];
    //   categoriesModel.addAll(data.map((e) => CategoriesModel.fromJson(e)));

    //   // dealing with If data comes from API (Map)
    //   /* if (response['data'] is Map<String, dynamic>) {
    //   Map<String, dynamic> userData = response['data'];
    //   userData.entries.map((e) => {e.key: e.value}).toList();
    //   categoriesModel = [CategoriesModel.fromJson(userData)];
    // } */

    //   return categoriesModel;
    // }
  }

  viewDoctorCategoriesData(String categoryId) async {
    var response = await crud.getDataFromServer(AppLink.viewDoctorCategories, {
      "categoryId": categoryId,
    });
    return response.fold((l) => l, (r) => r);
  }
}
