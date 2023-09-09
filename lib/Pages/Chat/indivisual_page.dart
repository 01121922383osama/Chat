import 'package:chat/constants/widgets/app_colors.dart';
import 'package:chat/constants/widgets/media_query.dart';
import 'package:chat/model/chat_model.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IndivisualPage extends StatefulWidget {
  final ChatModel chatModel;
  const IndivisualPage({Key? key, required this.chatModel}) : super(key: key);

  @override
  State<IndivisualPage> createState() => _IndivisualPageState();
}

class _IndivisualPageState extends State<IndivisualPage> {
  bool emojiShowing = false;
  FocusNode focusNode = FocusNode();
  @override
  void initState() {
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          emojiShowing = false;
        });
      }
    });
    super.initState();
  }

  TextEditingController textEditingController = TextEditingController();
  @override
  void dispose() {
    textEditingController.dispose();
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
                child: ListView(
                    // Your ListView contents go here
                    ),
              ),
              Container(
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
                                    onPressed: () {},
                                    icon: const Icon(Icons.camera),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: CircleAvatar(
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.mic,
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
              ),
              iconCreation(
                bgcolor: Colors.indigo,
                iconData: Icons.insert_drive_file,
                text: 'Camera',
              ),
              iconCreation(
                bgcolor: Colors.purple,
                iconData: Icons.insert_photo,
                text: 'Gallery',
              ),
              iconCreation(
                bgcolor: Colors.orange,
                iconData: Icons.headset,
                text: 'Audio',
              ),
              iconCreation(
                bgcolor: Colors.teal,
                iconData: Icons.location_pin,
                text: 'Location',
              ),
              iconCreation(
                bgcolor: Colors.blue,
                iconData: Icons.person,
                text: 'Contact',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconCreation({IconData? iconData, Color? bgcolor, String? text}) {
    return InkWell(
      onTap: () {},
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
