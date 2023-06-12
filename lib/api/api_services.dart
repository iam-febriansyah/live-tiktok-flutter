// ignore_for_file: unnecessary_brace_in_string_interps, use_build_context_synchronously, avoid_print

import 'dart:async';
import 'dart:convert';
import 'package:collect_data/models/model_response.dart';
import 'package:collect_data/pages/auth/page_signin.dart';
import 'package:collect_data/pages/widgets/widget_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:collect_data/controllers/ctrl.dart';

class ApiService {
  int timeOut = 30;
  var url = Get.put(Ctrl()).httpMainUrl;
  static const String urlAccess = "/api/access";
  static const String urlSetUsername = "/api/set-username";

  Future<GlobalResponse> fetchPost(BuildContext ctx, String endPoint, dynamic auth, Map data) async {
    try {
      var body = jsonEncode(data);
      final response = await http
          .post(Uri.parse(url + endPoint),
              headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': auth},
              body: body)
          .timeout(Duration(seconds: timeOut),
              onTimeout: () => throw TimeoutException('Can\'t connect in ${timeOut} seconds.'));
      if (response.statusCode == 200) {
        print(response.body);
        GlobalResponse res = GlobalResponse.fromJson(jsonDecode(response.body));
        if (res.remarks == 'Unauthorized') {
          Get.offAll(const PageSignIn());
          res.remarks = "You'r Unauthorized, please Sign In again";
          WidgetSnackbar(context: ctx, message: res.remarks, warna: "merah");
        }
        return res;
      } else {
        Map<String, dynamic> res = {};
        res['status'] = false;
        res['remarks'] = 'Failed to post error $endPoint';
        return GlobalResponse.fromJson(res);
      }
    } catch (e) {
      Map<String, dynamic> res = {};
      res['status'] = false;
      res['remarks'] = e.toString();
      return GlobalResponse.fromJson(res);
    }
  }

  Future<GlobalResponse> apiAccess(BuildContext ctx, Map data) async {
    try {
      return await fetchPost(ctx, urlAccess, '', data);
    } catch (e) {
      Map<String, dynamic> res = {};
      res['status'] = false;
      res['remarks'] = e.toString();
      return GlobalResponse.fromJson(res);
    }
  }

  Future<GlobalResponse> apiSetUsername(BuildContext ctx, Map data) async {
    try {
      return await fetchPost(ctx, urlSetUsername, '', data);
    } catch (e) {
      Map<String, dynamic> res = {};
      res['status'] = false;
      res['remarks'] = e.toString();
      return GlobalResponse.fromJson(res);
    }
  }
}
