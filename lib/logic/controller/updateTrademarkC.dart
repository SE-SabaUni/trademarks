import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class updatetrademarkC extends GetxController {
  TextEditingController cocumentsLink = TextEditingController();

  var selectedTrademark;
  TextEditingController dateinput = TextEditingController();

  DateTime? pickedDate;
  String formattedDate = '';
  List trademarks = [
    {'name': 'الكترونيات', 'id': '1'},
    {'name': '2الكترونيات', 'id': '2'},
    {'name': '3الكترونيات', 'id': '3'}
  ];

  pickDate(context) async {
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
      //pickedDate output format => 2021-03-10 00:00:00.000
      formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate!);
      //formatted date output using intl package =>  2021-03-16
      //you can implement different kind of Date Format here according to your requirement

      dateinput.text = formattedDate;
    } else {
      print("Date is not selected");
    }
  }
}
