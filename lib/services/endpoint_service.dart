import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/services/endpoint_queries.dart';
import 'package:flutter_boilerplate/utils/constants.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class EndpointService extends GetxService {
  late dio.Dio graphqlClient;

  @override
  void onInit() {
    graphqlClient = dio.Dio(dio.BaseOptions(
        baseUrl: AppConstants.graphqlEndpoint,
        contentType: 'application/json',
        responseType: dio.ResponseType.json,
        headers: {},
        sendTimeout: 10000));
    super.onInit();
  }

  Future<void> exampleEndpointServiceFunction(
      String argument1, String argument2, String accessToken) async {
    dio.Response r = await graphqlClient
        .post('',
            data: {
              "query": Queries.examplequery,
              "variables": {
                "example1": argument1,
                "example2": argument2,
              }
            },
            options: dio.Options(headers: {
              'Content-Type': "application/json",
              'Authorization': "Bearer $accessToken"
            }))
        .catchError((err) {
      debugPrint(err);
    });
    debugPrint(r.data);
  }
}
