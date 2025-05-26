// ignore_for_file: must_be_immutable

import 'package:doctor_appointment/business_logic/homepage/categories_cubit.dart';
import 'package:doctor_appointment/business_logic/homepage/categories_state.dart';
import 'package:doctor_appointment/constants/colors.dart';
import 'package:doctor_appointment/constants/imageasset.dart';
import 'package:doctor_appointment/constants/route.dart';
import 'package:doctor_appointment/link_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorCategoriesDetails extends StatefulWidget {
  final String? categoryId;
  const DoctorCategoriesDetails({super.key, this.categoryId});

  @override
  State<DoctorCategoriesDetails> createState() =>
      _DoctorCategoriesDetailsState();
}

class _DoctorCategoriesDetailsState extends State<DoctorCategoriesDetails> {
  @override
  void initState() {
    context.read<CategoriesCubit>().getDoctorCategories(widget.categoryId!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Doctors"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(AppRotes.homePage);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),

      body: BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, state) {
          if (state is CategoriesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CategoriesLoaded) {
            return ListView.separated(
              itemBuilder:
                  (context, index) => Card(
                    margin: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Container(
                          color: (MyColors.grey01),
                          child: FadeInImage.assetNetwork(
                            height: 100.0,
                            width: 100.0,
                            placeholder:
                                AppImageAsset
                                    .loadingAssetImage, //"assets/images/loading.gif",
                            image:
                                "${AppLink.viewDoctorsImages}/${state.listDoctorCategoriesLoaded[index].doctorImage}",
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Dr. ${state.listDoctorCategoriesLoaded[index].doctorName}",
                              style: const TextStyle(
                                color: (MyColors.header01),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 5),

                            Text(
                              "${state.listDoctorCategoriesLoaded[index].specialization}",
                              style: const TextStyle(
                                color: (MyColors.grey02),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: (MyColors.yellow02),
                                  size: 18,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  '4.0 - 50 Reviews',
                                  style: TextStyle(color: (MyColors.grey02)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
              separatorBuilder: (context, index) => const SizedBox(height: 0.0),
              itemCount: state.listDoctorCategoriesLoaded.length,
            );
          } else {
            return const Center(child: Text("No data ..."));
          }
        },
      ),
    );
  }
}
