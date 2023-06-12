// ignore_for_file: use_build_context_synchronously, avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_string_interpolations

import 'package:collect_data/controllers/ctrl.dart';
import 'package:collect_data/controllers/ctrl_auth.dart';
import 'package:collect_data/controllers/ctrl_socket.dart';
import 'package:collect_data/models/model_response.dart';
import 'package:collect_data/pages/widgets/widget_progress.dart';
import 'package:collect_data/sql/models/01_chat.dart';
import 'package:collect_data/sql/models/02_gift.dart';
import 'package:collect_data/style/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resizable_draggable_widget/resizable_draggable_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

Ctrl ctrl = Get.put(Ctrl());

class PageMenuHome extends StatefulWidget {
  const PageMenuHome({super.key});

  @override
  State<PageMenuHome> createState() => _PageMenuHomeState();
}

class _PageMenuHomeState extends State<PageMenuHome> {
  bool isSet = false;
  TextEditingController ctrlUsername = TextEditingController();
  CtrlAuth ctrlAuth = Get.put(CtrlAuth());
  CtrlSocket ctrlSocket = Get.put(CtrlSocket());

  void save() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var oldUsername = pref.getString("PREF_USERNAME") ?? '';
    var license = pref.getString("PREF_LICENSE") ?? '';
    if (oldUsername == '') {
      setState(() {
        isSet = false;
      });
    }
    if (ctrlUsername.text != '' && license != '' && !isSet) {
      showDialog(context: context, barrierDismissible: false, builder: (BuildContext context) => const WidgetProgressSubmit());
      GlobalResponse res = await ctrlAuth.actionAccess(context, license, ctrlUsername.text);
      if (res.status) {
        setState(() {
          isSet = true;
        });
      }
    }
  }

  @override
  void initState() {
    ctrlUsername.text = 'bogormistis';
    save();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CtrlSocket>(builder: (ctrl) {
      return !isSet
          ? setUsername()
          : Container(
              color: Colors.transparent,
              child: Column(
                children: [cardGift(ctrl.listGiftSql), cardSultan(ctrl.listChatSql)],
              ),
            );
    });
  }

  Widget cardGift(List<SqlGift> list) {
    return ResizableDraggableWidget(
      initHeight: 200,
      initWidth: MediaQuery.of(context).size.width * 0.35,
      showSquare: false,
      draggable: true,
      bgColor: Colors.transparent,
      squareColor: Colors.white,
      changed: (width, height, tranformOffset) {
        // print("width: $width, height: $height, tranformOffset: $tranformOffset");
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.transparent, borderRadius: BorderRadius.circular(4.0), border: Border.all(color: ColorsTheme.primary1.withOpacity(0.2))),
        height: 200,
        width: MediaQuery.of(context).size.width * 0.35,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(4),
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.rosette,
                    color: Colors.red,
                  ),
                  Text("List Gift"),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    // print(ctrl.listGiftSql[index].giftName);
                    return gift(list[index]);
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget cardSultan(List<SqlChat> list) {
    return ResizableDraggableWidget(
      initHeight: 200,
      initWidth: MediaQuery.of(context).size.width * 0.35,
      showSquare: false,
      draggable: true,
      bgColor: Colors.transparent,
      squareColor: Colors.white,
      changed: (width, height, tranformOffset) {
        // print("width: $width, height: $height, tranformOffset: $tranformOffset");
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.transparent, borderRadius: BorderRadius.circular(4.0), border: Border.all(color: Colors.orange.withOpacity(0.2))),
        height: 200,
        width: MediaQuery.of(context).size.width * 0.35,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(4),
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.money_dollar,
                    color: Colors.orange,
                  ),
                  Text("List Sultan"),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return sultan(list[index]);
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget setUsername() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: ColorsTheme.background2,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: ctrlUsername,
                  decoration: const InputDecoration(border: InputBorder.none, hintText: 'Domain/IP'),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: IconButton(
                    icon: const Icon(
                      Icons.check,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      save();
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget gift(SqlGift dt) {
    return Padding(
      padding: const EdgeInsets.only(left: 2, right: 2, top: 2, bottom: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 48,
            backgroundImage: NetworkImage(dt.profilePictureUrl),
          ),
          const SizedBox(width: 8),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
              color: ColorsTheme.background2,
              borderRadius: BorderRadius.circular(8),
            ),
            height: 20,
            width: MediaQuery.of(context).size.width * 1,
            child: Text(
              dt.nickname,
              style: const TextStyle(fontSize: 12),
            ),
          )),
          const SizedBox(width: 8),
          Image.network(dt.giftPictureUrl, fit: BoxFit.cover),
        ],
      ),
    );
  }

  Widget sultan(SqlChat dt) {
    return Padding(
      padding: const EdgeInsets.only(left: 2, right: 2, top: 2, bottom: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 48,
            backgroundImage: NetworkImage(dt.profilePictureUrl),
          ),
          const SizedBox(width: 8),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
              color: ColorsTheme.background2,
              borderRadius: BorderRadius.circular(8),
            ),
            height: 20,
            width: MediaQuery.of(context).size.width * 1,
            child: Text(
              dt.nickname,
              style: const TextStyle(fontSize: 12),
            ),
          )),
          const SizedBox(width: 8),
          Text(
            dt.comment,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
