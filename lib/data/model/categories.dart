class CategoriesModel {
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
  String? categoryName;
  String? categoryCreate;
  String? categoryImage;

  CategoriesModel({
    this.doctorId,
    this.doctorName,
    this.doctorEmail,
    this.doctorPassword,
    this.doctorPhone,
    this.doctorCreate,
    this.doctorImage,
    this.categoryId,
    this.categoryName,
    this.categoryCreate,
    this.categoryImage,
  });

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    doctorId = json['doctor_id'].toString();
    doctorName = json['doctor_name'];
    doctorEmail = json['doctor_email'];
    doctorPassword = json['doctor_password'];
    doctorPhone = json['doctor_phone'];
    doctorCreate = json['doctor_create'];
    doctorImage = json['doctor_image'];
    specialization = json['specialization'];
    experience = json['experience'].toString();
    categoryId = json['category_id'].toString();
    categoryName = json['category_name'];
    categoryCreate = json['category_create'];
    categoryImage = json['category_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    data['category_name'] = categoryName;
    data['category_create'] = categoryCreate;
    data['category_image'] = categoryImage;
    return data;
  }
}
