import 'package:content_app/logic/controller/authC/forgetPasswordC.dart';
import 'package:content_app/services/statusRequst.dart';
import 'package:content_app/view/widget/customComponent.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/validation.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => forgetPassC(), fenix: true);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          body: ListView(
        // physics: NeverScrollableScrollPhysics(),
        children: [
          ClipPath(
            clipper: CustomClipPath(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 400,
              decoration: BoxDecoration(gradient: customGradient()),
            ),
          ),
          Container(
              padding: EdgeInsets.only(right: 20, left: 20),
              child: GetBuilder<forgetPassC>(
                builder: (controller) => Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      Text(
                        "لإعادة تعيين كلمة السر ادخل بريدك الالكتروني",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      textform(
                        " الايميل",
                        false,
                        Icons.email,
                        controller.email,
                        (value) {
                          return validInput(value!, 15, 30, "email");
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        controller.messageError,
                        style: TextStyle(color: Colors.red),
                      ),
                      controller.statusreguest == StatusRequest.loading
                          ? lottieLoading()
                          : SizedBox(
                              width: 250,
                              child: button(" ارسال", () {
                                controller.forgetPassword();
                              }, context),
                            ),
                    ],
                  ),
                ),
              )),
        ],
      )),
    );
  }
}
