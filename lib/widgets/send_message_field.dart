import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:testvalley_flutter/constants.dart';
import 'package:testvalley_flutter/models/message_card_model.dart';
import 'package:testvalley_flutter/widgets/chat_bubble.dart';

class SendMessageField extends StatefulWidget {
  const SendMessageField({super.key, required this.onMessageSend});
  final Function(ChatBubble) onMessageSend;

  @override
  State<SendMessageField> createState() => _SendMessageFieldState();
}

class _SendMessageFieldState extends State<SendMessageField> {
  final _messageController = TextEditingController();
  bool _isSendButtonEnabled = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(
            Icons.add,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {},
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              color: Theme.of(context).colorScheme.background,
              border: Border.all(color: Colors.white24),
            ),
            child: TextField(
              controller: _messageController,
              onChanged: (text) {
                setState(() {
                  _isSendButtonEnabled = text.isNotEmpty;
                });
              },
              cursorColor: Colors.pink,
              decoration: InputDecoration(
                hintText: '안녕하세요...',
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                hintStyle: const TextStyle(
                  color: Colors.white70,
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      if (_isSendButtonEnabled) {
                        sendMessage(_messageController.text, CHANNEL_URL);
                      }
                    },
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor:
                          _isSendButtonEnabled ? Colors.pink : Colors.grey[800],
                      child: const Icon(Icons.arrow_upward,
                          color: Color(0xff1A1A1A)),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void sendMessage(String message, String url) async {
    try {
      final channel = await OpenChannel.getChannel(url);
      await channel.enter();
      channel.sendUserMessage(UserMessageCreateParams(message: '쿠팡이 또 ...'));

      setState(() {
        _messageController.text = '';
        widget.onMessageSend(ChatBubble(
          chat: ChatModel(
              name: 'reuben',
              message: message,
              isCurrentUser: true,
              day: 1,
              online: 2,
              isPhoto: false),
        ));
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
