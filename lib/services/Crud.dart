import 'dart:convert';
import 'dart:io';
import 'package:content_app/functions/checkinternet.dart';
import 'package:content_app/main.dart';
import 'package:content_app/services/statusRequst.dart';
import 'package:content_app/view/screen/auth/auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart'; //عشان اقدر ارجع نوعين من الريكوست either
import 'package:path/path.dart';

class Crud {
  var token = sharedPreference.getString('token');

  ///////////post requst
  Future<Either<StatusRequest, Map>?> postRequst(String url, Map data) async {
    try {
      if (await checkInternet()) {
        var response = await http.post(
          Uri.parse(url),
          body: data,
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          },
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responsebody = jsonDecode(response.body);
          print(responsebody);

          return Right(responsebody);
        } else {
          return const Left(StatusRequest.serverfailure);
        }
      } else {
        return const Left(StatusRequest.offlinefailure);
      }
    } catch (e) {
      print("$e");
    }
  } //end function

  //post requst with file
  Future<Either<StatusRequest, Map>?> postFileRequst(
      String url, Map data, File file) async {
    print(token);
    try {
      if (await checkInternet()) {
        //////////
        var request = await http.MultipartRequest("POST", Uri.parse(url));
        var length = await file.length();
        var stream = http.ByteStream(file.openRead());
        var multipartfile = await http.MultipartFile("image", stream, length,
            filename: basename(file.path));

        request.files.add(multipartfile); //add file to requst
        var headers = {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        };
        request.headers.addAll(headers); //add header to requst

        data.forEach((key, value) {
          //to add another data to requst
          return request.fields[key] = value;
        });

        var myRequest = await request.send(); //send requst
        var respones =
            await http.Response.fromStream(myRequest); // نحصل على الريسبونس
        print(respones.statusCode);
        if (respones.statusCode == 200 || respones.statusCode == 201) {
          Map responsebody = jsonDecode(respones.body);
          return Right(responsebody);
        } else {
          return const Left(StatusRequest.serverfailure);
        }
      } else {
        return const Left(StatusRequest.offlinefailure);
      }
    } catch (e) {
      print("$e");
    }
  } //end function

////////////////  get request
  Future<Either<StatusRequest, Map>?> getRequst(String url) async {
    var response = await http.get(
      Uri.parse(url),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    print(response.statusCode);

    if (response.statusCode == 200 || response.statusCode == 201) {
      Map responsebody = jsonDecode(response.body);
      print(responsebody);

      return Right(responsebody);
    } else {
      return const Left(StatusRequest.serverfailure);
    }
  } //end function

  logout() async {
    Get.offAll(() => Auth());
    await sharedPreference.remove('id');
    await sharedPreference.remove('token');
    await sharedPreference.remove('email');
  } //end function
}
