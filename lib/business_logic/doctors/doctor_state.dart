// ignore_for_file: must_be_immutable

import 'package:doctor_appointment/data/model/doctormodel.dart';
import 'package:doctor_appointment/data/model/search.dart';
import 'package:equatable/equatable.dart';

class DoctorState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DoctorStateLoading extends DoctorState {
  DoctorStateLoading();
  @override
  List<Object?> get props => [];
}

class DoctorStateLoaded extends DoctorState {
  final List<DoctorModel> listDoctorModel;
  final List<SearchedDoctorModel> listSearchedDoctorModel;

  DoctorStateLoaded({
    required this.listDoctorModel,
    required this.listSearchedDoctorModel,
  });

  @override
  List<Object?> get props => [listDoctorModel, listSearchedDoctorModel];
}

class DoctorStateError extends DoctorState {
  final String errorMessage;
  DoctorStateError({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

class DoctorStateNoInternet extends DoctorState {
  final String errorInternetMessage;
  DoctorStateNoInternet({required this.errorInternetMessage});
  @override
  List<Object?> get props => [errorInternetMessage];
}
