// ignore_for_file: unnecessary_overrides, use_build_context_synchronously, library_prefixes, avoid_print, prefer_adjacent_string_concatenation, prefer_interpolation_to_compose_strings, unnecessary_null_comparison

import 'package:collect_data/sql/models/01_chat.dart';
import 'package:collect_data/sql/models/02_gift.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class CtrlSocket extends GetxController {
  IO.Socket? socket;
  List<SqlChat> listChatSql = [];
  List<SqlGift> listGiftSql = [];
  Box<SqlChat> chatBox = Hive.box<SqlChat>('chatBox');
  Box<SqlGift> giftBox = Hive.box<SqlGift>('giftBox');

  void setSocket(IO.Socket socketParam) async {
    socket = socketParam;
    update();
  }

  void setSocketMe(String userName) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var license = pref.getString("PREF_LICENSE") ?? '';
    var oldUsername = pref.getString("PREF_USERNAME") ?? '';
    socket!.on('chat_' + userName + '_' + license, (data) {
      addChatDb(data);
    });
    socket!.on('gift_' + userName + '_' + license, (data) {
      addGiftDb(data);
    });
    socket!.off('chat_' + oldUsername + '_' + license);
    socket!.off('gift_' + oldUsername + '_' + license);
    pref.setString("PREF_USERNAME", userName);
    update();
  }

  void addChatDb(e) async {
    try {
      Box<SqlChat> sqlChatBox = Hive.box<SqlChat>('chatBox');
      SqlChat data = SqlChat(
          chatIdKey: e['chat_id_key'],
          userId: e['userId'],
          uniqueId: e['uniqueId'],
          nickname: e['nickname'],
          profilePictureUrl: e['profilePictureUrl'],
          comment: e['comment'],
          isSubscriber: e['isSubscriber'],
          followRole: e['followRole'],
          createdAt: e['createdAt']);
      sqlChatBox.put(e['chat_id_key'], data);
      listChatSql = chatBox.values.toList();
      update();
    } catch (e) {
      print(e);
    }
  }

  void addGiftDb(e) async {
    try {
      Box<SqlGift> sqlGiftBox = Hive.box<SqlGift>('giftBox');
      SqlGift data = SqlGift(
          giftIdKey: e['gift_id_key'],
          userId: e['userId'],
          uniqueId: e['uniqueId'],
          nickname: e['nickname'],
          profilePictureUrl: e['profilePictureUrl'],
          giftId: e['gift_id'],
          repeatCount: e['repeat_count'],
          giftName: e['giftName'],
          diamondCount: e['diamondCount'],
          giftPictureUrl: e['giftPictureUrl'],
          createdAt: e['createdAt']);
      sqlGiftBox.put(e['gift_id_key'], data);
      listGiftSql = giftBox.values.toList();
      update();
    } catch (e) {
      print(e);
    }
  }

  void emitStatusOnline(String status) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String userId = pref.getString("PREF_USER_ID") ?? '';
    socket!.emit('online_$userId', status);
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
