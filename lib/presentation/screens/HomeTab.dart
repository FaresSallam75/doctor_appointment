import 'package:doctor_appointment/business_logic/doctors/doctor_cubit.dart';
import 'package:doctor_appointment/business_logic/homepage/appointment_cubit.dart';
import 'package:doctor_appointment/business_logic/homepage/categories_cubit.dart';
import 'package:doctor_appointment/constants/customexternalicon.dart';
import 'package:doctor_appointment/constants/location.dart';
import 'package:doctor_appointment/constants/route.dart';
import 'package:doctor_appointment/main.dart';
import 'package:doctor_appointment/presentation/widgets/homepage/appointmentscard.dart';
import 'package:doctor_appointment/presentation/widgets/homepage/availlablecategories.dart';
import 'package:doctor_appointment/presentation/widgets/homepage/carddoctors.dart';
import 'package:doctor_appointment/presentation/widgets/homepage/customuserinfo.dart';
import 'package:doctor_appointment/presentation/widgets/homepage/topdoctorscard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_appointment/constants/callservices.dart';

goToCardChatPage(BuildContext context) async {
  Navigator.of(context).pushNamed(AppRotes.chatListScreen);
}

goToSearchPage(BuildContext context) async {
  Navigator.pushNamed(context, AppRotes.searchSpecialistScreen);
}

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  CallServices callServices = CallServices();

  @override
  void initState() {
    context.read<DoctorCubit>().getAllDoctors();
    context.read<CategoriesCubit>().fetchCategories();
    context.read<AppointmentCubit>().getViewAppointmentsData();
    context.read<DoctorCubit>().viewRatingDoctor();
    initAll();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> initAll() async {
    await updateCurrentUser();
    await callServices.onUserLogin(
      myBox!.get("userId").toString(),
      myBox!.get("userName"),
    );
  }

  updateCurrentUser() async {
    await requestPermissionLocation(context);
    await getCurrentUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          children: [
            const SizedBox(height: 20),
            UserIntro(
              one: "Find Your",
              two: "Specialist",
              onPressedSearch: () {
                goToSearchPage(context);
              },
              onPressedChat: () {
                goToCardChatPage(context);
              },
            ),
            const SizedBox(height: 20),
            CustomCardDoctors(),
            const SizedBox(height: 20),
            defaultTitle("Categories", "See All"),
            const AvaillableCategory(),
            const SizedBox(height: 20),
            defaultTitle("Coming Appointment", "See All"),
            const AppointmentCard(),
            const SizedBox(height: 20),
            defaultTitle("Top Doctor", "See All"),
            const SizedBox(height: 20),
            const TopDoctorCard(),
          ],
        ),
      ),
    );
  }
}
