import 'dart:io';

checkInternet() async {
  try {
    var result = await InternetAddress.lookup(
        'google.com'); //يبحث عن الاتصال بهذا الهوست
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      //ruslt بيكون فيها عنوانين الاتصال بالانترنت
      //اذا لم يكون فارغ
      return true;
    }
  } on SocketException catch (e) {
    // فشل في الاتصال بالانترنت
    return false;
  }
}
