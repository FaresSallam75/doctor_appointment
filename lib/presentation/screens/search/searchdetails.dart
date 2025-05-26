import 'package:doctor_appointment/business_logic/doctors/doctor_cubit.dart';
import 'package:doctor_appointment/business_logic/doctors/doctor_state.dart';
import 'package:doctor_appointment/constants/colors.dart';
import 'package:doctor_appointment/constants/customexternalicon.dart';
import 'package:doctor_appointment/constants/imageasset.dart';
import 'package:doctor_appointment/constants/route.dart';
import 'package:doctor_appointment/constants/styles.dart';
import 'package:doctor_appointment/data/model/doctormodel.dart';
import 'package:doctor_appointment/data/model/search.dart';
import 'package:doctor_appointment/link_api.dart';
import 'package:doctor_appointment/presentation/screens/doctors/doctor_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class ListDoctorSearchScreen extends StatefulWidget {
  String? search;
  ListDoctorSearchScreen({super.key, this.search});

  @override
  State<ListDoctorSearchScreen> createState() => _ListDoctorSearchScreenState();
}

class _ListDoctorSearchScreenState extends State<ListDoctorSearchScreen> {
  @override
  void initState() {
    context.read<DoctorCubit>().getSearchedDoctors(widget.search!);
    super.initState();
  }

  goToDoctorDetailsPage(
    BuildContext context,
    SearchedDoctorModel listDoctorModel,
  ) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => BlocProvider.value(
              value: BlocProvider.of<DoctorCubit>(context),
              child: DoctorDetails(
                listDoctorModel: DoctorModel.fromJson(listDoctorModel.toJson()),
              ),
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final cubit = BlocProvider.of<DoctorCubit>(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8), // Light background color
      appBar: _buildAppBar(context),
      body: BlocBuilder<DoctorCubit, DoctorState>(
        builder: (context, state) {
          if (state is DoctorStateLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is DoctorStateLoaded) {
            return ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildSectionHeader('All Cardiologist', () {
                  // TODO: Implement See All logic for Cardiologists
                  print('See All Cardiologists tapped');
                }),
                const SizedBox(height: 10),
                // Use ListView.builder if list is very long
                ...context.read<DoctorCubit>().listSearchedDoctorModel.map(
                  (doctor) => _buildDoctorCard(
                    context,
                    doctor,
                    state.listSearchedDoctorModel,
                  ),
                ),

                const SizedBox(height: 24),

                _buildSectionHeader('Available Doctor', () {
                  // TODO: Implement See All logic for Available Doctors
                  print('See All Available Doctors tapped');
                }),
                const SizedBox(height: 10),
                // _buildAvailableDoctorList(context),
              ],
            );
          } else {
            return Center(
              child: Column(
                children: [
                  Image.asset(AppImageAsset.noDataImage),
                  // AssetImage("assets/images/nodata.gif"),
                  Text("No Data ..."),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor:
          Colors.transparent, // Make it transparent to use Scaffold bg
      elevation: 0,
      leading: BackButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AppRotes.searchSpecialistScreen);
        },
        color: Colors.black,
      ),
      // leading: IconButton(
      //   icon: const Icon(Icons.arrow_back, color: Colors.black54),
      //   onPressed: () => Navigator.of(context).pop(),
      // ),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 5),
          // Text(
          //   'Selected area',
          //   style: meduimStyle..copyWith(color: MyColors.secondColor),
          // ),
          SizedBox(height: 2),
          Text(
            textAlign: TextAlign.center,

            'Selected area \n  Boston',
            style: meduimStyle.copyWith(color: MyColors.black, height: 1.4),
          ),
        ],
      ),
      centerTitle: true,

