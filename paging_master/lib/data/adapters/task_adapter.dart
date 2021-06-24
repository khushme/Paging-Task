import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:paging_master/constants/strings/strings.dart';
import 'package:paging_master/constants/url_constants.dart';
import 'package:paging_master/data/model/task_model.dart';
import 'package:paging_master/data/network/network_provider.dart';
import 'package:paging_master/utilities/snack_bar.dart';


class TaskAdapter {
  //separate network provider for each data model will keep us ready for microservices.
  final NetworkProvider _networkProvider =
      NetworkProvider(baseUrl: "${UrlConstants.masterApiUrl}");

  TaskAdapter({Map<String, String> headers = const {}}) {
    _networkProvider.setHeaders(headers);
  }


 //Function to perform network operation and fetch data list
  Future<TaskModel> loadTasks({@required String page}) async {
    TaskModel taskModel =TaskModel();
    Response response = await _networkProvider
        .get(path: "/", queryParameters: {UrlConstants.pageEndPoint: page});
    if (response.statusCode == 200) {
      taskModel = TaskModel.fromJson(jsonDecode(response.toString()));
    }
    else{
      showSnackBar(message: StringConstants.somethingWrong);
    }
    return taskModel;
  }

}
