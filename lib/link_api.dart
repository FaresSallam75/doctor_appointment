class AppLink {
  static String linkServerName = "http://10.0.2.2/doctor_appointment";
  static String linkImageStatic = "http://10.0.2.2/doctor_appointment/upload";

  static String viewCategories = "$linkServerName/doctor/categories/view.php";
  static String viewDoctorCategories =
      "$linkServerName/doctor/categories/viewdoctors.php";

  static String getSearhedDoctor =
      "$linkServerName/doctor/categories/search.php";

  static String viewAllDoctor = "$linkServerName/doctor/viewalldoctors.php";
  static String viewDoctorDetails =
      "$linkServerName/doctor/auth/viewdetails.php";
  static String ratingDoctor = "$linkServerName/doctor/rating.php";
  static String viewRatingDoctor = "$linkServerName/doctor/viewrating.php";

  //auth
  static String signup = "$linkServerName/auth/signup.php";
  static String login = "$linkServerName/auth/login.php";
  static String checkEmail = "$linkServerName/forgetpassword/checkemail.php";
  static String resetPassword =
      "$linkServerName/forgetpassword/resetpassword.php";

  static String updateUserData = "$linkServerName/auth/updateuser.php";
  static String getCurrentUserData = "$linkServerName/auth/currentuser.php";
  static String currentUserToken = "$linkServerName/auth/usertoken.php";

  //appointments
  static String viewAppointments = "$linkServerName/appointments/view.php";
  static String addAppointments = "$linkServerName/appointments/add.php";
  static String autoDeleteAppointments =
      "$linkServerName/appointments/autodelete.php";
  static String cancelAppointments = "$linkServerName/appointments/cancel.php";
  static String todayAppointments = "$linkServerName/appointments/today.php";
  static String editAppointments = "$linkServerName/appointments/edit.php";
  static String viewCancelAppointments =
      "$linkServerName/appointments/viewcancel.php";

  // payment
  static String payment = "$linkServerName/payment/payment.php";
  static String viewPayment = "$linkServerName/payment/view.php";

  // chat
  static String viewMessages = "$linkServerName/message/viewmessage.php";
  static String viewCardMessages = "$linkServerName/message/cardmessage.php";
  static String sendMessages = "$linkServerName/message/sendmessage.php";

  // uploads =====> Images
  static String viewCategoriesImages = "$linkImageStatic/categories";
  static String viewDoctorsImages = "$linkImageStatic/doctors";
  static String viewUserImages = "$linkImageStatic/users";
  static String viewMessagesImages = "$linkImageStatic/messages";
}
