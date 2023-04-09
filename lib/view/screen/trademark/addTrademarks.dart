import 'package:content_app/logic/controller/addTrademarkC.dart';
import 'package:content_app/services/statusRequst.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../logic/controller/updateTrademarkC.dart';
import '../../../services/validation.dart';

import '../../widget/customComponent.dart';

class AddTrademark extends StatelessWidget {
  const AddTrademark({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AddTrademarkC(), fenix: true);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: appBar(context, 'إضافة علامة تجارية'),
        body: ListView(children: [
          Container(
              padding: EdgeInsets.all(20),
              child: GetBuilder<AddTrademarkC>(
                builder: (controller) => controller.statusRequest ==
                        StatusRequest.offlinefailure
                    ? lottieOfLine()
                    : controller.statusRequest == StatusRequest.serverfailure
                        ? lottieServerFaliuer()
                        : Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height: 100,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 224, 221, 221),
                                        borderRadius: BorderRadius.circular(10),
                                        image: controller.myflie != null
                                            ? DecorationImage(
                                                image: FileImage(
                                                    controller.myflie!),
                                                fit: BoxFit.cover)
                                            : null),
                                  ),
                                  Positioned(
                                    top: 50,
                                    right: 100,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                              colors: [
                                                Color.fromARGB(80, 18, 15, 15),
                                                Color.fromARGB(80, 0, 0, 0),
                                              ],
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.add_a_photo,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          controller.pickImage();
                                          print(
                                              "ddddddddddddddddddddddddddddd ${controller.myflie}");
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Form(
                                  key: controller.formKey,
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      // dropdown("التاجر :", context,
                                      //     controller.selectedTrader, controller.trader),
                                      Row(
                                        children: [
                                          Expanded(
                                              flex: 1,
                                              child: Text(
                                                " التاجر",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline5,
                                              )),
                                          Expanded(
                                            flex: 2,
                                            child: DropdownButtonFormField(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                                alignment: Alignment.bottomLeft,
                                                dropdownColor: Colors.white,
                                                value:
                                                    controller.selectedTrader,
                                                items: controller.trader
                                                    .map((cat) {
                                                  return DropdownMenuItem(
                                                    child: Text(
                                                      cat['name'],
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                    value: cat['id'],
                                                  );
                                                }).toList(),
                                                onChanged: (value) {
                                                  controller.selectedTrader =
                                                      value;
                                                  print(controller
                                                      .selectedTrader);
                                                },
                                                validator: (value) => value ==
                                                        null
                                                    ? 'الحقل لايمكن ان يكون فارغ'
                                                    : null),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      row("اسم العلامة التجارية:",
                                          controller.name, (value) {
                                        return validInput(value!, 4, 25, "");
                                      }, context),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      row("الوصف", controller.discrip, (value) {
                                        return validInput(value!, 4, 25, "");
                                      }, context),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      row("رابط المستندات :",
                                          controller.documentsLink, (value) {
                                        return validInput(
                                            value!, 15, 100, "link");
                                      }, context),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      datefield(
                                          context,
                                          controller.addedDate,
                                          "تاريخ الاضافة :",
                                          controller,
                                          1, (value) {
                                        return validInput(
                                            value!, 1, 10, 'type');
                                      }),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      datefield(
                                          context,
                                          controller.expirDate,
                                          "تاريخ الانتهاء :",
                                          controller,
                                          2, (value) {
                                        return validInput(
                                            value!, 1, 10, 'type');
                                      }),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      controller.statusRequest ==
                                              StatusRequest.loading
                                          ? lottieLoading()
                                          : SizedBox(
                                              width: 250,
                                              child: button(" حفظ", () {
                                                controller.addTrademark();
                                              }, context),
                                            ),
                                    ],
                                  ))
                            ],
                          ),
              ))
        ]),
      ),
    );
  }
}
