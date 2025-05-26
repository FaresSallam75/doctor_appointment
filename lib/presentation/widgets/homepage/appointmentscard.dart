import 'package:doctor_appointment/business_logic/homepage/appointment_cubit.dart';
import 'package:doctor_appointment/business_logic/homepage/appointment_state.dart';
import 'package:doctor_appointment/constants/colors.dart';
import 'package:doctor_appointment/constants/styles.dart';
import 'package:doctor_appointment/link_api.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class AppointmentCard extends StatelessWidget {
  const AppointmentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentCubit, AppointmentState>(
      builder: (context, state) {
        if (state is AppointmentStateLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AppointmentStateLoaded) {
          int selectedIndex = 0;
          final filteredAppointments =
              state.appointments
                  .where(
                    (appointment) =>
                        appointment.appointmentStatus ==
                        selectedIndex.toString(),
                  )
                  .toList();

          return filteredAppointments.isEmpty
              ? SizedBox(
                height: 100.0,
                child: const Center(child: Text("No Appointments Today...")),
              )
              : SizedBox(
                height: 180.0,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: filteredAppointments.length,
                  separatorBuilder:
                      (context, index) => const SizedBox(width: 10.0),
                  itemBuilder: (context, index) {
                    final appointments = filteredAppointments[index];

                    return Jiffy.parse(appointments.appointmentDate!).date >=
                            Jiffy.parse(DateTime.now().toString()).date
                        ? Container(
                          // width: double.infinity,
                          width: MediaQuery.of(context).size.width - 45,
                          decoration: BoxDecoration(
                            color: (MyColors.primary),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            "${AppLink.viewDoctorsImages}/${appointments.doctorImage}",
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Dr ${appointments.doctorName}",
                                              style: meduimStyle,
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              "${appointments.specialization} Specialist",
                                              style: const TextStyle(
                                                color: (MyColors.text01),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),

                                    ScheduleCard(
                                      date:
                                          Jiffy.parse(
                                            appointments.appointmentDate!,
                                          ).yMMMEd, // 'Mon, July 29'
                                      time:
                                          Jiffy.parse(
                                            appointments.appointmentDate!,
                                          ).jm, // '11:00 ~ 12:10'
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                        : Container(
                          padding: const EdgeInsets.only(
                            right: 100.0,
                            left: 100.0,
                            top: 100.0,
                            //   vertical: 50.0,
                          ),
                          child: Text(
                            textAlign: TextAlign.center,
                            "No Appointments Today...",
                            // style: smallStyle.copyWith(
                            //   fontSize: 12.0,
                            //   color: Colors.green,
                            // ),
                          ),
                        );
                  },
                ),
              );
        } else {
          return const Center(child: Text("No Appointments Today..."));
        }
      },
    );
  }
}

class ScheduleCard extends StatelessWidget {
  final String date;
  final String time;
  const ScheduleCard({super.key, required this.date, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: (MyColors.bg01),
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.calendar_today, color: Colors.white, size: 15),
          const SizedBox(width: 5),
          Text(date, style: smallStyle.copyWith(fontSize: 13.0)),
          const Spacer(),
          const Icon(Icons.access_alarm, color: Colors.white, size: 17),
          const SizedBox(width: 5),
          Flexible(
            child: Text(time, style: smallStyle.copyWith(fontSize: 13.0)),
          ),
        ],
      ),
    );
  }
}


  // Container(
            //   margin: const EdgeInsets.symmetric(horizontal: 20),
            //   width: double.infinity,
            //   height: 10,
            //   decoration: const BoxDecoration(
            //     color: (MyColors.bg02),
            //     borderRadius: BorderRadius.only(
            //       bottomRight: Radius.circular(10),
            //       bottomLeft: Radius.circular(10),
            //     ),
            //   ),
            // ),
            // Container(
            //   margin: const EdgeInsets.symmetric(horizontal: 40),
            //   width: double.infinity,
            //   height: 10,
            //   decoration: const BoxDecoration(
            //     color: (MyColors.bg03),
            //     borderRadius: BorderRadius.only(
            //       bottomRight: Radius.circular(10),
            //       bottomLeft: Radius.circular(10),
            //     ),
            //   ),
            // ),