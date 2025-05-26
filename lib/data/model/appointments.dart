class AppointmentsModel {
  String? appointmentId;
  String? userId;
  String? appointmentDate;
  String? appointmentStatus;
  String? doctorId;
  String? doctorName;
  String? doctorEmail;
  String? doctorPassword;
  String? doctorPhone;
  String? doctorCreate;
  String? doctorImage;
  String? specialization;
  String? experience;
  String? categoryId;

  AppointmentsModel({
    this.appointmentId,
    this.userId,
    this.appointmentDate,
    this.appointmentStatus,
    this.doctorId,
    this.doctorName,
    this.doctorEmail,
    this.doctorPassword,
    this.doctorPhone,
    this.doctorCreate,
    this.doctorImage,
    this.specialization,
    this.experience,
    this.categoryId,
  });

  AppointmentsModel.fromJson(Map<String, dynamic> json) {
    appointmentId = json['appointment_id'].toString();
    userId = json['user_id'].toString();
    appointmentDate = json['appointment_date'];
    appointmentStatus = json['appointment_status'].toString();
    doctorId = json['doctor_id'].toString();
    doctorName = json['doctor_name'];
    doctorEmail = json['doctor_email'];
    doctorPassword = json['doctor_password'];
    doctorPhone = json['doctor_phone'];
    doctorCreate = json['doctor_create'];
    doctorImage = json['doctor_image'];
    specialization = json['specialization'];
    experience = json['experience'];
    categoryId = json['category_id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['appointment_id'] = appointmentId;
    data['user_id'] = userId;
    data['appointment_date'] = appointmentDate;
    data['appointment_status'] = appointmentStatus;
    data['doctor_id'] = doctorId;
    data['doctor_name'] = doctorName;
    data['doctor_email'] = doctorEmail;
    data['doctor_password'] = doctorPassword;
    data['doctor_phone'] = doctorPhone;
    data['doctor_create'] = doctorCreate;
    data['doctor_image'] = doctorImage;
    data['specialization'] = specialization;
    data['experience'] = experience;
    data['category_id'] = categoryId;
    return data;
  }
}
