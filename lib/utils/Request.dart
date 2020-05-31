import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PxzRequest {
  // 在网络请求过程中可能会需要使用当前的context信息，比如在请求失败时
  // 打开一个新路由，而打开新路由需要context信息。
  // PxzRequest([this.context]) {
  //   _options = Options(headers: {'context': context});
  // }

  BuildContext context;
  // Options _options;

  static Dio dio = new Dio(BaseOptions(
      baseUrl: "http://www.paixiaozhua.com",
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
      receiveDataWhenStatusError: false,
      connectTimeout: 30000,
      receiveTimeout: 3000,
      headers: {"X-REQUESTED-ISAPP": "YES"}));

  static void init() {
    // 添加缓存插件
    // dio.interceptors.add(Global.netCache)
  }

  get(path, {data, options}) async {
    print("get $path --- 请求参数$data");
    Response response;
    try {
      response = await dio.get(
        path,
        queryParameters: data
      );
    } on DioError catch (e) {
      print("请求失败 --- 错误类型${e.type}");
    }

    return response.data;
  }
}

