// ignore_for_file: must_be_immutable, use_build_context_synchronously
import 'package:doctor_appointment/business_logic/doctors/doctor_cubit.dart';
import 'package:doctor_appointment/constants/callservices.dart';
import 'package:doctor_appointment/constants/imageasset.dart';
import 'package:doctor_appointment/constants/location.dart';
import 'package:doctor_appointment/constants/route.dart';
import 'package:doctor_appointment/data/model/doctormodel.dart';
import 'package:doctor_appointment/link_api.dart';
import 'package:doctor_appointment/main.dart';
import 'package:doctor_appointment/presentation/screens/schedule/appointment.dart';
import 'package:doctor_appointment/presentation/screens/chat/message.dart';
import 'package:flutter/material.dart';
import 'package:doctor_appointment/constants/colors.dart';
import 'package:doctor_appointment/constants/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class DoctorDetails extends StatefulWidget {
  DoctorModel? listDoctorModel;
  DoctorDetails({super.key, this.listDoctorModel});

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  CallServices callServices = CallServices();

  @override
  void initState() {
    context.read<DoctorCubit>().getDoctorDetails(
      widget.listDoctorModel!.doctorId!,
    );
    refrshMethod();
    super.initState();
  }

  refrshMethod() async {
    await Future.delayed(const Duration(seconds: 3));
    setState(() {});
  }

  @override
  void dispose() {
    if (positionStream != null) {
      positionStream!.cancel();
    }
    googleMapController?.dispose();
    super.dispose();
  }

  // updateCurrentUser() async {
  //   await getCurrentUserLocation();
  //   setState(() {});
  // }

  goToPageChat(DoctorModel? listDoctorModel, String targetToken) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (context) => ChatPage(
              listDoctorModel: listDoctorModel,
              targetToken: targetToken,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<DoctorCubit>(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: MaterialButton(
        minWidth: MediaQuery.of(context).size.width - 50,
        color: MyColors.header01,
        height: 50.0,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => AppointmentScreen(
                    listDoctorModel: widget.listDoctorModel!,
                    isEditing: false,
                  ),
            ),
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Text('Book an Appointment', style: smallStyle),
      ),

      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              floating: true,
              snap: true,
              forceElevated: true,
              excludeHeaderSemantics: true,
              forceMaterialTransparency: true,
              primary: true,
              stretch: true,
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                background: FadeInImage.assetNetwork(
                  placeholder:
                      AppImageAsset
                          .loadingAssetImage, //"assets/images/loading.gif",
                  image:
                      "${AppLink.viewDoctorsImages}/${widget.listDoctorModel!.doctorImage}",
                  fit: BoxFit.contain,
                  height: 60.0,
                  width: 100.0,
                ),
              ),
              leading: IconButton(
                onPressed: () {
                  // Navigator.of(context).pop();
                  Navigator.of(context).pushReplacementNamed(AppRotes.homePage);
                },
                icon: const Icon(Icons.arrow_back, color: MyColors.header01),
              ),
            ),
            SliverToBoxAdapter(
              child: detailBody(
                "Dr. ${widget.listDoctorModel!.doctorName!}",
                widget.listDoctorModel!.specialization!,
                "${AppLink.viewDoctorsImages}/${widget.listDoctorModel!.doctorImage}",
                cubit.doctorData['degree'].toString(),
                cubit.doctorData['price'].toString(),
                cubit.doctorData['location'].toString(),
                cubit.doctorData['from_time'].toString(),
                cubit.doctorData['to_time'].toString(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget detailBody(
    final String doctorName,
    final String specialization,
    final String image,
    final String degree,
    final String price,
    final String location,
    final String startTime,
    final String endTime,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // context.read<DoctorCubit>().doctorData.entries.isEmpty
          //     ? Center(child: CircularProgressIndicator())
          //     :
          detailDoctorCard(
            doctorName: doctorName,
            specialization: specialization,
            image: image,
            degree: degree,
            price: price,
            location: location,
            startTime: startTime,
            endTime: endTime,
          ),

          const SizedBox(height: 15),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              customButton(
                MyColors.primaryColor,
                "Voice Call",
                Icons.phone,
                () {
                  callServices.onUserLogin(
                    myBox!.get("userId").toString(),
                    myBox!.get("userName"),
                  );
                  ZegoUIKitPrebuiltCallInvitationService().send(
                    resourceID: "faresZegoApp",
                    //callID: "1",
                    invitees: [
                      ZegoCallUser(
                        widget.listDoctorModel!.doctorId!,
                        "Dr ${widget.listDoctorModel!.doctorName!}",
                      ),
                    ],
                    isVideoCall: false,
                  );
                },
              ),
              const SizedBox(width: 5.0),
              customButton(
                MyColors.primary,
                "Video Call",
                Icons.video_call_outlined,
                () {
                  callServices.onUserLogin(
                    myBox!.get("userId").toString(),
                    myBox!.get("userName"),
                  );
                  ZegoUIKitPrebuiltCallInvitationService().send(
                    resourceID: "faresZegoApp",
                    //callID: "1",
                    invitees: [
                      ZegoCallUser(
                        widget.listDoctorModel!.doctorId!,
                        "Dr ${widget.listDoctorModel!.doctorName!}",
                      ),
                    ],
                    isVideoCall: true,
                  );
                },
              ),
              const SizedBox(width: 5.0),
              customButton(
                MyColors.yellow02,
                "Message",
                Icons.messenger_outline_rounded, //(MyFlutterApp.chat),
                () {
                  goToPageChat(
                    widget.listDoctorModel,
                    context.read<DoctorCubit>().doctorData['token'].toString(),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 20.0),

          const SizedBox(height: 20.0),
          doctorInfo(),

          const SizedBox(height: 30.0),
          Text('About Doctor', style: kTitleStyle),
          const SizedBox(height: 15.0),
          Text(
            'Dr ${widget.listDoctorModel!.doctorName!} is the specialist in internal medicine who specialzed .',
            style: TextStyle(
              color: (MyColors.purple01),
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 25),
          Text('Location', style: kTitleStyle),
          //const SizedBox(height: 25),
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [doctorLocation()],
          ),
        ],
      ),
    );
  }

  Widget doctorLocation() {
    return currentLocation == null
        ? const Center(child: CircularProgressIndicator())
        : Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          height: 300,
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: GoogleMap(
                  onTap: (LatLng latlang) {
                    // markers.add(
                    //   Marker(
                    //     markerId: const MarkerId("1"),
                    //     position: LatLng(latlang.latitude, latlang.longitude),
                    //   ),
                    // );
                    // setState(() {});
                  },
                  // polylines: ploylineSet,
                  markers: markers.toSet(),
                  mapType: MapType.normal,
                  initialCameraPosition: cameraPosition!,
                  onMapCreated: (GoogleMapController controllerMap) {
                    googleMapController = controllerMap;
                  },
                ),
              ),
            ],
          ),
        );
  }

  Widget doctorInfo() {
    return Row(
      children: [
        numberCard('Patients', '100K'),
        const SizedBox(width: 15),
        numberCard(
          'Experiences',
          '${widget.listDoctorModel!.experience} Years',
        ),
        const SizedBox(width: 15),
        numberCard('Rating', '4.0'),
      ],
    );
  }

  Widget numberCard(final String label, final String value) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: (MyColors.bg03),
        ),
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
        child: Column(
          children: [
            Text(
              label,
              style: const TextStyle(
                color: (MyColors.grey02),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                color: (MyColors.header01),
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customButton(
    final Color color,
    final String text,
    final IconData? icon,
    final Function() onPressed,
  ) {
    return Expanded(
      child: MaterialButton(
        height: 60.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: color,
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: MyColors.bg, size: 18.0),

            const Spacer(),
            Text(text, style: smallStyle),
          ],
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class detailDoctorCard extends StatelessWidget {
  final String doctorName;
  final String specialization;
  final String degree;
  final String price;
  final String startTime;
  final String endTime;
  final String location;
  final String image;
  const detailDoctorCard({
    super.key,
    required this.doctorName,
    required this.specialization,
    required this.degree,
    required this.price,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<DoctorCubit>(context);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: const EdgeInsets.all(15),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child:
                  cubit.listDoctorDeatils.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(doctorName, style: kTitleStyle),
                          const SizedBox(height: 5),
                          Text(
                            "$specialization  ($degree)",
                            style: smallStyle.copyWith(
                              color: MyColors.greyDark,
                            ),
                          ),
                          Text(
                            "Detection price  ($price E)",
                            style: smallStyle.copyWith(
                              color: MyColors.greyDark,
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.access_time, size: 18.0),
                              Text(
                                "$startTime - $endTime",
                                style: smallStyle.copyWith(
                                  color: MyColors.greyDark,
                                ),
                              ),
                              const SizedBox(width: 5.0),
                              const Icon(Icons.location_on_sharp, size: 18.0),
                              Text(location),
                            ],
                          ),
                        ],
                      ),
            ),
            const CircleAvatar(radius: 8.0, backgroundColor: Colors.green),
          ],
        ),
      ),
    );
  }
}
