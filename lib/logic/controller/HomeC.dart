import 'package:content_app/services/statusRequst.dart';
import 'package:content_app/utils/linkApi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../functions/handlingData.dart';
import '../../functions/remotData.dart';
import '../../view/screen/trademark/detailes.dart';

class HomeController extends GetxController {
  ///bar page
  var x;
  RxInt currentIndex = 0.obs;
  PageController pageController = PageController();
  onChange(int index) {
    ////for    bottomNavigationBar on bar page
    currentIndex.value = index;
  }
////

  StatusRequest? statusRequest;
  final scrollController = ScrollController();

  List data = [];
  List searchResult = [];
  bool hasmore = true;
// static const limit = 25;
  int page = 1;
  @override
  void onInit() {
    super.onInit();
    getTrademarks();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        //to ckeck if reach the end of list
        print("objectlllllllllllllll");
        // getTrademarks();
      }
    });
  }

  addLisner() {}

  getTrademarks() async {
    // get trademark
    var response = await getdata(showTrademarkURL + '?page=$page');
    statusRequest = handlingData(response);
    print(statusRequest);
    if (statusRequest == StatusRequest.success) {
      if (response['message'] == 'success') {
        data.addAll(response['data']['data']);
      }
    }
    update();
  } //end function

  Future refreshData() async {
    /// for refrush ui
    await Future.delayed(Duration(seconds: 3));
    data.clear();
    getTrademarks();
    // data.addAll(generateWordPairs().take(20));

    update();
  } //end function

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    scrollController.dispose();
  }

  // go to
  goToDatailsScreen(index) {
    Get.to(Detailes(), arguments: {'trademark_details': data[index]});
  } //end of function
}
