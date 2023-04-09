import 'package:content_app/services/statusRequst.dart';
import 'package:content_app/utils/linkApi.dart';
import 'package:content_app/view/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../functions/handlingData.dart';
import '../../functions/remotData.dart';
import '../../view/screen/bar.dart';
import '../../view/screen/product/products.dart';

import 'HomeC.dart';

class DetailesController extends GetxController {
  //List data = [];
  Map data = {}; //عرفتها ماب لان api بيرسل ماب
  StatusRequest? statusRequest;
  HomeController g = Get.find();
  @override
  void onInit() {
    data = Get.arguments['trademark_details'];
    print("========================================");
    print(data['id'].toString());
    print(data);
    super.onInit();
  }

  // getTrademarkDetailes() async {
  //   statusRequest = StatusRequest.loading;
  //   update();
  //   var response = await postdata(detailTrademarkURL, {
  //     'id': id.toString(),
  //   });
  //   statusRequest = handlingData(response);
  //   if (statusRequest == StatusRequest.success) {
  //     if (response['message'] == 'success') {
  //       data.addAll(response['data']);
  //       print(data);
  //     } else {
  //       statusRequest = StatusRequest.failure;
  //     }
  //     update();
  //   }
  // }

  goToProductPage() {
    print("==================================================== ${data['id']}");
    Get.to(Products(), arguments: {'trademark_id': data['id']});
  }

  dialogDeleteTrademark() {
    Get.dialog(
      AlertDialog(
        content: const Text(
          'هل تريد الحذف بالتأكيد',
          textAlign: TextAlign.right,
        ),
        actions: [
          TextButton(
            child: const Text("نعم"),
            onPressed: () => deleteTrademark(),
          ),
          TextButton(
            child: const Text("لا"),
            onPressed: () => Get.back(),
          ),
        ],
      ),
    );
  }

  deleteTrademark() async {
    statusRequest == StatusRequest.loading;
    update();
    var response = await postdata(deleteTrademarkURL, {
      'id': data['id'].toString(),
    });
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['message'] == 'success') {
        Get.offAll(Bar());
        await g.refreshData();
      } else {
        statusRequest = StatusRequest.failure;
      }
      update();
    }
  }
}
