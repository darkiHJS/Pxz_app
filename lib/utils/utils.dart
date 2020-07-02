import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:hello_world/utils/Request.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

Future<ImageData> updateAssetsToAliyun(AssetEntity asset, String type) async {
  File file = await asset.file;
  ImageData imagedata;
  Response updateCell;
  var data;
  var cell = await PxzRequest().get("/console/public_trait/upload",
      data: {"old_name": asset.title, "bucket_type": type});
  data = cell["data"];
  print(data);
  String fileMd5 = md5.convert(await file.readAsBytes()).toString();
  List<String> nameAndType = asset.title.split(".");
  FormData fileFormData = FormData.fromMap({
    "key": "images/$fileMd5.${nameAndType[1]}",
    "policy": data["policy"],
    "OSSAccessKeyId": data["accessid"],
    "success_action_status": "200",
    "callback": data["callback"],
    "signature": data["signature"],
    "file": await MultipartFile.fromFile(file.path,
        filename: "$fileMd5.${nameAndType[1]}")
  });
  try {
    updateCell = await Dio().post(data["host"], data: fileFormData);
    print(updateCell.data);
  } on DioError catch (e) {
    print("请求失败 --- 错误类型${e.type} $e");
  }
  imagedata = ImageData(
    url: updateCell.data["data"]["url"].toString(), 
    md5: updateCell.data["data"]["md5"].toString()
  );

  return imagedata;
}

class ImageData {
  String url;
  String md5;
  ImageData({this.md5, this.url});
}