// ignore_for_file: body_might_complete_normally_nullable

import 'package:doctor_appointment/main.dart';
import 'package:doctor_appointment/presentation/screens/auth/checkemail.dart';
import 'package:doctor_appointment/presentation/screens/auth/forgetpassword.dart';
import 'package:doctor_appointment/presentation/screens/schedule/ScheduleTab.dart';
import 'package:doctor_appointment/presentation/screens/schedule/appointment.dart';
import 'package:doctor_appointment/presentation/screens/auth/login.dart';
import 'package:doctor_appointment/presentation/screens/auth/signup.dart';
import 'package:doctor_appointment/presentation/screens/chat/cardmessages.dart';
import 'package:doctor_appointment/presentation/screens/doctors/availablespecialist.dart';
import 'package:doctor_appointment/presentation/screens/chat/message.dart';
import 'package:doctor_appointment/presentation/screens/doctors/doctor_detail.dart';
import 'package:doctor_appointment/presentation/screens/doctors/doctorcategories.dart';
import 'package:doctor_appointment/presentation/screens/search/search.dart';
import 'package:doctor_appointment/presentation/screens/search/searchdetails.dart';
import 'package:doctor_appointment/presentation/screens/settings/settingprofile.dart';
import 'package:doctor_appointment/presentation/widgets/homepage/customnavigationbarItems.dart';
import 'package:doctor_appointment/constants/route.dart';
import 'package:doctor_appointment/welcome.dart';
import 'package:flutter/material.dart';

/* class AppRoute {
  late CategoriesRepositary categoriesRepositary;
  late CategoriesCubit categoriesCubit;

  late AuthRepositary authRepositary;
  late SignUpCubit signupCubit;
  late LoginCubit loginCubit;

  AppRoute() {
    categoriesRepositary = CategoriesRepositary(Crud());
    categoriesCubit = CategoriesCubit(categoriesRepositary);

    authRepositary = AuthRepositary(Crud());
    signupCubit = SignUpCubit(authRepositary);
    loginCubit = LoginCubit(authRepositary);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRotes.login:
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => LoginCubit(authRepositary),
                child:
                    myBox!.isEmpty
                        ? const Login()
                        : BlocProvider(
                          create:
                              (context) =>
                                  CategoriesCubit(CategoriesRepositary(Crud())),
                          child: const Home(),
                        ),
              ),
        );

      case AppRotes.signup:
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => SignUpCubit(authRepositary),
                child: const SignUp(),
              ),
        );

      case AppRotes.homePage:
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => CategoriesCubit(categoriesRepositary),
                child: myBox!.isEmpty ? const Login() : const Home(),
              ),
        );

      case AppRotes.scheduleTab:
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create:
                    (context) =>
                        AppointmentCubit(RepositaryAppointments(Crud())),
                child: const ScheduleTab(),
              ),
        );

      case AppRotes.doctorDetailPage:
        return MaterialPageRoute(builder: (context) => const DoctorDetail());
    }
  }
} */

Map<String, Widget Function(BuildContext)> routes = {
  AppRotes.welcomeScreen:
      (context) => myBox!.isEmpty ? const WelcomeScreen() : const Home(),
  AppRotes.login: (context) => const Login(),
  AppRotes.signup: (context) => const SignUp(),
  AppRotes.checkEmail: (context) => const CheckEmail(),
  AppRotes.forgetPassword: (context) => const ForgetPassword(),
  AppRotes.homePage: (context) => const Home(),
  AppRotes.scheduleTab: (context) => const ScheduleTab(),
  AppRotes.doctorDetailsPage: (context) => DoctorDetails(),
  AppRotes.appointment: (context) => AppointmentScreen(),
  AppRotes.settingsPage: (context) => const ProfileScreen(),
  AppRotes.chatPage: (context) => ChatPage(),
  AppRotes.doctorCategoriesDetails:
      (context) => const DoctorCategoriesDetails(),
  AppRotes.availableSpecialist: (context) => const AvailableSpecialist(),
  AppRotes.searchSpecialistScreen: (context) => SearchSpecialistScreen(),
  AppRotes.listDoctorSearchScreen: (context) => ListDoctorSearchScreen(),
  AppRotes.chatListScreen: (context) => ChatListScreen(),
};
