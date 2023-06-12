// ignore_for_file: unused_element

import 'dart:async';

import 'package:collect_data/controllers/ctrl.dart';
import 'package:collect_data/controllers/ctrl_socket.dart';
import 'package:collect_data/pages/menus/menu_home.dart';
import 'package:collect_data/pages/menus/menu_setting.dart';
import 'package:flutter/material.dart';
import 'package:collect_data/style/color.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageLayout extends StatefulWidget {
  const PageLayout({super.key});

  @override
  State<PageLayout> createState() => _PageLayoutState();
}

class _PageLayoutState extends State<PageLayout> {
  CtrlSocket ctrlSocket = Get.put(CtrlSocket());
  int _selectedIndex = 0;
  String titlePage = 'Please set account';

  static const List<Widget> _pages = <Widget>[PageMenuHome(), PageMenuSetting()];
  static const List<String> titlePages = ['Chats', 'Account'];
  Timer? timer;

  void _onItemTapped(int index) {
    if (mounted) {
      setState(() {
        _selectedIndex = index;
        titlePage = titlePages[index];
      });
    }
  }

  void account() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      titlePage = pref.getString("PREF_USERNAME") ?? 'Please set account';
    });
  }

  @override
  void initState() {
    account();
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Ctrl>(builder: (ctrl) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            titlePage,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: ColorsTheme.primary1,
          toolbarOpacity: 0,
          bottomOpacity: 0,
          elevation: 0,
          actions: [
            const Padding(
                padding: EdgeInsets.only(top: 4, bottom: 4),
                child: Icon(
                  Icons.refresh,
                  color: Colors.white,
                )),
            Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 4, right: 16),
              child: Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ctrl.conColor,
                  border: Border.all(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        body: Center(
          child: _pages.elementAt(_selectedIndex),
        ),
      );
    });
  }
}
