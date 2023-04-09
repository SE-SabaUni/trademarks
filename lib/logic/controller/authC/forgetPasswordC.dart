import 'package:content_app/functions/handlingData.dart';
import 'package:content_app/functions/remotData.dart';
import 'package:content_app/utils/linkApi.dart';
import 'package:content_app/view/screen/auth/newPassword.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../services/statusRequst.dart';

class forgetPassC extends GetxController {
  late TextEditingController email;
  late GlobalKey<FormState> formKey;
  String messageError = "";
  StatusRequest? statusreguest;
  @override
  void onInit() {
    super.onInit();
    email = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  forgetPassword() async {
    messageError = '';
    var formData = formKey.currentState;
    if (formData!.validate()) {
      statusreguest = StatusRequest.loading;
      update();
      var response = await postdata(forgetPasswordURL, {'email': email.text});
      statusreguest = handlingData(response);
      if (statusreguest == StatusRequest.success) {
        if (response['message'] == 'success') {
          Get.off(NewPassword(), arguments: {'email': email.text});
        } else {
          messageError = 'الإيميل غير موجود';
          statusreguest = StatusRequest.failure;
          update();
        }
      }
    }
  }
}
