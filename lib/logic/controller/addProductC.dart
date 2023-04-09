import 'dart:io';

import 'package:content_app/services/statusRequst.dart';
import 'package:content_app/utils/linkApi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../functions/handlingData.dart';
import '../../functions/remotData.dart';

class AddProdcutC extends GetxController {
  late TextEditingController name;
  late TextEditingController documentsLink;
  late final ImagePicker _picker;
  late GlobalKey<FormState> formKey;
  StatusRequest? statusRequest;
  File? myflie;
  var selectedCategory;
  var selectedTrademark;

  List category = [];
  List trademarks = [];

  @override
  void onInit() {
    super.onInit();
    name = TextEditingController();
    documentsLink = TextEditingController();
    _picker = ImagePicker();
    formKey = GlobalKey();
    getCategory();
    getTrademarks();
  }

  //pick image
  pickImage() async {
    XFile? xflie = await _picker.pickImage(source: ImageSource.gallery);
    if (xflie != null) {
      myflie = File(xflie.path);
      // isactiv = true;
    }
    update();
  } //end function

//add new product
  addProduct() async {
    print(selectedTrademark.toString());
    print(selectedCategory);
    var formData = formKey.currentState;
    if (formData!.validate()) {
      if (myflie != null) {
        statusRequest = StatusRequest.loading;
        update();
        var response = await postdataFile(
            addProductURL,
            {
              'name': name.text,
              'cretificate': documentsLink.text,
              'trademark_id': selectedTrademark.toString(),
              'category_id': selectedCategory.toString(),
            },
            myflie!);
        statusRequest = handlingData(response);
        if (statusRequest == StatusRequest.success) {
          if (response['message'] == 'success') {
            Get.defaultDialog(title: '', middleText: "تمت الإضافة بنجاح ");
            name.clear();
            documentsLink.clear();
          }
        }
        update();
      } else {
        Get.defaultDialog(
            title: '', middleText: " يجب تحديد صوره العلامة التجارية");
      }
    }
  } //end function

  //getTrademarks
  getTrademarks() async {
    var response = await getdata(showAllTrademarkURL);
    statusRequest = handlingData(response);
    print(statusRequest);
    if (statusRequest == StatusRequest.success) {
      if (response['message'] == 'success') {
        print('------------------------------------------------------');
        trademarks.addAll(response['data']);
        print(trademarks);
      }
    }
    update();
  } //end function

  //get category
  getCategory() async {
    var response = await getdata(showCategoryURL);
    statusRequest = handlingData(response);
    print(statusRequest);
    if (statusRequest == StatusRequest.success) {
      if (response['message'] == 'success') {
        category.addAll(response['data']);
      }
    }

    update();
  } //end function
}
