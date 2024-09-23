import 'package:crew_app/models/message_model.dart';
import 'package:crew_app/modules/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpController extends BaseController {
  final RxList<MessageModel> messages = <MessageModel>[].obs;
  final TextEditingController textController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadInitialMessages();
  }

  void loadInitialMessages() {
    messages.addAll([
      MessageModel(text: "Good morning! How are you doing?", isMe: false, time: "16:46"),
      MessageModel(text: "You did your job well!", isMe: true, time: "16:50"),
    ]);
  }

  void sendMessage() {
    if (textController.text.isNotEmpty) {
      messages.add(MessageModel(
        text: textController.text,
        isMe: true,
        time: DateTime.now().toString().substring(11, 16),
      ));
      textController.clear();
    }
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}