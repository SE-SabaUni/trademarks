import 'package:content_app/services/statusRequst.dart';
import 'package:content_app/utils/linkApi.dart';
import 'package:get/get.dart';

import '../../functions/handlingData.dart';
import '../../functions/remotData.dart';

class ProductsController extends GetxController {
  List products = [];
  StatusRequest? statusRequest;
  late int id;
  @override
  void onInit() {
    id = Get.arguments['trademark_id'];
    print("$id +jdjdj");
    getProducts();
  }

  getProducts() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await postdata(showProductURL, {'id': id.toString()});
    statusRequest = handlingData(response);
    print(statusRequest);
    if (statusRequest == StatusRequest.success) {
      if (response['message'] == 'success') {
        products.addAll(response['data']);
        print(products);
      } else {
        statusRequest = StatusRequest.failure;
      }
      update();
    }
    print("=======================================");
    print(statusRequest);
  }
}
