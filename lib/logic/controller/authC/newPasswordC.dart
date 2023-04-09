import 'package:content_app/model.dart/loginM.dart';
import 'package:content_app/utils/linkApi.dart';
import 'package:content_app/view/screen/auth/auth.dart';
import 'package:content_app/view/screen/bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../functions/handlingData.dart';
import '../../../functions/remotData.dart';
import '../../../services/statusRequst.dart';

class NewPasswordController extends GetxController {
  late TextEditingController password;
  late GlobalKey<FormState> formKey;
  StatusRequest? statusreguest;
  String? email;
  ////////
  @override
  void onInit() {
    email = Get.arguments['email'];

    password = TextEditingController();
    formKey = GlobalKey<FormState>();
    super.onInit();
  }

  ///// restNewPassword
  restNewPassword(String code) async {
    var formData = formKey.currentState;
    if (formData!.validate()) {
      statusreguest = StatusRequest.loading;
      update();
      var response = await postdata(restNewPasswordURL,
          {'email': email, 'otp': code, 'password': password.text});
      statusreguest = handlingData(response);
      if (statusreguest == StatusRequest.success) {
        if (response['message'] == 'success') {
          Get.defaultDialog(middleText: 'تم تغيير كلمة السر بنجاح');
          Get.offAll(Auth());
        } else {
          Get.defaultDialog(middleText: 'اعد المحاولة');
          statusreguest = StatusRequest.failure;
          update();
        }
      }
    }
  }
}
