import 'package:flutter/material.dart';
import 'package:get/get.dart';

class searchController extends GetxController {
  TextEditingController dateinput = TextEditingController();
  DateTime? pickedDate;
  late String formattedDate;
}
