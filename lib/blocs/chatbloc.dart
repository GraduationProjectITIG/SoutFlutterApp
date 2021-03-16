import 'package:rxdart/rxdart.dart';
import 'package:sout/base_bloc.dart';
import 'package:sout/models/models.dart';

class ChatBloc implements BaseBloc {
  static final _chat = ChatModel();

  final BehaviorSubject<ChatModel> _chatController =
      BehaviorSubject<ChatModel>.seeded(_chat);

  Stream<ChatModel> get stream => _chatController.stream;

  ChatModel get chat => _chat;

  Future getUserChats(String userID) async {
    await _chat.getUserChats(userID).then((chats) => chats.forEach((chat) {
          _chatController.add(chat);
        }));
  }

  Future sendMessage(MessageModel msg, String chatId) async {
    await _chat.sendMessage(msg, chatId);
  }

  @override
  void dispose() {
    _chatController.drain();
    _chatController.close();
  }
}
