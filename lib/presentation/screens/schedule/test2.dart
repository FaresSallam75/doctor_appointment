// import 'package:doctor_appointment/business_logic/doctors/doctor_cubit.dart';
// import 'package:doctor_appointment/business_logic/homepage/appointment_cubit.dart';
// import 'package:doctor_appointment/business_logic/homepage/appointment_state.dart';
// import 'package:doctor_appointment/constants/bottomsheet.dart';
// import 'package:doctor_appointment/constants/dialog_rating.dart';
// import 'package:doctor_appointment/main.dart';
// import 'package:doctor_appointment/presentation/screens/schedule/appointment.dart';
// import 'package:doctor_appointment/presentation/widgets/appointment/custombodyappointments.dart';
// import 'package:doctor_appointment/presentation/widgets/appointment/custombutton.dart';
// import 'package:doctor_appointment/presentation/widgets/appointment/customdatetimecard.dart';
// import 'package:doctor_appointment/presentation/widgets/appointment/customlistappointments.dart';
// import 'package:flutter/material.dart';
// import 'package:doctor_appointment/constants/colors.dart';
// import 'package:doctor_appointment/constants/styles.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:jiffy/jiffy.dart';

// class ScheduleTab extends StatefulWidget {
//   const ScheduleTab({super.key});

//   @override
//   State<ScheduleTab> createState() => _ScheduleTabState();
// }

// class _ScheduleTabState extends State<ScheduleTab> {
//   List<String> appointmentsStatus = [
//     "Upcoming",
//     "Approved",
//     "Cancelled",
//     "Completed",
//     "Rating",
//   ];
//   int selectedIndex = 0;
//   bool isRating = false;
//   List? getRatedUserId;
//   String? getUserId;
//   String? getDoctorId;

//   @override
//   void initState() {
//     context.read<AppointmentCubit>().getViewAppointmentsData();
//     // context.read<AppointmentCubit>().autoDeleteAppoinments();
//     // if (context.read<AppointmentCubit>().listRatingDoctors.isNotEmpty) {
//     //   context.read<AppointmentCubit>().viewRatingDoctor();
//     // }
//     context.read<DoctorCubit>().viewRatingDoctor();
//     context.read<AppointmentCubit>().refreshAppointments();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cubit = BlocProvider.of<DoctorCubit>(context);
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.only(left: 30, top: 30, right: 30),
//         child: Column(
//           children: [
//             Text(
//               'My Appointment',
//               textAlign: TextAlign.center,
//               style: kTitleStyle,
//             ),
//             const SizedBox(height: 20),
//             CustomListAppointments(
//               child: ListView.separated(
//                 separatorBuilder:
//                     (context, index) => const SizedBox(width: 0.0),
//                 scrollDirection: Axis.horizontal,
//                 itemCount: appointmentsStatus.length,
//                 itemBuilder: (context, index) {
//                   return Appointments(
//                     text: appointmentsStatus[index],
//                     isSelected: selectedIndex == index,
//                     onTap: () {
//                       setState(() {
//                         selectedIndex = index;
//                       });
//                     },
//                   );
//                 },
//               ),
//             ),

//             BlocBuilder<AppointmentCubit, AppointmentState>(
//               builder: (context, state) {
//                 if (state is AppointmentStateLoading) {
//                   return const Column(
//                     children: [
//                       Align(
//                         alignment: Alignment.center,
//                         child: CircularProgressIndicator(
//                           color: MyColors.secondColor,
//                         ),
//                       ),
//                     ],
//                   );
//                 } else if (state is AppointmentStateLoaded) {
//                   final filteredAppointments =
//                       state.appointments.where((appointment) {
//                         return appointment.appointmentStatus ==
//                             selectedIndex.toString();
//                       }).toList();

//                   getRatedUserId =
//                       cubit.listRatingDoctors.where((check) {
//                         getUserId = check['user_id'].toString();
//                         getDoctorId = check['doctor_id'].toString();
//                         return true; // or add your actual condition here
//                       }).toList();

