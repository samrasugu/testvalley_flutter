import 'package:flutter/material.dart';
import 'package:testvalley_flutter/models/message_card_model.dart';

class ChatBubble extends StatelessWidget {
  final ChatModel chat;

  const ChatBubble({
    Key? key,
    required this.chat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Align(
        alignment:
            chat.isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
        child: chat.isCurrentUser
            ? _buildMyMessageBubble()
            : _buildOtherUserMessageBubble(),
      ),
    );
  }

  //This will be my message bubble

  Widget _buildMyMessageBubble() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
        gradient: LinearGradient(
          colors: [
            Color(0xFFFF006B),
            Color(0xFFFF4593),
          ],
        ),
      ),
      child: Text(
        chat.message,
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }

  //This will be other user message bubble
  Widget _buildOtherUserMessageBubble() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (chat.isPhoto && chat.photoAvatar != null)
          Container(
            height: 32,
            width: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(chat.photoAvatar!),
              ),
            ),
          ),
        if (!chat.isPhoto)
          Container(
            height: 32,
            width: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: chat.hasBlueBorder != null && chat.hasBlueBorder!
                    ? Colors.blue
                    : Colors.red,
              ),
            ),
            child: const Center(child: Text('👻')),
          ),
        const SizedBox(width: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
            color: Color(0xFF1A1A1A),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUserNameAndStatus(),
              const SizedBox(height: 10),
              _buildMessageText(),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(height: 60),
            Text(
              '${chat.day}분 전',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        )
      ],
    );
  }

//This will be the user name and status
  Widget _buildUserNameAndStatus() {
    return Row(
      children: [
        Text(
          chat.name,
          style: const TextStyle(color: Colors.grey),
        ),
        const SizedBox(width: 10),
        const Icon(
          Icons.circle,
          color: Color(0xFF46F9F5),
          size: 10,
        ),
      ],
    );
  }

//This will be the message text
  Widget _buildMessageText() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 240),
      child: Text(
        chat.message,
        style: const TextStyle(color: Colors.white, fontSize: 15),
      ),
    );
  }
}
