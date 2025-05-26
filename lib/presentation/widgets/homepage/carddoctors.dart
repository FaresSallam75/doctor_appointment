import 'package:doctor_appointment/business_logic/doctors/doctor_cubit.dart';
import 'package:doctor_appointment/business_logic/doctors/doctor_state.dart';
import 'package:doctor_appointment/constants/colors.dart';
import 'package:doctor_appointment/constants/imageasset.dart';
import 'package:doctor_appointment/constants/styles.dart';
import 'package:doctor_appointment/data/model/doctormodel.dart';
import 'package:doctor_appointment/link_api.dart';
import 'package:doctor_appointment/presentation/screens/doctors/doctor_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomCardDoctors extends StatelessWidget {
  const CustomCardDoctors({super.key});

  goToDoctorDetailsPage(
    BuildContext context,
    DoctorModel listDoctorModel,
  ) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DoctorDetails(listDoctorModel: listDoctorModel),
      ),
      // BlocProvider.value(
      //   value: BlocProvider.of<DoctorCubit>(context),
      //   child: DoctorDetails(listDoctorModel: listDoctorModel),
      // ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorCubit, DoctorState>(
      builder: (context, state) {
        if (state is DoctorStateLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is DoctorStateLoaded) {
          return SizedBox(
            height: 180.0,
            child: Listener(
              child: ListView.separated(
                separatorBuilder:
                    (context, index) => const SizedBox(width: 10.0),
                itemCount: state.listDoctorModel.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder:
                    (context, index) => Container(
                      width: MediaQuery.of(context).size.width - 45,
                      //height: 200.0,
                      decoration: BoxDecoration(
                        color: (MyColors.primary),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Material(
                        color: const Color.fromARGB(28, 0, 0, 0),
                        child: InkWell(
                          onTap: () {
                            goToDoctorDetailsPage(
                              context,
                              state.listDoctorModel[index],
                              // state.listCategoriesLoaded[index],
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Looking For Your Desire \nSpecialist Doctor?",
                                      style: meduimStyle,
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      "Dr. ${state.listDoctorModel[index].doctorName}",
                                      style: smallStyle,
                                    ),
                                    Text(
                                      "${state.listDoctorModel[index].specialization} Specialist",
                                      style: smallStyle,
                                    ),
                                    Text(
                                      "Good Health Clinic",
                                      style: smallStyle,
                                    ),
                                  ],
                                ),
                                // const Spacer(),
                                Expanded(
                                  child: FadeInImage.assetNetwork(
                                    placeholder: AppImageAsset
                      .loadingAssetImage, //"assets/images/loading.gif",
                                    image:
                                        "${AppLink.viewDoctorsImages}/${state.listDoctorModel[index].doctorImage}",

                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
              ),
            ),
          );
        } else {
          return const Center(child: Text('No Data ...'));
        }
      },
    );
  }
}
