import 'package:doctor_appointment/data/web_services(API)/crud.dart';
import 'package:doctor_appointment/link_api.dart';

class PaymentRepository {
  final Crud crud;

  PaymentRepository(this.crud);

  paymentMethod(Map data) async {
    var response = await crud.getDataFromServer(AppLink.payment, data);
    return response.fold((l) => l, (r) => r);
  }

  viewPaymentMethod(Map data) async {
    var response = await crud.getDataFromServer(AppLink.viewPayment, data);
    return response.fold((l) => l, (r) => r);
  }
}
