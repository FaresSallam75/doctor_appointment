import 'package:doctor_appointment/business_logic/payment/payment_state.dart';
import 'package:doctor_appointment/constants/handlingdata.dart';
import 'package:doctor_appointment/constants/statusrequest.dart';
import 'package:doctor_appointment/data/repositary/payment.dart';
import 'package:doctor_appointment/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final PaymentRepository paymentRepository;

  List listPayments = [ ] ;

  PaymentCubit(this.paymentRepository) : super(PaymentStateLoading());

  void loading() {
    emit(PaymentStateLoading());
  }

  paymentData(
    String userId,
    String doctorId,
    String name,
    String email,
    String phone,
    String city,
    String method,
    String transactionId,
    String amount,
    String currency,
    String status,
  ) async {
    var response = await paymentRepository.paymentMethod({
      "userId": userId,
      "doctorId": doctorId,
      "name": name,
      "email": email,
      "phone": phone,
      "city": city,
      "method": method,
      "transactionId": transactionId,
      "amount": amount,
      "currency": currency,
      "status": status,
    });

    StatusRequest statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == "success") {
        emit(
          PaymentStateLoaded(
            successMessage: "Payment successful: ${response['message']}",
          ),
        );
        print("Payment successful");
      } else {
        emit(
          PaymentStateError(
            errorMessage: "Payment failed: ${response['message']}",
          ),
        );
      }
    }
  }

  viewPaymentsData() async {
    var response = await paymentRepository.viewPaymentMethod({
      "userId": myBox!.get("userId"),
    });
    StatusRequest statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == "success") {
        listPayments = response['data'];
        print("listPayments ========================== $listPayments");
        emit(
          PaymentStateLoaded(
            successMessage: "Payment successful: ${response['message']}",
          ),
        );
      } else {
        emit(
          PaymentStateError(
            errorMessage: "Payment successful: ${response['message']}",
          ),
        );
      }
    }
  }
}
