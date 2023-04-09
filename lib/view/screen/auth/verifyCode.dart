import 'package:content_app/functions/handlingData.dart';
import 'package:content_app/logic/controller/authC/verifyCode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import '../../widget/customComponent.dart';

class VerifyCode extends StatelessWidget {
  VerifyCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(VerifyCodeController());
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            body: GetBuilder<VerifyCodeController>(
          builder: ((controller) => Container(
                color: Colors.white,
                child: ListView(children: [
                  Container(
                    padding: EdgeInsets.only(top: 80),
                    child: Center(
                      child: Text(
                        "التحقق من الكود",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Center(
                    child: Text(
                      "قم بإدخال كود التحقق المرسل الى \n ${controller.email}",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  const SizedBox(height: 15),
                  OtpTextField(
                    fieldWidth: 50.0,
                    borderRadius: BorderRadius.circular(20),
                    numberOfFields: 5,
                    focusedBorderColor: Color(0xff383232),
                    cursorColor: Color(0xff383232),
                    //set to true to show as box or false to show as dash
                    showFieldAsBox: true,
                    //runs when a code is typed in
                    onCodeChanged: (String code) {
                      //handle validation or checks here
                    },
                    //runs when every textfield is filled
                    onSubmit: (String verificationCode) {
                      controller.verifyCode(verificationCode);
                    }, // end onSubmit
                  ),
                  const SizedBox(height: 40),
                  Container(
                    padding: EdgeInsets.all(40),
                    child: SizedBox(
                      width: 250,
                      child: button(" إعاده ارسال كود التحقق", () {
                        controller.reSendVerifycode();
                      }, context),
                    ),
                  ),
                ]),
              )),
        )));
  }
}
