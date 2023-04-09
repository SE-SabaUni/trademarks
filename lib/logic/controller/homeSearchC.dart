import 'package:get/get.dart';

import '../../functions/handlingData.dart';
import '../../functions/remotData.dart';
import '../../services/statusRequst.dart';
import '../../utils/linkApi.dart';

class HomeSearchController extends GetxController {
  StatusRequest? statusRequest;
  List searchResult = [];
  List matchQuery = [];

  searchApi(String name) async {
    matchQuery.clear();
    searchResult.clear();
    print("mattttttttttttttttttttttttttttttttt $matchQuery");
    statusRequest = StatusRequest.loading;
    update();
    var response = await postdata(searchURL, {'name': name});
    statusRequest = handlingData(response);
    print(statusRequest);
    if (statusRequest == StatusRequest.success) {
      if (response['message'] == 'success') {
        print("=======================================");
        searchResult.addAll(response['data']);
        matchQuery = searchResult.map((x) => x["name"]).toList();
        print("mattttttttttttttttttttttttttttttttt after $matchQuery");
      } else {
        statusRequest = StatusRequest.failure;
      }
      update();
    }
    print("=======================================");
    print(statusRequest);
  }
}
