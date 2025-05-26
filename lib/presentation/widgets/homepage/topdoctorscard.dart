import 'package:doctor_appointment/business_logic/doctors/doctor_cubit.dart';
import 'package:doctor_appointment/business_logic/doctors/doctor_state.dart';
import 'package:doctor_appointment/constants/colors.dart';
import 'package:doctor_appointment/constants/imageasset.dart';
import 'package:doctor_appointment/data/model/doctormodel.dart';
import 'package:doctor_appointment/link_api.dart';
import 'package:doctor_appointment/presentation/screens/doctors/doctor_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopDoctorCard extends StatelessWidget {
  const TopDoctorCard({super.key});

  goToDoctorDetailsPage(
    BuildContext context,
    DoctorModel listDoctorModel,
  ) async {
    Navigator.pushReplacement(
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
          final cubit = context.read<DoctorCubit>();
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: cubit.listRatingDoctors.length,
            separatorBuilder: (context, index) => const SizedBox(height: 0.0),
            itemBuilder:
                (context, index) => Card(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: InkWell(
                    onTap: () {
                      goToDoctorDetailsPage(
                        context,
                        state.listDoctorModel[index],
                        // context.read<DoctorCubit>().listRatingDoctors[index],

                        // state.listCategoriesLoaded[index],
                      );
                    },
                    child: Row(
                      children: [
                        Container(
                          color: (MyColors.grey01),
                          child: FadeInImage.assetNetwork(
                            width: 100.0,
                            height: 100.0,

                            placeholder:
                                AppImageAsset
                                    .loadingAssetImage, //"assets/images/loading.gif",
                            image:
                                "${AppLink.viewDoctorsImages}/${cubit.listRatingDoctors[index]['doctor_image']}",
                            fit: BoxFit.contain,
                          ),

                          /* Image(
                            width: 100,
                            image: NetworkImage(
                              "${AppLink.viewDoctorsImages}/${state.listDoctorModel[index].doctorImage}",
                            ),
                          ), */
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "DR ${cubit.listRatingDoctors[index]['doctor_name']}",
                              style: const TextStyle(
                                color: (MyColors.header01),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 5),

                            Text(
                              "${cubit.listRatingDoctors[index]['specialization']} Specialist",
                              style: const TextStyle(
                                color: (MyColors.grey02),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: (MyColors.yellow02),
                                  size: 18,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  '${cubit.listRatingDoctors[index]['rating']} - 50 Reviews',
                                  style: TextStyle(color: (MyColors.grey02)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
          );
        } else {
          return const Center(child: Text("No Doctor Rating"));
        }
      },
    );
  }
}
