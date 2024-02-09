import 'package:flutter/material.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:testvalley_flutter/constants.dart';
import 'package:testvalley_flutter/models/message_card_model.dart';
import 'package:testvalley_flutter/utils/list.dart';
import 'package:testvalley_flutter/widgets/app_bar.dart';
import 'package:testvalley_flutter/widgets/chat_bubble.dart';
import 'package:testvalley_flutter/widgets/loader.dart';
import 'package:testvalley_flutter/widgets/send_message_field.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late ScrollController _scrollController;

  final timestamp = 9223372036854775807;

  bool isLoading = false;

  List<ChatBubble> chatList = [];

  @override
  void initState() {
    chatList = previousTexts
        .map((e) => ChatBubble(
              chat: ChatModel.fromJson(e),
            ))
        .toList();
    getChannel(CHANNEL_URL);
    _scrollController = ScrollController();

    super.initState();
  }

  bool isSendingLoading = false;

  bool isTyping = false;

  List<BaseMessage> allMessages = [];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 200), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
    return Scaffold(
      appBar: customAppBar(context),
      backgroundColor: Colors.black,
      body: isLoading
          ? LoadingEffect.getSearchLoadingScreen(context)
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        controller: _scrollController,
                        itemCount: chatList.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          return chatList[index];
                        }),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SendMessageField(
                    onMessageSend: (chat) {
                      chatList.add(chat);
                      setState(() {});
                    },
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                ],
              ),
            ),
    );
  }

  void getChannel(String url) async {
    try {
      setState(() {
        isLoading = true;
      });
      final user = await SendbirdChat.connect('reuben');
      print(user.userId);
      final channel = await OpenChannel.getChannel(url);
      await channel.enter();

      final query = PreviousMessageListQuery(
        channelType: channel.channelType,
        channelUrl: channel.channelUrl,
      );

      final messages = await query.next();

      setState(() {
        isLoading = false;
      });
      for (BaseMessage element in messages) {
        chatList.add(ChatBubble(
          chat: ChatModel(
              name: "Other user",
              message: element.message,
              isCurrentUser: element.sender?.userId == user.userId,
              day: 1,
              online: 1,
              isPhoto: false),
        ));
      }
      allMessages = messages;
    } catch (e) {
      print(e);
    }
  }
}
