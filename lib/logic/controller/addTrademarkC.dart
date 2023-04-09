import 'dart:io';

import 'package:content_app/utils/linkApi.dart';
import 'package:content_app/view/screen/bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../functions/handlingData.dart';
import '../../functions/remotData.dart';
import '../../services/statusRequst.dart';

class AddTrademarkC extends GetxController {
  late GlobalKey<FormState> formKey;
  late TextEditingController name;
  late TextEditingController documentsLink;
  late TextEditingController discrip;
  late TextEditingController addedDate;
  late TextEditingController expirDate;
  StatusRequest? statusRequest;
  late final ImagePicker _picker;
  File? myflie;
  var selectedTrader;
  DateTime? pickedDate;
  String formattedDate = '';
  List trader = [];

  @override
  void onInit() {
    super.onInit();
    getTrader();
    formKey = GlobalKey<FormState>();
    name = TextEditingController();
    documentsLink = TextEditingController();
    addedDate = TextEditingController();
    expirDate = TextEditingController();
    discrip = TextEditingController();
    _picker = ImagePicker();
  }

//Pick image
  pickImage() async {
    XFile? xflie = await _picker.pickImage(source: ImageSource.gallery);
    if (xflie != null) {
      myflie = File(xflie.path);
      // isactiv = true;
      update();
    }
  } //end function

//PickDate
  pickAddDate(context) async {
    pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(
            2000), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101),
        builder: ((context, child) => Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: Color(0xff7F7671), // <-- SEE HERE
                ),
              ),
              child: child!,
            )));

    if (pickedDate != null) {
      formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate!);
      addedDate.text = formattedDate;
      update();
    }
  } //end function

//PickDate
  pickExpierDate(context) async {
    pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(
            2000), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101),
        builder: ((context, child) => Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: Color(0xff7F7671), // <-- SEE HERE
                ),
              ),
              child: child!,
            )));

    if (pickedDate != null) {
      formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate!);
      expirDate.text = formattedDate;
      update();
    }
  } //end function

  //add new Trademark
  addTrademark() async {
    var formData = formKey.currentState;
    if (formData!.validate()) {
      if (myflie != null) {
        statusRequest = StatusRequest.loading;
        update();
        var response = await postdataFile(
            addTrademarkURL,
            {
              'name': name.text,
              'cretificate': documentsLink.text,
              'description': discrip.text,
              'trader_id': '1',
              'added_at': addedDate.text,
              'expired_at': expirDate.text
            },
            myflie!);
        statusRequest = handlingData(response);
        if (statusRequest == StatusRequest.success) {
          if (response['message'] == 'success') {
            Get.defaultDialog(title: '', middleText: "تمت الإضافة بنجاح ");
            Get.offAll(Bar());
          } else {
            Get.defaultDialog(
                title: "تنبية", middleText: 'العلامة التجارية موجودة مسبقا');
            statusRequest = StatusRequest.failure;
          }
        }
        update();
      } else {
        Get.defaultDialog(
            title: '', middleText: " يجب تحديد صوره العلامة التجارية");
      }
    }
  } //end function

  // get trader
  getTrader() async {
    var response = await getdata(showTraderURL);
    statusRequest = handlingData(response);
    print(statusRequest);
    if (statusRequest == StatusRequest.success) {
      if (response['message'] == 'success') {
        print('------------------------------------------------------');
        trader.addAll(response['trader']);
      }
    }
    update();
  } //end function
}
