import 'package:doctor_appointment/constants/statusrequest.dart';
import 'package:doctor_appointment/data/model/categories.dart';
import 'package:doctor_appointment/data/model/doctormodel.dart';
import 'package:equatable/equatable.dart';

class CategoriesState extends Equatable {
  final StatusRequest statusRequest;
  const CategoriesState({required this.statusRequest});
  @override
  List<Object?> get props => [statusRequest];
}

class CategoriesLoading extends CategoriesState {
  const CategoriesLoading() : super(statusRequest: StatusRequest.loading);
  @override
  List<Object?> get props => [statusRequest];
}

class CategoriesLoaded extends CategoriesState {
  final List<CategoriesModel> listCategoriesLoaded;
  final List<DoctorModel> listDoctorCategoriesLoaded;
  const CategoriesLoaded({
    required this.listCategoriesLoaded,
    required this.listDoctorCategoriesLoaded,
  }) : super(statusRequest: StatusRequest.success);

  @override
  List<Object?> get props => [listCategoriesLoaded, statusRequest];
}

class CategoriesError extends CategoriesState {
  final String messageError;
  const CategoriesError({required this.messageError})
    : super(statusRequest: StatusRequest.failure);
  @override
  List<Object?> get props => [messageError, statusRequest];
}

class CategoriesServerError extends CategoriesState {
  const CategoriesServerError()
    : super(statusRequest: StatusRequest.serverException);
  @override
  List<Object?> get props => [statusRequest];
}
