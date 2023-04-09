import 'package:content_app/logic/bindings/binding.dart';
import 'package:content_app/logic/controller/detailesC.dart';
import 'package:content_app/utils/linkApi.dart';
import 'package:content_app/view/widget/customComponent.dart';
import 'package:content_app/view/screen/bar.dart';

import 'package:content_app/view/screen/home.dart';
import 'package:content_app/view/screen/product/addProduct.dart';
import 'package:content_app/view/screen/product/products.dart';
import 'package:content_app/view/screen/trademark/addTrademarks.dart';
import 'package:content_app/view/screen/trademark/updateTrademark.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/statusRequst.dart';

class Detailes extends GetView<DetailesController> {
  const Detailes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut((() => DetailesController()), fenix: true);
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: SingleChildScrollView(
            // padding: EdgeInsets.only(top: 40, left: 20, right: 20),
            child:  Column(
                            children: [
                              Stack(
                                children: [
                                  Positioned(
                                      child: ClipPath(
                                    clipper: CustomClipPath(),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .40,
                                      color: Color(0xff383232),
                                    ),
                                  )),
                                  Positioned(
                                      top: 10,
                                      child: IconButton(
                                          onPressed: () {
                                            Get.offAll(Bar());
                                          },
                                          icon: Icon(
                                            Icons.arrow_back_rounded,
                                            color: Colors.white,
                                          ))),
                                  Positioned(
                                      right: MediaQuery.of(context).size.width *
                                          .35,
                                      top: MediaQuery.of(context).size.height *
                                          .10,
                                      child: Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      "http://10.0.2.2:8000/storage/images/${controller.data['image']}"),
                                                  fit: BoxFit.cover),
                                              border: Border.all(
                                                  color: Color(0xff7F7671),
                                                  width: 2,
                                                  style: BorderStyle.solid),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(70))))),
                                  Positioned(
                                      top: MediaQuery.of(context).size.height *
                                          .30,
                                      right: MediaQuery.of(context).size.width *
                                          .30,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          // color: Color(0xfff7f2e8),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            ElevatedButton.icon(
                                                style: ElevatedButton.styleFrom(
                                                    primary: Color(0xffA89B93)),
                                                onPressed: () {
                                                  controller.goToProductPage();
                                                },
                                                icon: Icon(
                                                  Icons
                                                      .display_settings_rounded,
                                                ),
                                                label: Text(
                                                  "المنتجات",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2,
                                                )),
                                            const SizedBox(
                                              width: 5,
                                            ),

                                            ElevatedButton.icon(
                                                style: ElevatedButton.styleFrom(
                                                    primary: Color(0xffA89B93)),
                                                onPressed: () {
                                                  controller
                                                      .dialogDeleteTrademark();
                                                },
                                                icon: Icon(
                                                  Icons.delete,
                                                ),
                                                label: Text(
                                                  "حذف",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2,
                                                )),
                                          ],
                                        ),
                                      ))
                                ],
                              ),
                               Container(
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              offset: Offset(1, 5),
                                              blurRadius: 5,
                                              color: Color(0xffA89B93)
                                                  .withOpacity(0.8),
                                            )
                                          ]),
                                      child: Column(
                                        children: [
                                          container(
                                              'اسم العلامة :',
                                              " ${controller.data['name']}",
                                              context),
                                          container(
                                              ' الوصف :',
                                              " ${controller.data['description']}",
                                              context),
                                          container(
                                              'اسم التاجر :',
                                              " ${controller.data['trader_name']}",
                                              context),
                                          container(
                                              'الجنس :',
                                              " ${controller.data['nationality']}",
                                              context),
                                          container(
                                              'العنوان :',
                                              " ${controller.data['address']}",
                                              context),
                                          container(
                                              'الهاتف :',
                                              " ${controller.data['phone']}",
                                              context),
                                          container(
                                              'الايميل :',
                                              " ${controller.data['email']}",
                                              context),
                                          container(
                                              "تاريخ إضافة العلامة:",
                                              " ${controller.data['added_at']}",
                                              context),
                                          container(
                                              "تاريخ إنتهاء العلامة :",
                                              " ${controller.data['Expired_at']}",
                                              context),
                                          container(
                                              'مستندات :',
                                              " ${controller.data['cretificate']}",
                                              context),
                                        ],
                                      ),
                                    )
                            ],
                          )
          ),
        ));
  }

  Container container(String hint, String text, context) {
    return Container(
      padding: EdgeInsets.only(right: 20),
      margin: EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Text(
                '$hint',
                style: Theme.of(context).textTheme.headline5,
              )),
          Expanded(
            flex: 2,
            child: Text(
              "$text",
              style: Theme.of(context).textTheme.headline6,
            ),
          )
        ],
      ),
    );
  }
}