//                   return Expanded(
//                     child: ListView.builder(
//                       itemCount: filteredAppointments.length,
//                       itemBuilder: (context, index) {
//                         final appointment = filteredAppointments[index];
//                         bool isLastElement =
//                             filteredAppointments.length + 1 == index;
//                         return Card(
//                           margin:
//                               !isLastElement
//                                   ? const EdgeInsets.only(bottom: 20)
//                                   : EdgeInsets.zero,
//                           child: Padding(
//                             padding: const EdgeInsets.all(15),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.stretch,
//                               children: [
//                                 // if (selectedIndex == 2)
//                                 CustomBodyAppointments(
//                                   appointmentStatus:
//                                       appointment.appointmentStatus!,
//                                   isCancel:
//                                       selectedIndex == 2 || selectedIndex == 3
//                                           ? false
//                                           : true,
//                                   doctorImage: "${appointment.doctorImage}",
//                                   doctorName: appointment.doctorName!,
//                                   doctorSpecialization:
//                                       appointment.specialization!,
//                                   appointmentDate: appointment.appointmentDate!,
//                                 ),
//                                 const SizedBox(height: 15),

//                                 if (selectedIndex == 0 || selectedIndex == 1)
//                                   DateTimeCard(
//                                     date:
//                                         Jiffy.parse(
//                                           appointment.appointmentDate!,
//                                         ).yMMMEd,
//                                     time:
//                                         Jiffy.parse(
//                                           appointment.appointmentDate!,
//                                         ).jm,
//                                   ),
//                                 const SizedBox(height: 15),

//                                 selectedIndex == 1
//                                     ? CustomElvatedButton(
//                                       text: "Pay",
//                                       onPressedDelete: () {
//                                         customModalBottomSheet(context);
//                                         print("pay online");
//                                       },
//                                     )
//                                     : selectedIndex == 2
//                                     ? CustomElvatedButton(
//                                       text: "Delete",
//                                       onPressedDelete: () {
//                                         print("Delete Cancel Appointment");
//                                       },
//                                     )
//                                     : selectedIndex == 3
//                                     ? CustomElvatedButton(
//                                       text: "Rating",
//                                       onPressedDelete: () {
//                                         showDialogRating(context, (response) {
//                                           if (getUserId.toString() ==
//                                                   myBox!
//                                                       .get("userId")
//                                                       .toString() &&
//                                               getDoctorId.toString() ==
//                                                   myBox!
//                                                       .get(appointment.doctorId)
//                                                       .toString()) {
//                                             ScaffoldMessenger.of(
//                                               context,
//                                             ).showSnackBar(
//                                               SnackBar(
//                                                 content: Text(
//                                                   "You Already Rated This Dector Brfore",
//                                                 ),
//                                               ),
//                                             );
//                                           } else {
//                                             context
//                                                 .read<DoctorCubit>()
//                                                 .ratingDoctor(
//                                                   appointment.doctorId!,
//                                                   response.comment,
//                                                   response.rating.toString(),
//                                                 );
//                                           }

//                                           myBox!.put(
//                                             appointment.doctorId,
//                                             appointment.doctorId,
//                                           );
//                                           print(
//                                             "get doctor id ==== ${myBox!.get(appointment.doctorId)}",
//                                           );
//                                           setState(() {
//                                             isRating = true;
//                                           });
//                                         });
//                                       },
//                                     )
//                                     : selectedIndex != 4
//                                     ? CustomButtonAppointment(
//                                       onPressedOk: () {
//                                         context
//                                             .read<AppointmentCubit>()
//                                             .cancelAppointment(
//                                               appointment.doctorId!,
//                                             );
//                                         Navigator.pop(context);
//                                       },
//                                       onPressedCancel: () {
//                                         Navigator.pop(context);
//                                       },
//                                       onPressedReschedule: AppointmentScreen(
//                                         listDoctorModel:
//                                             context
//                                                 .read<DoctorCubit>()
//                                                 .listDoctorModel[index],
//                                         isEditing: true,
//                                       ),
//                                     )
//                                     : Container(),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 } else if (state is AppointmentStateError) {
//                   return Center(child: Text("No appointments available"));
//                 } else {
//                   return const Center(
//                     child: Text("Check Your Internet Connection ..."),
//                   );
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
