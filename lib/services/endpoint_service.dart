//import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/utils/constants.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

/* import 'package:graphql/client.dart';
import 'package:nhost_graphql_adapter/nhost_graphql_adapter.dart'; */
import 'global_service.dart';

class EndpointService extends GetxService {
  static EndpointService get to => Get.find<EndpointService>();
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

// custom query fun
  Future<void> exampleEndpointServiceFunction(
      String query, var queryVariable) async {
    dio.Response r = await graphqlClient
        .post('',
            data: {"query": query, "variables": queryVariable},
            options: dio.Options(headers: {
              'Content-Type': "application/json",
              'Authorization': "Bearer ${GlobalService.to.getAccessToken()}"
            }))
        .catchError((err) {
      debugPrint(err);
    });
    debugPrint(r.data);
  }

//query and mutation using nhost and graphql pkg
  /*  Future<QueryResult> graphqlService(String query, var queryVariable) async {
    final graphqlClient = createNhostGraphQLClient(GlobalService.to.client);
    QueryResult queryResult = await graphqlClient
        .query(QueryOptions(document: gql(query), variables: queryVariable));
    return queryResult;
  }

  Future grahqlMutation(final query, var object) async {
    final graphqlClient = createNhostGraphQLClient(GlobalService.to.client);
    QueryResult queryResult = await graphqlClient.mutate(
        MutationOptions(document: gql(query), variables: {"object": object}));
    debugPrint('imagedata started');
    if (queryResult.hasException) {
      debugPrint('imagedata1$queryResult');
      await GlobalService.to.refetchToken();
      grahqlMutation(query, object);
    } else {
      debugPrint('imagedata1$queryResult');
      return queryResult.data;
    }
  } */
}
