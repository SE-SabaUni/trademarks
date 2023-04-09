import 'dart:io';

import '../services/Crud.dart';

postdata(String link, Map Data) async {
  var response = await Crud().postRequst(link, Data);
  print("remore Data $response");
  return response!.fold((l) => l, (r) => r);
}

getdata(String link) async {
  var response = await Crud().getRequst(link);
  print("remore Data $response");
  return response!.fold((l) => l, (r) => r);
}

postdataFile(String link, Map Data, File file) async {
  print('=================================================');
  var response = await Crud().postFileRequst(link, Data, file);
  print("remore Data $response");
  return response!.fold((l) => l, (r) => r);
}
