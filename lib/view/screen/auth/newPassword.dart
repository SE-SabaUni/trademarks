import 'package:content_app/functions/handlingData.dart';
import 'package:content_app/logic/controller/authC/newPasswordC.dart';
import 'package:content_app/logic/controller/authC/verifyCode.dart';
import 'package:content_app/services/statusRequst.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import '../../../logic/controller/authC/forgetPasswordC.dart';
import '../../../services/validation.dart';
import '../../widget/customComponent.dart';

class NewPassword extends StatelessWidget {
  NewPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => NewPasswordController(), fenix: true);
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: GetBuilder<NewPasswordController>(
              builder: (controller) =>
                  controller.statusreguest == StatusRequest.loading
                      ? lottieLoading()
                      : Container(
                          color: Colors.white,
                          child: ListView(children: [
                            Container(
                              padding: EdgeInsets.only(top: 80, bottom: 20),
                              child: Center(
                                child: Text(
                                  "إعادة تعيين كلمة السر",
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Form(
                                key: controller.formKey,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 300,
                                      child: textform(
                                        "كلمة السر الجديدة",
                                        false,
                                        Icons.password,
                                        controller.password,
                                        (value) {
                                          return validInput(
                                              value!, 6, 20, "password");
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Center(
                                      child: Text(
                                        "الكود المرسل الى الايميل",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    OtpTextField(
                                      fieldWidth: 50.0,
                                      borderRadius: BorderRadius.circular(20),
                                      numberOfFields: 5,
                                      focusedBorderColor: Color(0xff383232),
                                      cursorColor: Color(0xff383232),
                                      showFieldAsBox: true,
                                      //runs when a code is typed in
                                      onCodeChanged: (String code) {
                                        //handle validation or checks here
                                      },
                                      //runs when every textfield is filled
                                      onSubmit: (String verificationCode) {
                                        controller
                                            .restNewPassword(verificationCode);
                                      }, // end onSubmit
                                    ),
                                  ],
                                ))
                          ]),
                        )),
        ));
  }
}
