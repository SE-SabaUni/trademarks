import 'package:content_app/logic/controller/addTrademarkC.dart';
import 'package:content_app/services/statusRequst.dart';
import 'package:content_app/utils/linkApi.dart';
import 'package:content_app/view/screen/trademark/addTrademarks.dart';
import 'package:content_app/view/screen/trader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import '../../functions/handlingData.dart';
import '../../functions/remotData.dart';

class AddTraderController extends GetxController {
  late TextEditingController name;
  late TextEditingController phone;
  late TextEditingController email;
  late TextEditingController address;
  late TextEditingController nationality;
  late GlobalKey<FormState> formKey;

  StatusRequest? statusRequest;
  @override
  void onInit() {
    super.onInit();
    name = TextEditingController();
    phone = TextEditingController();
    email = TextEditingController();
    address = TextEditingController();
    nationality = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  addTrader() async {
    var formData = formKey.currentState;
    if (formData!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await postdata(addTraderURL, {
        'name': name.text,
        'phone': phone.text,
        'email': email.text,
        'address': address.text,
        'national': nationality.text
      });
      statusRequest = handlingData(response);
      if (statusRequest == StatusRequest.success) {
        if (response['message'] == 'success') {
          Get.defaultDialog(title: '', middleText: "تمت الإضافة بنجاح ");

          name.clear();
          phone.clear();
          email.clear();
          address.clear();
          nationality.clear();
        } else {
          Get.defaultDialog(
              title: "تنبية", middleText: "الإيميل او رقم الهاتف موجود مسبقا");
          statusRequest = StatusRequest.failure;
        }
        update();
      }
    }
  }
}
