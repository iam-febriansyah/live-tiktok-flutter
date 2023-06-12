// ignore_for_file: unnecessary_overrides, use_build_context_synchronously
import 'package:collect_data/api/api_services.dart';
import 'package:collect_data/controllers/ctrl.dart';
import 'package:collect_data/controllers/ctrl_socket.dart';
import 'package:collect_data/models/model_response.dart';
import 'package:collect_data/models/model_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:collect_data/helpers/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CtrlAuth extends GetxController {
  ApiService apiService = ApiService();
  Ctrl ctrl = Get.put(Ctrl());
  CtrlSocket ctrlSocket = Get.put(CtrlSocket());
  String domainIP = Constant.domainIP;
  String port = Constant.port;
  String mainUrl = Constant.mainUrl;
  String httpMainUrl = Constant.httpMainUrl;
  bool isLoading = true;
  bool isError = false;
  String remark = "";

  Future<GlobalResponse> actionAccess(BuildContext ctx, String license, String username) async {
    try {
      isLoadingTrue(ctx);
      Map data = {};
      data['license'] = license;
      data['username'] = username;
      var response = await apiService.apiSetUsername(ctx, data);
      if (response.status) {
        ctrlSocket.setSocketMe(username);
      }
      isLoadingFalse(ctx, response.status ? '' : response.remarks);
      return response;
    } catch (e) {
      return catchErr(ctx, e);
    }
  }

  Future<GlobalResponse> actionSignIn(BuildContext ctx, String license) async {
    try {
      isLoadingTrue(ctx);
      Map data = {};
      data['license'] = license;
      var response = await apiService.apiAccess(ctx, data);
      if (response.status) {
        await setPrefSession(response.user!);
      }
      isLoadingFalse(ctx, response.status ? '' : response.remarks);
      return response;
    } catch (e) {
      return catchErr(ctx, e);
    }
  }

  loginMandatory(String license) {
    if (license.isEmpty) {
      return "Please enter email";
    } else {
      return "";
    }
  }

  Future setPrefSession(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("PREF_USER_ID", user.userId);
    pref.setString("PREF_EMAIL", user.email);
    pref.setString("PREF_DOMAIN", user.domain);
    pref.setString("PREF_LICENSE", user.license);
    pref.setString("PREF_EXPIRE_DATE", user.expireDate);
    pref.setString("PREF_START_DATE", user.startDate!);
    pref.setString("PREF_LAST_ACTIVITY_DATE", user.lastActivityDate!);
    pref.setString("PREF_ON_LIVE", user.onLive.toString());
    return;
  }

  GlobalResponse catchErr(BuildContext ctx, e) {
    Map<String, dynamic> res = {};
    res['status'] = false;
    res['remarks'] = e.toString();
    isLoadingFalse(ctx, e.toString());
    return GlobalResponse.fromJson(res);
  }

  void isLoadingTrue(BuildContext ctx) {
    isLoading = true;
    isError = false;
    update();
  }

  void isLoadingFalse(BuildContext ctx, String err) {
    FocusScope.of(ctx).requestFocus(FocusNode());
    isLoading = false;
    isError = err == '' ? false : true;
    remark = err;
    Navigator.of(ctx, rootNavigator: true).pop();
    update();
  }

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
