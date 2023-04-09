import 'package:content_app/logic/controller/productC.dart';
import 'package:content_app/services/statusRequst.dart';
import 'package:content_app/services/validation.dart';
import 'package:content_app/view/widget/customComponent.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Products extends StatelessWidget {
  Products({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProductsController(), fenix: true);
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: appBar(context, "المنتجات"),
            body: GetBuilder<ProductsController>(
              builder: ((controller) => controller.statusRequest ==
                      StatusRequest.loading
                  ? lottieLoading()
                  : controller.statusRequest == StatusRequest.offlinefailure
                      ? lottieOfLine()
                      : controller.statusRequest == StatusRequest.serverfailure
                          ? lottieServerFaliuer()
                          : controller.statusRequest == StatusRequest.failure
                              ? Text(
                                  "no data",
                                  style: Theme.of(context).textTheme.headline4,
                                )
                              : ListView.builder(
                                  padding: EdgeInsets.all(20),
                                  itemCount: controller.products.length,
                                  itemBuilder: (context, i) => Container(
                                        margin: EdgeInsets.all(10),
                                        //  padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Color(0xfff7f2e8),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                height: 150,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                      color: Color.fromARGB(
                                                          255, 198, 186, 180),
                                                    ),
                                                    image:
                                                        const DecorationImage(
                                                            image: AssetImage(
                                                              "assets/images/Marie.webp",
                                                            ),
                                                            fit: BoxFit.fill)),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                                flex: 2,
                                                child: Column(
                                                  children: [
                                                    container(
                                                        "   ${controller.products[i]['name']}",
                                                        context),
                                                    container(
                                                        "  ${controller.products[i]['TrademarkName']}",
                                                        context),
                                                    container(
                                                        " ${controller.products[i]['name']}",
                                                        context),
                                                    container(
                                                        "  ${controller.products[i]['Category']}",
                                                        context),
                                                    container(
                                                        " ${controller.products[i]['cretificate']}",
                                                        context)
                                                  ],
                                                ))
                                          ],
                                        ),
                                      ))),
            )));
  }

  Container container(String text, context) {
    return Container(
      child: Row(
        children: [
          Flexible(
            child: Text(
              "$text",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ],
      ),
    );
  }
}
