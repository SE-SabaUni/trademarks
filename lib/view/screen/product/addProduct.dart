import 'package:content_app/logic/controller/addProductC.dart';
import 'package:content_app/services/statusRequst.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/validation.dart';
import '../../widget/customComponent.dart';

class AddProduct extends GetView<AddProdcutC> {
  const AddProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AddProdcutC(), fenix: true);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: appBar(context, "إضافة منتج"),
        body: Container(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              Stack(
                clipBehavior: Clip.hardEdge,
                children: [
                  GetBuilder<AddProdcutC>(
                      builder: (controller) => Center(
                            child: Container(
                              height: 100,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 224, 221, 221),
                                  borderRadius: BorderRadius.circular(10),
                                  image: controller.myflie != null
                                      ? DecorationImage(
                                          image: FileImage(controller.myflie!),
                                          fit: BoxFit.cover)
                                      : null),
                            ),
                          )),
                  Positioned(
                    top: 50,
                    left: 110,
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [
                                Color.fromARGB(80, 18, 15, 15),
                                Color.fromARGB(80, 0, 0, 0),
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter),
                          borderRadius: BorderRadius.circular(20)),
                      child: IconButton(
                        icon: Icon(
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
              GetBuilder<AddProdcutC>(
                  builder: (controller) => Form(
                      key: controller.formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    "العلامة التجارية",
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  )),
                              Expanded(
                                flex: 2,
                                child: DropdownButtonFormField(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    alignment: Alignment.bottomLeft,
                                    dropdownColor: Colors.white,
                                    value: controller.selectedTrademark,
                                    items: controller.trademarks.map((cat) {
                                      return DropdownMenuItem(
                                        child: Text(
                                          cat['name'],
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        value: cat['id'],
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      controller.selectedTrademark = value;
                                    },
                                    validator: (value) => value == null
                                        ? 'الحقل لايمكن ان يكون فارغ'
                                        : null),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    "الصنف",
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  )),
                              Expanded(
                                flex: 2,
                                child: DropdownButtonFormField(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    alignment: Alignment.bottomLeft,
                                    dropdownColor: Colors.white,
                                    value: controller.selectedCategory,
                                    items: controller.category.map((cat) {
                                      return DropdownMenuItem(
                                        child: Text(
                                          cat['name'],
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        value: cat['id'],
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      controller.selectedCategory = value;
                                    },
                                    validator: (value) => value == null
                                        ? 'الحقل لايمكن ان يكون فارغ'
                                        : null),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          row("اسم المنتج :", controller.name, (value) {
                            return validInput(value!, 4, 25, "");
                          }, context),
                          SizedBox(
                            height: 10,
                          ),
                          row("رابط المستندات :", controller.documentsLink,
                              (value) {
                            return validInput(value!, 15, 100, "link");
                          }, context),
                          SizedBox(
                            height: 30,
                          ),
                          controller.statusRequest == StatusRequest.loading
                              ? lottieLoading()
                              : controller.statusRequest ==
                                      StatusRequest.offlinefailure
                                  ? lottieOfLine()
                                  : controller.statusRequest ==
                                          StatusRequest.serverfailure
                                      ? lottieServerFaliuer()
                                      : SizedBox(
                                          width: 250,
                                          child: button(" حفظ", () {
                                            controller.addProduct();
                                          }, context),
                                        ),
                        ],
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
