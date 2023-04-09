import 'package:content_app/logic/controller/addTrademarkC.dart';
import 'package:content_app/logic/controller/addTraderC.dart';
import 'package:content_app/services/statusRequst.dart';
import 'package:content_app/view/widget/customComponent.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../services/validation.dart';

class AddTrader extends GetView<AddTraderController> {
  const AddTrader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(AddTraderController(), permanent: true);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: appBar(context, 'إضافة علامة تجارية'),
        body: ListView(children: [
          Container(
              padding: EdgeInsets.all(20),
              child: Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    row("اسم  التاجر:", controller.name, (value) {
                      return validInput(value!, 4, 25, "");
                    }, context),
                    const SizedBox(
                      height: 10,
                    ),
                    row("الهاتف  :", controller.phone, (value) {
                      return validInput(value!, 9, 9, "phone");
                    }, context),
                    const SizedBox(
                      height: 30,
                    ),
                    row("الإيميل  :", controller.email, (value) {
                      return validInput(value!, 15, 30, "email");
                    }, context),
                    const SizedBox(
                      height: 30,
                    ),
                    row("العنوان  :", controller.address, (value) {
                      return validInput(value!, 3, 25, "");
                    }, context),
                    const SizedBox(
                      height: 30,
                    ),
                    row("الجنسية  :", controller.nationality, (value) {
                      return validInput(value!, 4, 25, "");
                    }, context),
                    const SizedBox(
                      height: 30,
                    ),
                    GetBuilder<AddTraderController>(
                      builder: (controller) =>
                          controller.statusRequest == StatusRequest.loading
                              ? lottieLoading()
                              : SizedBox(
                                  width: 250,
                                  child: button(" حفظ", () {
                                    controller.addTrader();
                                  }, context),
                                ),
                    )
                  ],
                ),
              ))
        ]),
      ),
    );
  }
}
