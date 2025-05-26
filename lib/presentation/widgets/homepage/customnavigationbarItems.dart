import 'package:app_settings/app_settings.dart';
import 'package:doctor_appointment/constants/notifications.dart';
import 'package:doctor_appointment/constants/showalertdialog.dart';
import 'package:doctor_appointment/presentation/screens/doctors/availablespecialist.dart';
import 'package:doctor_appointment/presentation/screens/settings/settingprofile.dart';
import 'package:flutter/material.dart';
import 'package:doctor_appointment/constants/colors.dart';
import 'package:doctor_appointment/presentation/screens/HomeTab.dart';
import 'package:doctor_appointment/presentation/screens/schedule/ScheduleTab.dart';
import 'package:flutter_offline/flutter_offline.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

List<Map> navigationBarItems = [
  {'icon': Icons.home, 'index': 0, "label": "Home"},
  {'icon': Icons.group_rounded, 'index': 1, "label": "Doctors"}, // doctors
  {
    'icon': Icons.calendar_today,
    'index': 2,
    "label": "Appointments",
  }, // calender = appointment
  {'icon': Icons.person, 'index': 3, "label": "Profile"}, // profile
];

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  void goToSchedule(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    startOnInital(context, "appointment");
    myRequestPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      const HomeTab(),
      const AvailableSpecialist(),
      // Add more screens as needed
      const ScheduleTab(),
      const ProfileScreen(),
    ];

    return OfflineBuilder(
      connectivityBuilder: (
        BuildContext context,
        List<ConnectivityResult> connectivity,
        Widget child,
      ) {
        final bool connected = !connectivity.contains(ConnectivityResult.none);
        if (!connected) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            // final messenger = ScaffoldMessenger.maybeOf(context);
            // if (messenger != null && mounted) {
            //   messenger.showSnackBar(
            //     const SnackBar(content: Text("No internet connection")),
            //   );
            // }
            if (mounted) {
              functionShowAlertDialog(
                context,
                "Connection Failed",
                "Please Check Your Internet Connection",
                "OK",
                "Setting",
                () {
                  Navigator.of(context).pop();
                },
                () {
                  AppSettings.openAppSettings(type: AppSettingsType.wifi);
                  Navigator.of(context).pop();
                },
              );
            }
          });

          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.signal_wifi_off, size: 60, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No Internet Connection',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            ),
          );
        }
        return child;
      },
      child: customLoadedScreen(screens),
    );
  }

  Widget customLoadedScreen(List<Widget> screens) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: (MyColors.primary),
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: SafeArea(child: screens[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 0,
        selectedItemColor: (MyColors.primary),
        showSelectedLabels: true,
        showUnselectedLabels: false,
        //backgroundColor: Color(MyColors.grey01),
        items: [
          for (var navigationBarItem in navigationBarItems)
            BottomNavigationBarItem(
              activeIcon: Container(
                margin: const EdgeInsets.symmetric(horizontal: 3.0),
                height: 40.0,
                //width: 120.0,
                decoration: BoxDecoration(
                  color:
                      _selectedIndex == navigationBarItem['index']
                          ? (MyColors.header01) //blue.shade900
                          : (Colors.yellow),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        icon: Icon(
                          navigationBarItem['icon'],
                          size: 20,
                          color: Colors.white,
                        ), // Explicitly white

                        label: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(right: 0.0),
                          child: Text(
                            "${navigationBarItem['label']}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                            ),
                          ),
                        ), // Explicitly white
                        onPressed: () {
                          // Already selected, do nothing or refresh?
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).hoverColor, //hoverColor
                          padding: EdgeInsets.only(
                            right: _selectedIndex == 2 ? 0.0 : 20.0,
                            left: _selectedIndex == 2 ? 5.0 : 20.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              5.0,
                            ), // Adjust radius
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              icon: Container(
                height: 40,
                decoration: BoxDecoration(
                  border: Border(
                    bottom:
                        _selectedIndex == navigationBarItem['index']
                            ? const BorderSide(color: (MyColors.bg), width: 5)
                            : BorderSide.none,
                  ),
                ),
                child: Icon(
                  navigationBarItem['icon'],
                  color:
                      _selectedIndex == navigationBarItem['index']
                          ? (MyColors.bg)
                          : (MyColors.purple01),
                ),
              ),
              label: '',
            ),
        ],
        currentIndex: _selectedIndex,
        onTap: (value) {
          goToSchedule(value);
        },
      ),
    );
  }
}


//  showDialog(
//               context: context,
//               barrierDismissible: false,
//               builder: (context) {
//                 return AlertDialog(
//                   backgroundColor: MyColors.bg03,
//                   title: Text(textAlign: TextAlign.center, "Connection Failed"),
//                   content: Text("Please Check Your Internet Connection"),
//                   actions: [
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                       child: const Text("OK"),
//                     ),
//                     const SizedBox(width: 50.0),
//                     ElevatedButton(
//                       onPressed: () {
//                         AppSettings.openAppSettings(type: AppSettingsType.wifi);
//                       },
//                       child: const Text("Setting"),
//                     ),
//                   ],
//                 );
//               },
//             )