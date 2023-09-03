import 'package:chat/constants/widgets/app_colors.dart';
import 'package:chat/constants/widgets/media_query.dart';
import 'package:chat/model/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IndivisualPage extends StatefulWidget {
  final ChatModel chatModel;
  const IndivisualPage({Key? key, required this.chatModel}) : super(key: key);

  @override
  State<IndivisualPage> createState() => _IndivisualPageState();
}

class _IndivisualPageState extends State<IndivisualPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Column(
        children: [
          Expanded(
            child: ListView(
                // Your ListView contents go here
                ),
          ),
          Row(
            children: [
              Expanded(
                child: Card(
                  color: Colors.transparent.withOpacity(0.5),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  margin: const EdgeInsets.only(left: 2, right: 2),
                  child: Container(
                    height: CustomMediaQuery(context).screenHeight / 12,
                    alignment: Alignment.center,
                    child: TextField(
                      enableSuggestions: true,
                      cursorColor: AppColors.white,
                      textAlignVertical: TextAlignVertical.center,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      minLines: 1,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        hintText: 'Type Message',
                        prefixIcon: IconButton(
                          color: AppColors.white,
                          onPressed: () {},
                          icon: const Icon(Icons.emoji_emotions),
                        ),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              color: AppColors.white,
                              onPressed: () {},
                              icon: const Icon(Icons.attach_file),
                            ),
                            IconButton(
                              color: AppColors.white,
                              onPressed: () {},
                              icon: const Icon(Icons.camera),
                            ),
                          ],
                        ),
                        contentPadding: const EdgeInsets.all(5),
                      ),
                    ),
                  ),
                ),
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
        ],
      ),
    );
  }
}
