import 'package:crew_app/components/frequent_widgets.dart';
import 'package:crew_app/gen/assets.gen.dart';
import 'package:crew_app/gen/colors.gen.dart';
import 'package:crew_app/models/message_model.dart';
import 'package:crew_app/modules/help/help_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Help extends GetView<HelpController> {
  const Help({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(Get.width, 90),
        child: Container(
          margin: const EdgeInsets.only(top: 54),
          padding:
              const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 14),
          decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: ColorName.gray11))),
          child: Row(
            children: [
              IconButton(
                highlightColor: Colors.transparent,
                onPressed: () => Get.back(),
                icon: Assets.svgs.iconBackArrowIos.svg(),
              ),
              Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                  color: ColorName.blue3,
                  shape: BoxShape.circle,
                ),
              ),
              hPad11,
              Text(
                'Jenny Wilson',
                style: Get.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: ColorName.black,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Obx(() => Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    // Reverse the index to maintain correct order
                    final message = controller
                        .messages[controller.messages.length - 1 - index];
                    return _buildMessageBubble(message);
                  },
                ),
              ),
              _buildInputArea(),
            ],
          )),
    );
  }

  Widget _buildMessageBubble(MessageModel message) {
    return Align(
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: message.isMe ? ColorName.blue3 : ColorName.gray11,
          borderRadius: BorderRadius.only(
            topRight: const Radius.circular(20),
            topLeft: const Radius.circular(20),
            bottomLeft: Radius.circular(message.isMe ? 20 : 0),
            bottomRight: Radius.circular(message.isMe ? 0 : 20),
          ),
        ),
        child: Column(
          crossAxisAlignment:
              message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              message.text,
              style: Get.textTheme.bodyMedium!.copyWith(
                  color: message.isMe ? ColorName.white : ColorName.black),
            ),
            vPad4,
            Text(
              message.time,
              style: Get.textTheme.bodySmall!.copyWith(
                color: message.isMe ? Colors.white70 : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20)
          .copyWith(bottom: 24, top: 22),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: ColorName.gray10),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller.textController,
              decoration: InputDecoration(
                hintText: 'Write text',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide.none,
                ),
                fillColor: ColorName.gray11,
                filled: true,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
          ),
          hPad11,
          GestureDetector(
            onTap: controller.sendMessage,
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: ColorName.blue3,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Assets.svgs.iconSend.svg(),
            ),
          ),
        ],
      ),
    );
  }
}
