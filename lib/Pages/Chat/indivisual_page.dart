import 'dart:async';
import 'dart:convert';

import 'package:chat/Pages/Camera%20Page/camera_page.dart';
import 'package:chat/Pages/Chat/widgets/own_file_card.dart';
import 'package:chat/Pages/Chat/widgets/reply_file_card.dart';
import 'package:chat/constants/widgets/app_colors.dart';
import 'package:chat/constants/widgets/media_query.dart';
import 'package:chat/model/chat_model.dart';
import 'package:chat/model/message_model.dart';
import 'package:chat/services/notifcation_services.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../Camera Page/camera_view_page.dart';
import 'widgets/oun_message_card.dart';
import 'widgets/reply_message_card.dart';

class IndivisualPage extends StatefulWidget {
  final ChatModel chatModel;
  final ChatModel? sourcechatModel;
  const IndivisualPage(
      {Key? key, this.sourcechatModel, required this.chatModel})
      : super(key: key);

  @override
  State<IndivisualPage> createState() => _IndivisualPageState();
}

class _IndivisualPageState extends State<IndivisualPage> {
  bool emojiShowing = false;
  FocusNode focusNode = FocusNode();
  io.Socket? socket;
  bool sendbtn = false;
  List<MessageModel> messages = [];
  ScrollController scrollController = ScrollController();
  ImagePicker imagePicker = ImagePicker();
  XFile? file;
  int popTime = 0;
  NotificationService notificationService = NotificationService();
  @override
  void initState() {
    notificationService.initNotification();
    connect();

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          emojiShowing = false;
        });
      }
    });

    super.initState();
  }

  void showNotification({int? user, String? message}) async {
    await notificationService.showNotification(
      title: 'User $user',
      body: message,
    );
  }

  void connect() {
    // http://192.168.1.33:5000
    // url = https://feather-shadowed-sweater.glitch.me
    socket = io.io('https://fair-typhoon-event.glitch.me', <String, dynamic>{
      "transports": [
        "websocket"
      ], // Use a list with "websocket" as the transport
      "autoConnect": false,
    });
    socket!.connect();
    socket!.emit('signin', widget.sourcechatModel!.id);
    socket!.onConnect((data) {
      print('Connected to server');
      socket?.on('message', (msg) {
        if (msg != null && msg.containsKey('message')) {
          setMessage(
            'destination',
            msg['message'],
            msg['path'],
          );
          Future.delayed(
            const Duration(milliseconds: 300),
            () {
              scrollController.animateTo(
                scrollController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            },
          );
        }
      });
    });
    print(socket!.connected);
  }

  void sendMessage(String message, int sourceId, int targetId, String path) {
    setMessage('source', message, path);
    socket!.emit('message', {
      'message': message,
      'sourceId': sourceId,
      'targetId': targetId,
      'path': path,
    });
  }

  void setMessage(String type, String message, String path) {
    MessageModel messageModel = MessageModel(
      type: type,
      message: message,
      time: DateTime.now().toString().substring(10, 16),
      path: path,
    );

    if (mounted) {
      setState(() {
        messages.add(messageModel);
      });
      if (type == 'destination') {
        showNotification(
          user: widget.sourcechatModel!.id,
          message: message,
        );
      }
    }
  }

  void onImageSend(String path, String message) async {
    print('hi there=============================================== $path');
    for (var i = 0; i < popTime; i++) {
      Navigator.of(context).pop();
    }
    setState(() {
      popTime = 0;
    });
    var request = http.MultipartRequest('POST',
        Uri.parse('https://fair-typhoon-event.glitch.me/routes/addimage'));
    request.files.add(await http.MultipartFile.fromPath('img', path));
    request.headers.addAll({
      "content-type": "multipart/from-data",
    });
    http.StreamedResponse response = await request.send();
    var httpResponse = await http.Response.fromStream(response);
    var date = json.decode(httpResponse.body);
    print(date['path']);
    setMessage('source', message, path);
    socket!.emit('message', {
      'message': message,
      'sourceId': widget.sourcechatModel!.id,
      'targetId': widget.chatModel.id,
      'path': date['path'],
    });
    print(response.statusCode);
    print(message);
  }

  TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    CamerViewPage.textEditingController.text.trim();
    socket?.disconnect();
    socket?.destroy();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/whatsapp.png'),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: CustomMediaQuery(context).screenWidth / 3 - 60,
          leading: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.arrow_back, size: 24),
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.grey[500],
                  child: SvgPicture.asset(
                    widget.chatModel.isGroup
                        ? 'assets/images/groups.svg'
                        : 'assets/images/person.svg',
                  ),
                ),
              ],
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.chatModel.name),
              Text(
                'last seen at ${widget.chatModel.time}',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          centerTitle: false,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.videocam),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.call),
            ),
            PopupMenuButton<String>(
              onSelected: (value) {
                print(value);
              },
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                    value: 'View Contact',
                    child: Text('View Contact'),
                  ),
                  const PopupMenuItem(
                    value: 'Media, Links and doc',
                    child: Text('Media, Links and doc'),
                  ),
                  const PopupMenuItem(
                    value: 'Search',
                    child: Text('Search'),
                  ),
                  const PopupMenuItem(
                    value: 'Mute Noifcation',
                    child: Text('Mute Noifcation'),
                  ),
                  const PopupMenuItem(
                    value: 'WallPaper',
                    child: Text('WallPaper'),
                  ),
                ];
              },
            ),
          ],
        ),
        body: WillPopScope(
          onWillPop: () {
            if (emojiShowing) {
              setState(() {
                emojiShowing = false;
              });
            } else {
              Navigator.pop(context);
            }
            return Future.value(false);
          },
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: messages.length + 1,
                  shrinkWrap: true,
                  controller: scrollController,
                  itemBuilder: (context, index) {
                    if (index == messages.length) {
                      return Container(
                        height: CustomMediaQuery(context).screenHeight / 15,
                      );
                    }
                    if (messages[index].type == 'source') {
                      if (messages[index].path.isNotEmpty) {
                        return OwnFileCard(
                          path: messages[index].path,
                          message: messages[index].message!,
                          time: messages[index].time!,
                        );
                      } else {
                        return OunMasseageCard(
                          sendmessage: messages[index].message,
                          time: messages[index].time,
                        );
                      }
                    } else {
                      if (messages[index].path.isNotEmpty) {
                        return ReplyFileCard(
                          path: messages[index].path,
                          message: messages[index].message!,
                          time: messages[index].time!,
                        );
                      } else {
                        return ReplyMasseageCard(
                          replyMessage: messages[index].message,
                          time: messages[index].time,
                        );
                      }
                    }
                  },
                ),
                // child: ListView(
                //   children:  [ if (messages[index].path.isNotEmpty)
                //     OwnFileCard(),
                //     ReplyFileCard(path: ,),
                //   ],
                // ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent.withOpacity(0.5),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  margin: const EdgeInsets.only(left: 2, right: 2),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            color: Colors.white,
                            onPressed: () {
                              setState(() {
                                focusNode.unfocus();
                                focusNode.canRequestFocus = false;
                                emojiShowing = !emojiShowing;
                              });
                            },
                            icon: const Icon(Icons.emoji_emotions),
                          ),
                          Expanded(
                            child: TextField(
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  setState(() {
                                    sendbtn = true;
                                  });
                                } else {
                                  setState(() {
                                    sendbtn = false;
                                  });
                                }
                              },
                              focusNode: focusNode,
                              enableSuggestions: true,
                              cursorColor: AppColors.white,
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.multiline,
                              maxLines: 5,
                              minLines: 1,
                              controller: textEditingController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: const TextStyle(
                                  color: Colors.grey,
                                ),
                                hintText: 'Type Message',
                                suffixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      color: AppColors.white,
                                      onPressed: () {
                                        showModalBottomSheet(
                                          context: context,
                                          backgroundColor: Colors.transparent,
                                          builder: (context) {
                                            return bottomsheet();
                                          },
                                        );
                                      },
                                      icon: const Icon(Icons.attach_file),
                                    ),
                                    IconButton(
                                      color: AppColors.white,
                                      onPressed: () {
                                        setState(() {
                                          popTime = 2;
                                        });
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CameraPage(
                                                      onImageSend: () =>
                                                          onImageSend(
                                                        file!.path,
                                                        CamerViewPage
                                                            .textEditingController
                                                            .text
                                                            .trim(),
                                                      ),
                                                    )));
                                      },
                                      icon: const Icon(Icons.camera),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: CircleAvatar(
                                        child: IconButton(
                                          onPressed: () {
                                            if (sendbtn &&
                                                textEditingController.text
                                                    .trim()
                                                    .isNotEmpty) {
                                              Future.delayed(
                                                const Duration(
                                                    milliseconds: 300),
                                              );
                                              scrollController.animateTo(
                                                scrollController
                                                    .position.maxScrollExtent,
                                                duration: const Duration(
                                                    milliseconds: 300),
                                                curve: Curves.easeOut,
                                              );
                                              sendMessage(
                                                textEditingController.text,
                                                widget.sourcechatModel!.id,
                                                widget.chatModel.id,
                                                '',
                                              );
                                              textEditingController.clear();
                                              setState(() {
                                                sendbtn = false;
                                              });
                                            }
                                          },
                                          icon: Icon(
                                            sendbtn ? Icons.send : Icons.mic,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                contentPadding: const EdgeInsets.all(5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              emojiShowing ? emojiSelect() : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomsheet() {
    return SizedBox(
      height: 270,
      width: CustomMediaQuery(context).screenWidth,
      child: Card(
        margin: const EdgeInsets.all(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 50,
            runSpacing: 10,
            children: [
              iconCreation(
                bgcolor: Colors.pink,
                iconData: Icons.camera_alt,
                text: 'Document',
                onTap: () {},
              ),
              iconCreation(
                bgcolor: Colors.indigo,
                iconData: Icons.insert_drive_file,
                text: 'Camera',
                onTap: () async {
                  setState(() {
                    popTime = 3;
                  });
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CameraPage(
                            onImageSend: () => onImageSend(
                              file!.path,
                              CamerViewPage.textEditingController.text.trim(),
                            ),
                          )));
                  /////////////////////////////
                },
              ),
              iconCreation(
                bgcolor: Colors.purple,
                iconData: Icons.insert_photo,
                text: 'Gallery',
                onTap: () async {
                  file =
                      await imagePicker.pickImage(source: ImageSource.gallery);
                  if (file != null && file?.path != null) {
                    Future.delayed(
                      Duration.zero,
                      () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CamerViewPage(
                                  path: file!.path,
                                  onImageSend: (p0) => onImageSend(
                                    file!.path,
                                    CamerViewPage.textEditingController.text
                                        .trim(),
                                  ),
                                )));
                      },
                    );
                  } else {
                    return;
                  }

                  setState(() {
                    popTime = 2;
                  });
                  ///////////////////////////////
                },
              ),
              iconCreation(
                bgcolor: Colors.orange,
                iconData: Icons.headset,
                text: 'Audio',
                onTap: () {},
              ),
              iconCreation(
                bgcolor: Colors.teal,
                iconData: Icons.location_pin,
                text: 'Location',
                onTap: () {},
              ),
              iconCreation(
                bgcolor: Colors.blue,
                iconData: Icons.person,
                text: 'Contact',
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconCreation({
    IconData? iconData,
    Color? bgcolor,
    String? text,
    void Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: bgcolor,
            radius: 30,
            child: Icon(
              iconData,
              size: 29,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            text!,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget emojiSelect() {
    return SizedBox(
      height: CustomMediaQuery(context).screenHeight / 5 + 140,
      child: EmojiPicker(
        onEmojiSelected: (category, emoji) {
          // textEditingController.text = textEditingController.text + emoji.emoji;
        },
        onBackspacePressed: () {
          // Do something when the user taps the backspace button (optional)
          // Set it to null to hide the Backspace-Button
        },
        textEditingController:
            textEditingController, // pass here the same [TextEditingController] that is connected to your input field, usually a [TextFormField]
        config: const Config(
          columns: 7,
          verticalSpacing: 0,
          horizontalSpacing: 0,
          gridPadding: EdgeInsets.zero,
          initCategory: Category.RECENT,
          bgColor: Color(0xFFF2F2F2),
          indicatorColor: Colors.blue,
          iconColor: Colors.grey,
          iconColorSelected: Colors.blue,
          backspaceColor: Colors.blue,
          skinToneDialogBgColor: Colors.white,
          skinToneIndicatorColor: Colors.grey,
          enableSkinTones: true,
          recentTabBehavior: RecentTabBehavior.RECENT,
          recentsLimit: 28,
          noRecents: Text(
            'No Recents',
            style: TextStyle(fontSize: 20, color: Colors.black26),
            textAlign: TextAlign.center,
          ), // Needs to be const Widget
          loadingIndicator: SizedBox.shrink(), // Needs to be const Widget
          tabIndicatorAnimDuration: kTabScrollDuration,
          categoryIcons: CategoryIcons(),
          buttonMode: ButtonMode.MATERIAL,
        ),
      ),
    );
  }
}
