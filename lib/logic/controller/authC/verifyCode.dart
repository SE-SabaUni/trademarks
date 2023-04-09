import 'package:content_app/functions/handlingData.dart';
import 'package:content_app/functions/remotData.dart';
import 'package:content_app/services/statusRequst.dart';
import 'package:content_app/utils/linkApi.dart';
import 'package:content_app/view/screen/bar.dart';
import 'package:get/get.dart';

class VerifyCodeController extends GetxController {
  StatusRequest? statusRequest;
  String? email;
  @override
  void onInit() {
    email = Get.arguments['email'];
    super.onInit();
  }

  verifyCode(String code) async {
    statusRequest = StatusRequest.loading;
    update();

    var response =
        await postdata(emailVerifyURL, {'email': email!, 'otp': code});
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['message'] == "success") {
        Get.offAll(Bar());
      } else {
        Get.defaultDialog(title: "تنبية", middleText: "الكود غير صحيح");
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  reSendVerifycode() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await getdata(emailVerifyURL);
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['message'] == 'success') {
        Get.defaultDialog(title: "تنبية", middleText: " تم إعادة ارسال الكود");
      }

      update();
    }
  }
}
