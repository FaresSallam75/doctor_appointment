// ignore_for_file: must_be_immutable

import 'package:doctor_appointment/business_logic/homepage/appointment_cubit.dart';
import 'package:doctor_appointment/data/model/doctormodel.dart';
import 'package:doctor_appointment/main.dart';
import 'package:doctor_appointment/presentation/widgets/appointment/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart'; // Make sure you have: flutter pub add intl
import 'dart:math'; // Import math for max function

class AppointmentScreen extends StatefulWidget {
  DoctorModel? listDoctorModel;
  bool? isEditing;
  AppointmentScreen({super.key, this.listDoctorModel, this.isEditing});

  @override
  // ignore: library_private_types_in_public_api
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  late DateTime _selectedDate;
  int? _selectedTimeSlotIndex;

  final List<String> timeSlots = [
    '08:00',
    '09:00',
    '10:00',
    '11:00', // AM
    '12:00',
    '13:00',
    '14:00',
    '15:00',
    '16:00',
    '17:00',
    '18:00',
    '19:00',
    '20:00',
    '21:00',
    '22:00',
    '23:00',
    '00:00',
  ];

  late List<DateTime> _daysInMonth;
  late DateTime _today;
  // ignore: unused_field
  late DateTime _firstDayOfCurrentMonth;
  late String _currentMonthName;

  final ScrollController _dateScrollController = ScrollController();
  final double _dateChipWidth = 65.0;
  final double _dateChipSpacing = 10.0;

  @override
  void initState() {
    super.initState();

    _initializeDates();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _scrollToSelectedDate(),
    );
  }

  @override
  void dispose() {
    _dateScrollController.dispose();
    super.dispose();
  }

  updateSelected() {
    if (widget.isEditing! == false) {
      widget.isEditing = true;
    } else {
      widget.isEditing = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AppointmentCubit>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Appointment'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _currentMonthName,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 15),

            SingleChildScrollView(
              controller: _dateScrollController,
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    _daysInMonth.map((date) => _buildDateChip(date)).toList(),
              ),
            ),
            const SizedBox(height: 30),

            Text(
              'Slots',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 15),

            Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: List.generate(timeSlots.length, (index) {
                return _buildTimeSlotChip(index);
              }),
            ),

            const Spacer(),

            if (!widget.isEditing!)
              CustomElevetedButtonReschedule(
                onPressed:
                    (_selectedTimeSlotIndex != null)
                        ? () {
                          setState(() {
                            widget.isEditing = true;
                          });
                          print(
                            "time ======= ${timeSlots[_selectedTimeSlotIndex!]}",
                          );

                          print(
                            "date ======= ${DateFormat('yyyy-MM-dd').format(_selectedDate)}",
                          );
                          cubit.addAppoinment(
                            widget.listDoctorModel!.doctorId!,
                            myBox!.get("userId").toString(),
                            "${DateFormat('yyyy-MM-dd').format(_selectedDate)} ${timeSlots[_selectedTimeSlotIndex!]}",
                            context,
                          );
                          updateSelected();
                        }
                        : null,
                text: 'Confirm Appointment',
              ),
            SizedBox(height: 10.0),
            if (widget.isEditing!)
              CustomElevetedButtonReschedule(
                onPressed:
                    (_selectedTimeSlotIndex != null)
                        ? () {
                          cubit.editAppoinment(
                            myBox!.get("userId").toString(),
                            widget.listDoctorModel!.doctorId!,
                            "${DateFormat('yyyy-MM-dd').format(_selectedDate)} ${timeSlots[_selectedTimeSlotIndex!]}",
                            context,
                          );
                        }
                        : null,
                text: 'Edit Appointment',
              ),
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildDateChip(DateTime date) {
    bool isSelected = _isSameDay(_selectedDate, date);
    bool isBeforeToday = date.isBefore(_today) && !_isSameDay(date, _today);

    String day = DateFormat('d').format(date);
    String weekday = DateFormat('E').format(date);
    Color backgroundColor;
    Color textColor;
    Color weekdayColor;

    if (isBeforeToday) {
      backgroundColor = Colors.grey[200]!;
      textColor = Colors.grey[500]!;
      weekdayColor = Colors.grey[400]!;
    } else if (isSelected) {
      backgroundColor = const Color(0xFF1E63E9);
      textColor = Colors.white;
      weekdayColor = Colors.white70;
    } else {
      backgroundColor = Colors.white;
      textColor = Colors.black87;
      weekdayColor = Colors.grey[600]!;
    }

    return GestureDetector(
      onTap:
          isBeforeToday
              ? null
              : () {
                setState(() {
                  _selectedDate = date;

                  _selectedTimeSlotIndex = null;
                });

                print("selected date ============== $_selectedDate");
                _scrollToSelectedDate();
              },
      child: Container(
        width: _dateChipWidth,
        margin: EdgeInsets.only(right: _dateChipSpacing),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow:
              (isSelected || isBeforeToday)
                  ? []
                  : [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 1),
                    ),
                  ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              day,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(weekday, style: TextStyle(fontSize: 14, color: weekdayColor)),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeSlotChip(int index) {
    bool isSelected = _selectedTimeSlotIndex == index;
    String time = timeSlots[index];

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTimeSlotIndex = index;
        });
        print("_selectedTimeSlot ===============$time");
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1E63E9) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow:
              !isSelected
                  ? [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 1),
                    ),
                  ]
                  : [],
        ),
        child: Text(
          time,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }

  void _initializeDates() {
    _today = DateTime.now();
    _today = DateTime(_today.year, _today.month, _today.day);

    _firstDayOfCurrentMonth = DateTime(_today.year, _today.month, 1);
    _currentMonthName = DateFormat('MMMM', 'en_US').format(_today);

    DateTime firstDayOfNextMonth = DateTime(_today.year, _today.month + 1, 1);
    DateTime lastDayOfCurrentMonth = firstDayOfNextMonth.subtract(
      const Duration(days: 1),
    );
    int daysInMonth = lastDayOfCurrentMonth.day;

    _daysInMonth = List.generate(
      daysInMonth,
      (index) => DateTime(_today.year, _today.month, index + 1),
    );

    _selectedDate = _today;
    _selectedTimeSlotIndex = null;
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  void _scrollToSelectedDate() {
    if (!_dateScrollController.hasClients) {
      return;
    }

    int selectedIndex = _daysInMonth.indexWhere(
      (date) => _isSameDay(date, _selectedDate),
    );

    if (selectedIndex != -1) {
      double targetOffset =
          (selectedIndex * (_dateChipWidth + _dateChipSpacing)) -
          (context.size?.width ?? 300) / 3;

      targetOffset = max(0.0, targetOffset);
      targetOffset = min(
        targetOffset,
        _dateScrollController.position.maxScrollExtent,
      );

      _dateScrollController.animateTo(
        targetOffset,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }
}
