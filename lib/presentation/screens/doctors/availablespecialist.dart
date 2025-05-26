import 'package:doctor_appointment/business_logic/doctors/doctor_cubit.dart';
import 'package:doctor_appointment/business_logic/doctors/doctor_state.dart';
import 'package:doctor_appointment/constants/colors.dart';
import 'package:doctor_appointment/constants/imageasset.dart';
import 'package:doctor_appointment/constants/route.dart';
import 'package:doctor_appointment/data/model/doctormodel.dart';
import 'package:doctor_appointment/link_api.dart';
import 'package:doctor_appointment/presentation/screens/doctors/doctor_detail.dart';
import 'package:doctor_appointment/presentation/widgets/homepage/customuserinfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AvailableSpecialist extends StatefulWidget {
  const AvailableSpecialist({super.key});

  @override
  State<AvailableSpecialist> createState() => _AvailableSpecialistState();
}

class _AvailableSpecialistState extends State<AvailableSpecialist> {
  @override
  void initState() {
    context.read<DoctorCubit>().getAllDoctors();
    context.read<DoctorCubit>().refreshPage();
    super.initState();
  }

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

  goToCardChatPage(BuildContext context) async {
    Navigator.of(context).pushNamed(AppRotes.chatListScreen);
  }

  goToSearchPage(BuildContext context) async {
    Navigator.pushNamed(context, AppRotes.searchSpecialistScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF4FF),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: UserIntro(
            one: "Available",
            two: "Specialist",
            onPressedSearch: () {
              goToSearchPage(context);
            },
            onPressedChat: () {
              goToCardChatPage(context);
            },
          ),
        ),
      ),
      body: BlocBuilder<DoctorCubit, DoctorState>(
        builder: (context, state) {
          if (state is DoctorStateLoading) {
            return const Center(
              child: CircularProgressIndicator(color: MyColors.secondColor),
            );
          } else if (state is DoctorStateLoaded) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                itemCount: context.read<DoctorCubit>().listDoctorModel.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.0,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      goToDoctorDetailsPage(
                        context,
                        state.listDoctorModel[index],
                      );
                    },
                    child: DoctorCard(
                      name: "Dr ${state.listDoctorModel[index].doctorName}",
                      speciality:
                          "${state.listDoctorModel[index].specialization}\n Specialist",
                      experience:
                          "${state.listDoctorModel[index].experience} Years",
                      patients: "2.7K",
                      imageUrl:
                          "${AppLink.viewDoctorsImages}/${state.listDoctorModel[index].doctorImage}",
                    ),
                  );
                },
              ),
            );
          } else if (state is DoctorStateNoInternet) {
            return const Center(
              child: Text("Please Check Your Internet Connectivity ..."),
            );
          } else {
            return const Center(child: Text("No Loading Data ..."));
          }
        },
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  final String name, speciality, experience, patients, imageUrl;

  const DoctorCard({
    super.key,
    required this.name,
    required this.speciality,
    required this.experience,
    required this.patients,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(speciality, style: const TextStyle(fontSize: 12)),
              const SizedBox(height: 8),
              Text("Experience", style: TextStyle(color: Colors.grey[600])),
              Text(
                experience,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 8),
              Text("Patients", style: TextStyle(color: Colors.grey[600])),
              Text(
                patients,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              const Spacer(),
            ],
          ),
          Expanded(
            child: FadeInImage.assetNetwork(
              placeholder:
                  AppImageAsset
                      .loadingAssetImage, //"assets/images/loading.gif",
              image: imageUrl,
              fit: BoxFit.fitWidth,
            ),
          ),
        ],
      ),
    );
  }
}
