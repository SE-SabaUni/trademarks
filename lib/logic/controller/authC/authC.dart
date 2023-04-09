import 'package:content_app/functions/remotData.dart';
import 'package:content_app/main.dart';
import 'package:content_app/services/statusRequst.dart';
import 'package:content_app/utils/linkApi.dart';
import 'package:content_app/view/screen/auth/verifyCode.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../functions/handlingData.dart';
import '../../../view/screen/bar.dart';

class AuthController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TextEditingController name;
  late TextEditingController emailLogin;
  late TextEditingController passwordLogin;
  late TextEditingController emailRegister;
  late TextEditingController passwordRegister;
  late TextEditingController phone;
  late TextEditingController address;
  late TabController tabController;
  late GlobalKey<FormState> LoginformKey;
  late GlobalKey<FormState> RegisterformKey;
  String messageErrorLogin = '';
  String messageErrorRegister = '';
  StatusRequest? statusreguest;

  @override
  void onInit() {
    super.onInit();
    print("shaaaaaaaaaaaaaaaaaaad ${sharedPreference.getString('token')}");
    name = TextEditingController();
    emailLogin = TextEditingController();
    passwordLogin = TextEditingController();
    emailRegister = TextEditingController();
    passwordRegister = TextEditingController();
    address = TextEditingController();
    phone = TextEditingController();
    LoginformKey = GlobalKey<FormState>();
    RegisterformKey = GlobalKey<FormState>();
    tabController = TabController(length: 2, vsync: this);
  }

///////// لتغييرمكان التاب
  handleTabChange() {
    //print("Inside Handle Tab: Tab Index: " + tabController.index.toString());
    if (tabController.index == 1) {
      var index = tabController.previousIndex;
      tabController.index = index;
    }
  }

  ///////////login user
  loginUser() async {
    var formDate = LoginformKey.currentState;
    messageErrorLogin = "";
    if (formDate!.validate()) {
      statusreguest = StatusRequest.loading;
      update();
      var response = await postdata(
          loginURL, {'email': emailLogin.text, 'password': passwordLogin.text});

      statusreguest = handlingData(response);
      if (statusreguest == StatusRequest.success) {
        if (response['message'] == 'success') {
          sharedPreference.setString('id', response['user']['id'].toString());
          sharedPreference.setString('email', response['user']['email']);
          sharedPreference.setString('token', response['token']);
          Get.offAll(Bar());
        } else {
          messageErrorLogin = "كلمة السر او الايميل غير صحيح";
          statusreguest = StatusRequest.failure;
          update();
        }
      }
    }
  }

  //////////// register user
  registerUser() async {
    //   var formDate = RegisterformKey.currentState;
    //   messageErrorRegister = "";
    //   if (formDate!.validate()) {
    //     statusreguest = StatusRequest.loading;
    //     update();
    //     var response = await postdata(registerURL, {
    //       'name': name.text,
    //       'email': emailRegister.text,
    //       'password': passwordRegister.text,
    //       'phone': phone.text,
    //       'address': address.text
    //     });

    //     statusreguest = handlingData(response);
    //     if (statusreguest == StatusRequest.success) {
    //       if (response['message'] == 'success') {
    //         sharedPreference.setString('id', response['user']['id'].toString());
    //         sharedPreference.setString('email', response['user']['email']);
    //         sharedPreference.setString('token', response['token']);
    //         Get.off(VerifyCode(),
    //             arguments: {"email": sharedPreference.getString('email')});
    //       } else {
    //         messageErrorRegister = "هذا الحساب موجود مسبقا";
    //         statusreguest = StatusRequest.failure;
    //         update();
    //       }
    //       print(response);
    //     }
    //   }
    // }
    Get.off(VerifyCode(),
        arguments: {"email": sharedPreference.getString('email')});
    //// logout user
  }
}


// login() async {
//   if (formstate.currentState!.validate()) {
//     statusRequest = StatusRequest.loading;
//     update();
//     var response = await loginData.postdata(email.text, password.text);
//     print("=============================== Controller $response ");
//     statusRequest = handlingData(response);
//     if (StatusRequest.success == statusRequest) {
//       if (response['status'] == "success") {
//         // data.addAll(response['data']);
//         if (response['data']['users_approve'] == "1") {
//           myServices.sharedPreferences
//               .setString("id", response['data']['users_id']);
//           myServices.sharedPreferences
//               .setString("username", response['data']['users_name']);
//           myServices.sharedPreferences
//               .setString("email", response['data']['users_email']);
//           myServices.sharedPreferences
//               .setString("phone", response['data']['users_phone']);
//           myServices.sharedPreferences.setString("step", "2");
//           Get.offNamed(AppRoute.homepage);
//         } else {
//           Get.toNamed(AppRoute.verfiyCodeSignUp,
//               arguments: {"email": email.text});
//         }
//       } else {
//         Get.defaultDialog(
//             title: "ُWarning", middleText: "Email Or Password Not Correct");
//         statusRequest = StatusRequest.failure;
//       }
//     }
//     update();
//   } else {}
// }