      actions: [
        IconButton(
          // size: 20.0
          icon: const Icon(MyFlutterApp.chat, color: Colors.black54),
          onPressed: () {
            // TODO: Implement chat action
            print('Chat icon tapped');
          },
        ),
        const SizedBox(width: 8), // Add some padding to the right
      ],
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onSeeAll) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        TextButton(
          onPressed: onSeeAll,
          child: const Text(
            'See All',
            style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDoctorCard(
    BuildContext context,
    SearchedDoctorModel doctor,
    List<SearchedDoctorModel> listSearchedDoctorModel,
  ) {
    // Use a slightly different background color for the image based on the image path
    // This is a simple way to mimic the different background colors in the screenshot
    Color imageBgColor = Colors.blue.shade100; // Default blueish
    if (doctor.doctorImage!.contains('doctor2')) {
      imageBgColor = Colors.green.shade100;
    }
    if (doctor.doctorImage!.contains('doctor3')) {
      imageBgColor = Colors.orange.shade100;
    }
    if (doctor.doctorImage!.contains('doctor4')) {
      imageBgColor = Colors.purple.shade100;
    }

    return GestureDetector(
      onTap: () {
        goToDoctorDetailsPage(
          context,
          SearchedDoctorModel.fromJson(doctor.toJson()),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // Doctor Image with Background
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: imageBgColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ClipRRect(
                // Clip the image itself if it's not perfectly square
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  "${AppLink.viewDoctorsImages}/${doctor.doctorImage!}",
                  fit: BoxFit.cover, // Adjust fit as needed
                  errorBuilder:
                      (context, error, stackTrace) => const Center(
                        child: Icon(Icons.person, color: Colors.grey),
                      ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Doctor Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor.doctorName!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    //${doctor.qualifications}
                    '${doctor.specialization}',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 14,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        // doctor.availability
                        "12:00pm - 4:00pm",
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                      const SizedBox(width: 10), // Space before location
                      Icon(
                        Icons.location_on_outlined,
                        size: 14,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        // Prevents overflow if clinic name is long
                        child: Text(
                          //doctor.clinic
                          "New City Clinic",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}





  // Widget _buildAvailableDoctorList(BuildContext context) {
  //   // Horizontal list for Available Doctors
  //   return SizedBox(
  //     height: 160, // Adjust height as needed for the card size
  //     child: ListView.builder(
  //       scrollDirection: Axis.horizontal,
  //       itemCount: context.read<DoctorCubit>().listDoctorModel.length,
  //       // availableDoctors.length,
  //       itemBuilder: (context, index) {
  //         return _buildAvailableDoctorCard(
  //           context,
  //           context.read<DoctorCubit>().listDoctorModel[index],
  //         );
  //         // return _buildAvailableDoctorCard(context, availableDoctors[index]);
  //       },
  //     ),
  //   );
  // }

  // Widget _buildAvailableDoctorCard(
  //   BuildContext context,
  //   DoctorModel doctorModel,
  // ) {
  //   return Container(
  //     width: 140, // Fixed width for horizontal cards
  //     margin: const EdgeInsets.only(right: 12.0),
  //     padding: const EdgeInsets.all(12.0),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(15.0),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.grey.withOpacity(0.1),
  //           spreadRadius: 1,
  //           blurRadius: 5,
  //           offset: const Offset(0, 3),
  //         ),
  //       ],
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         // Doctor Name
  //         Text(
  //           doctorModel.doctorName!,
  //           style: const TextStyle(
  //             fontSize: 14,
  //             fontWeight: FontWeight.bold,
  //             color: Colors.black87,
  //           ),
  //           maxLines: 1,
  //           overflow: TextOverflow.ellipsis,
  //         ),
  //         const SizedBox(height: 4),
  //         // Specialty
  //         Text(
  //           doctorModel.specialization!,
  //           style: TextStyle(fontSize: 11, color: Colors.grey[600]),
  //           maxLines: 1,
  //           overflow: TextOverflow.ellipsis,
  //         ),
  //         const SizedBox(height: 8),
  //         // Placeholder for rating (using icons as dots)
  //         Row(
  //           children: List.generate(
  //             5,
  //             (index) =>
  //                 Icon(Icons.star, color: Colors.amber.shade400, size: 14),
  //           ),
  //         ),
  //         const Spacer(), // Pushes image to the bottom if needed, or adjust layout
  //         // Image aligned to the right bottom (or adjust as needed)
  //         Align(
  //           alignment: Alignment.bottomRight,
  //           child: ClipRRect(
  //             borderRadius: BorderRadius.circular(25.0), // Make it circular
  //             child: Image.network(
  //               doctorModel.doctorImage!,
  //               height: 50, // Adjust size for smaller card
  //               width: 50,
  //               fit: BoxFit.cover,
  //               errorBuilder:
  //                   (context, error, stackTrace) => const CircleAvatar(
  //                     radius: 25,
  //                     child: Icon(Icons.person),
  //                   ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
