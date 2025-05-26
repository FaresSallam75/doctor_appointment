import 'package:doctor_appointment/constants/route.dart';
import 'package:doctor_appointment/constants/styles.dart';
import 'package:doctor_appointment/data/model/doctormodel.dart';
import 'package:doctor_appointment/presentation/screens/search/searchdetails.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SearchSpecialistScreen extends StatefulWidget {
  DoctorModel? listDoctorModel;
  SearchSpecialistScreen({super.key, this.listDoctorModel});

  @override
  State<SearchSpecialistScreen> createState() => _SearchSpecialistScreenState();
}

class _SearchSpecialistScreenState extends State<SearchSpecialistScreen> {
  String? selectedArea;
  String? selectedSpecialist;
  DateTime? selectedDate;

  final List<String> areas = [
    'New York',
    'Cairo',
    'London',
    "Ebshan",
    "biyala",
    "kafr El Seikh",
    "Mansoura",
    "Tanta",
  ];
  final List<String> specialists = [
    'Cardiologist',
    'Dermatologist',
    'Pediatrician',
    'Endocrinologist',
    'Neurosurgeon',
    'Ophthalmologist',
    'Radiologist',
    'Rheumatologists',
    'Gastroenterologist',
    'Psychiatrist',
  ];

  @override
  void initState() {
    super.initState();
  }

  goToPageSearchedDoctors() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (context) => ListDoctorSearchScreen(search: selectedSpecialist!),
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Here", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(
          onPressed: () {
            Navigator.of(
              context,
            ).pushNamedAndRemoveUntil(AppRotes.homePage, (route) => false);
          },
          color: Colors.black,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        color: const Color(0xFFF5F7FC),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Search Your",
              style: TextStyle(fontSize: 20, color: Colors.black54),
            ),
            const Text(
              "Specialist",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            // Area Dropdown
            _buildDropdown(
              hint: "Select Area",
              icon: Icons.location_on_outlined,
              value: selectedArea,
              items: areas,
              onChanged: (val) => setState(() => selectedArea = val),
            ),

            const SizedBox(height: 15),

            // Specialist Dropdown
            _buildDropdown(
              hint: "Select Specialist",
              icon: Icons.medical_services_outlined,
              value: selectedSpecialist,
              items: specialists,
              onChanged: (val) => setState(() => selectedSpecialist = val),
            ),

            const SizedBox(height: 15),

            // Date Picker
            GestureDetector(
              onTap: _selectDate,
              child: Container(
                height: 55,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedDate != null
                          ? "${selectedDate!.year}/${selectedDate!.month}/${selectedDate!.day}"
                          : "Select Date",
                      style: TextStyle(
                        fontSize: 16,
                        color:
                            selectedDate != null ? Colors.black87 : Colors.grey,
                      ),
                    ),
                    const Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Search Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3366FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  // handle search logic
                  if (selectedArea == null || selectedSpecialist == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please Select Area OR Specialist ....'),
                      ),
                    );
                  } else {
                    goToPageSearchedDoctors();
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder:
                    //         (context) => ListDoctorSearchScreen(
                    //           search: selectedSpecialist!,
                    //         ),
                    //   ),
                    // );
                  }
                },
                child: Text("Search", style: meduimStyle),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String hint,
    required IconData icon,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text(hint, style: const TextStyle(fontSize: 16)),
          value: value,
          isExpanded: true,
          icon: Icon(icon, color: Colors.grey),
          onChanged: onChanged,

          items:
              items.map((e) {
                return DropdownMenuItem<String>(
                  value: e,
                  child: Text(e, style: const TextStyle(fontSize: 16)),
                );
              }).toList(),
        ),
      ),
    );
  }
}
