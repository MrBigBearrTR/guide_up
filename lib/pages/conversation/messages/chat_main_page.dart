import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guide_up/core/dto/conversation/conversation_card_view.dart';
import 'package:guide_up/core/models/conversation/messages/messages.dart';
import 'package:guide_up/repository/conversation/messages/messages_repository.dart';
import 'package:guide_up/service/conversation/messages/messages_service.dart';
import 'package:guide_up/ui/material/custom_material.dart';
import 'package:intl/intl.dart';

import '../../../core/constant/color_constants.dart';
import '../../../core/utils/user_info_helper.dart';

class ChatMainPage extends StatefulWidget {
  const ChatMainPage({Key? key}) : super(key: key);

  @override
  State<ChatMainPage> createState() => _ChatMainPageState();
}

class _ChatMainPageState extends State<ChatMainPage> {
  late ConversationCardView conversationCardView;
  final _mesajController = TextEditingController();
  List<Messages> messagesList = [];
  bool _checkMessagesControl = false;
  FocusNode _messagesFocusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    conversationCardView =
        ModalRoute.of(context)!.settings.arguments as ConversationCardView;

    getMessagesList(conversationCardView);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 15, 0),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: UserInfoHelper.getProfilePictureByPath(
                  conversationCardView.otherParticipantPhoto),
            ),
          ),
        ],
        title: Text(
          conversationCardView.otherParticipantFullName,
          style: GoogleFonts.nunito(
            textStyle: const TextStyle(
              color: ColorConstants.darkBack,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: CustomMaterial.backgroundBoxDecoration,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                reverse: true,
                itemBuilder: (context, index) {
                  if (index + 1 < messagesList.length &&
                      messagesList[(index + 1)].getSenderUserId()!.compareTo(
                              messagesList[index].getSenderUserId()!) ==
                          0) {
                    return createChatBox(
                        messagesList[(index + 1)], messagesList[index]);
                  } else {
                    return createChatBox(null, messagesList[index]);
                  }
                },
                itemCount: messagesList.length,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 8, left: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onSubmitted: (value) => setMessage(context),
                      controller: _mesajController,
                      focusNode: _messagesFocusNode,
                      cursorColor: Colors.blueGrey,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Mesajınızı Yazın",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 4,
                    ),
                    child: FloatingActionButton(
                      shape: const CircleBorder(),
                      //elevation: 0,
                      backgroundColor: Colors.blue,
                      child: const Icon(
                        Icons.navigation,
                        size: 35,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        setMessage(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      MessagesRepository()
          .getMessagesList(
              conversationCardView.id, 20, messagesList.last.getCreateDate()!)
          .then((oldMessageList) {
        if (oldMessageList.isNotEmpty) {
          messagesList.addAll(oldMessageList);
          setState(() {});
        }
      });
    }
  }

  void getMessagesList(ConversationCardView conversationCardView) async {
    if (!_checkMessagesControl) {
      messagesList = await MessagesRepository()
          .getMessagesList(conversationCardView.id, 20, null);

      if (messagesList.isNotEmpty) {
        _checkMessagesControl = true;
        setState(() {});
      }

      MessagesRepository()
          .getLastMessagesStream(
              conversationCardView.id, conversationCardView.myUserId)
          .listen((event) {
        if (event.isNotEmpty && event.first.getId() != null) {
          Messages messages = event.first;
          bool isContains = false;
          for (var mes in messagesList) {
            if (messages.getId()!.compareTo(mes.getId()!) == 0) {
              isContains = true;
              break;
            }
          }
          if (!isContains) {
            messagesList.insert(0, messages);
            setState(() {});
          }
        }
      });
    }
  }

  Widget createChatBox(
      Messages? previousMessagesModel, Messages messagesModel) {
    Color comingMessageColor = Colors.blue;
    Color sentMessageColor = Theme.of(context).primaryColor;
    var hourMinuteText = "";
    bool timeIsSame = false;

    try {
      hourMinuteText = _convertToHourMinuteText(
          messagesModel.getCreateDate() ?? DateTime.now());
      if (previousMessagesModel != null) {
        var previous = _convertToHourMinuteText(
            previousMessagesModel.getCreateDate() ?? DateTime.now());
        timeIsSame = hourMinuteText.compareTo(previous) == 0;
      }
    } catch (e) {
      print("hata var:" + e.toString());
    }
    bool messageIsMine;
    if (messagesModel
            .getSenderUserId()!
            .compareTo(conversationCardView.myUserId) ==
        0) {
      messageIsMine = true;
    } else {
      messageIsMine = false;
    }
    if (messageIsMine) {
      return Padding(
        padding: timeIsSame
            ? const EdgeInsets.fromLTRB(8, 0, 8, 0)
            : const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: sentMessageColor,
                    ),
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(4),
                    child: Text(
                      messagesModel.getContent() ?? "",
                      style: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                          fontSize: 13,
                          color: ColorConstants.textwhite,
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  hourMinuteText,
                  style: GoogleFonts.nunito(
                    textStyle: TextStyle(
                      fontSize: 10,
                      color: timeIsSame
                          ? Colors.transparent
                          : ColorConstants.darkBack,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: timeIsSame
            ? const EdgeInsets.fromLTRB(8, 0, 8, 0)
            : const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Visibility(
                  visible: !timeIsSame,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey.withAlpha(40),
                    backgroundImage: UserInfoHelper.getProfilePictureByPath(
                        conversationCardView.otherParticipantPhoto),
                  ),
                ),
                Visibility(
                    visible: timeIsSame,
                    child: const Padding(padding: EdgeInsets.all(20))),
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: comingMessageColor,
                    ),
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(4),
                    child: Text(messagesModel.getContent() ?? ""),
                  ),
                ),
                Text(
                  hourMinuteText,
                  style: GoogleFonts.nunito(
                    textStyle: TextStyle(
                      fontSize: 10,
                      color: timeIsSame
                          ? Colors.transparent
                          : ColorConstants.darkBack,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    }
  }

  String _convertToHourMinuteText(DateTime date) {
    var formatter = DateFormat.Hm();
    var formattedDate = formatter.format(date);
    return formattedDate;
  }

  void setMessage(BuildContext context) async {
    if (_mesajController.text.trim().isNotEmpty) {
      Messages messageModel = Messages();
      messageModel.setSenderUserId(conversationCardView.myUserId);
      messageModel
          .setReceiverUserId(conversationCardView.otherParticipantUserId);
      messageModel.setConversationId(conversationCardView.id);
      messageModel.setContent(_mesajController.text.trim());

      var sonuc =
          await MessagesService().add(messageModel, conversationCardView);
      if (sonuc.getId() != null) {
        _mesajController.clear();
        FocusScope.of(context).requestFocus(_messagesFocusNode);
        /*_scrollController.animateTo(
                        0,
                        curve: Curves.easeOut,
                        duration: const Duration(milliseconds: 10),
                      );*/
      }
    }
  }
}
