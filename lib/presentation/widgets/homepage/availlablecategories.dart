import 'package:doctor_appointment/business_logic/homepage/categories_cubit.dart';
import 'package:doctor_appointment/business_logic/homepage/categories_state.dart';
import 'package:doctor_appointment/constants/colors.dart';
import 'package:doctor_appointment/constants/imageasset.dart';
import 'package:doctor_appointment/link_api.dart';
import 'package:doctor_appointment/presentation/screens/doctors/doctorcategories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AvaillableCategory extends StatelessWidget {
  const AvaillableCategory({super.key});

  @override
  Widget build(BuildContext context) {
    //final cubit = BlocProvider.of<CategoriesCubit>(context, listen: true);
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        if (state is CategoriesLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is CategoriesLoaded) {
          return SizedBox(
            height: 120,
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: state.listCategoriesLoaded.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder:
                            (context) => DoctorCategoriesDetails(
                              categoryId:
                                  state.listCategoriesLoaded[index].categoryId,
                            ),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Container(
                          height: 100.0,
                          width: 120.0,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: (MyColors.bg03),
                          ),

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Center(
                                child: FadeInImage.assetNetwork(
                                  placeholder:
                                      AppImageAsset
                                          .loadingAssetImage, //"assets/images/loading.gif",
                                  image:
                                      "${AppLink.viewCategoriesImages}/${state.listCategoriesLoaded[index].categoryImage}",

                                  height: 60,
                                  width: 70,

                                  fit: BoxFit.fitHeight,
                                  color: Colors.redAccent,
                                ),
                              ),
                              const Spacer(),
                              Expanded(
                                child: Text(
                                  textAlign: TextAlign.center,
                                  "${state.listCategoriesLoaded[index].categoryName}",
                                  style: const TextStyle(
                                    color: (MyColors.header01),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        } else {
          return Center(child: Text("Failed to load data"));
        }
      },
    );
  }
}
