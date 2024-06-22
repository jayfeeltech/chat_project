import 'dart:async';

import 'package:chat_project/colors.dart';
import 'package:chat_project/helper.dart';
import 'package:chat_project/models/message_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jiffy/jiffy.dart';

import '../widgets/avatar.dart';
import '../widgets/glowing_button.dart';
import '../widgets/icons_button.dart';

class ChatScreen extends StatelessWidget {
  static Route route(MessageData data) => MaterialPageRoute(
        builder: (context) => ChatScreen(messageData: data),
      );

  ChatScreen({super.key, required this.messageData});
  MessageData messageData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 54,
        elevation: 0,
        leading: Align(
          alignment: Alignment.centerRight,
          child: IconBackground(
            icon: CupertinoIcons.back,
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        title: _AppBarTitle(
          messageData: messageData,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Center(
              child: IconBorder(
                icon: CupertinoIcons.video_camera_solid,
                onTap: () {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Center(
              child: IconBorder(
                icon: CupertinoIcons.phone_solid,
                onTap: () {},
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          
          Expanded(
            child: _DateLable(
             dateTime:DateTime.now()),
          ),
       _ActionBar(),
       SizedBox(height: 10,),
        ],
      ),
    );
  }
}

class _AppBarTitle extends StatelessWidget {
  MessageData messageData;
  _AppBarTitle({Key? key, required this.messageData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final channel = StreamChannel.of(context).channel;
    return Row(
      children: [
        Avatar.small(
          url: Helpers.randomPictureUrl(),
          //  url: Helpers.getChannelImage(channel, context.currentUser!),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                messageData.senderName,
                //  Helpers.getChannelName(channel, context.currentUser!),
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 2),
              Text(
                'Offline',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              // BetterStreamBuilder<List<Member>>(
              //   stream: channel.state!.membersStream,
              //   initialData: channel.state!.members,
              //   builder: (context, data) => ConnectionStatusBuilder(
              //     statusBuilder: (context, status) {
              //       switch (status) {
              //         case ConnectionStatus.connected:
              //           return _buildConnectedTitleState(context, data);
              //         case ConnectionStatus.connecting:
              //           return const Text(
              //             'Connecting',
              //             style: TextStyle(
              //               fontSize: 10,
              //               fontWeight: FontWeight.bold,
              //               color: Colors.green,
              //             ),
              //           );
              //         case ConnectionStatus.disconnected:
              //           return const Text(
              //             'Offline',
              //             style: TextStyle(
              //               fontSize: 10,
              //               fontWeight: FontWeight.bold,
              //               color: Colors.red,
              //             ),
              //           );
              //         default:
              //           return const SizedBox.shrink();
              //       }
              //     },
              //   ),
              // ),
            ],
          ),
        )
      ],
    );
  }
}


// class _MessageList extends StatelessWidget {
//   const _MessageList({
//     Key? key,
//     required this.messages,
//   }) : super(key: key);

//   final List<Message> messages;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: ListView.separated(
//         itemCount: messages.length + 1,
//         reverse: true,
//         separatorBuilder: (context, index) {
//           if (index == messages.length - 1) {
//             return _DateLable(dateTime: messages[index].createdAt);
//           }
//           if (messages.length == 1) {
//             return const SizedBox.shrink();
//           } else if (index >= messages.length - 1) {
//             return const SizedBox.shrink();
//           } else if (index <= messages.length) {
//             final message = messages[index];
//             final nextMessage = messages[index + 1];
//             // if (!Jiffy(message.createdAt.toLocal())
//             //     .isSame(nextMessage.createdAt.toLocal(), Units.DAY)) {
//             //   return _DateLable(
//             //     dateTime: message.createdAt,
//             //   );
//             // }
//             //  else {
//             //   return const SizedBox.shrink();
//             // }
//           } else {
//             return const SizedBox.shrink();
//           }
//         },
//         itemBuilder: (context, index) {
//           if (index < messages.length) {
//             final message = messages[index];

//             // if (message.user?.id == context.currentUser?.id) {
//             //   return _MessageOwnTile(message: message);
//             // } else {
//             //   return _MessageTile(message: message);
//             // }
//           } else {
//             return const SizedBox.shrink();
//           }
//         },
//       ),
//     );
//   }
// }






class _DateLable extends StatefulWidget {
  const _DateLable({
    Key? key,
    required this.dateTime,
  }) : super(key: key);

  final DateTime dateTime;

  @override
  __DateLableState createState() => __DateLableState();
}

class __DateLableState extends State<_DateLable> {
   String? dayInfo;

  @override
  void initState() {
   
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12),
            child: Text(
              dayInfo ?? 'Today',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.textFaded,
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class _MessageOwnTile extends StatelessWidget {
  const _MessageOwnTile({
    Key? key,
   // required this.message,
  }) : super(key: key);

  //final Message message;

  static const _borderRadius = 26.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_borderRadius),
                  bottomRight: Radius.circular(_borderRadius),
                  bottomLeft: Radius.circular(_borderRadius),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
                child: Text(
                //  message.text ?? 
                  '',
                    style: const TextStyle(
                      color: AppColors.textLigth,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                '',
               // Jiffy.parse(message.createdAt.toLocal()).jm,
                style: const TextStyle(
                  color: AppColors.textFaded,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}




class _MessageTile extends StatelessWidget {
  const _MessageTile({
    Key? key,
   // required this.message,
  }) : super(key: key);

  //final Message message;

  static const _borderRadius = 26.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(_borderRadius),
                  topRight: Radius.circular(_borderRadius),
                  bottomRight: Radius.circular(_borderRadius),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
                child: Text(
               //   message.text ??
                   ''),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                '',
               // Jiffy.parse(message.createdAt.toLocal()).jm,
                style: const TextStyle(
                  color: AppColors.textFaded,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


class _ActionBar extends StatefulWidget {
  const _ActionBar({Key? key}) : super(key: key);

  @override
  __ActionBarState createState() => __ActionBarState();
}

class __ActionBarState extends State<_ActionBar> {
  // final StreamMessageInputController controller =
  //     StreamMessageInputController();

  Timer? _debounce;

  // Future<void> _sendMessage() async {
  //   if (controller.text.isNotEmpty) {
  //     StreamChannel.of(context).channel.sendMessage(controller.message);
  //     controller.clear();
  //     FocusScope.of(context).unfocus();
  //   }
  // }

  // void _onTextChange() {
  //   if (_debounce?.isActive ?? false) _debounce?.cancel();
  //   _debounce = Timer(const Duration(seconds: 1), () {
  //     if (mounted) {
  //       StreamChannel.of(context).channel.keyStroke();
  //     }
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   controller.addListener(_onTextChange);
  // }

  // @override
  // void dispose() {
  //   controller.removeListener(_onTextChange);
  //   controller.dispose();

  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  width: 2,
                  color: Theme.of(context).dividerColor,
                ),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(
                CupertinoIcons.camera_fill,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: TextField(
             //   controller: controller.textEditingController,
                onChanged: (val) {
                //  controller.text = val;
                },
                style: const TextStyle(fontSize: 14),
                decoration: const InputDecoration(
                  hintText: 'Type something...',
                  border: InputBorder.none,
                ),
               // onSubmitted: (_) => _sendMessage(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 12,
              right: 24.0,
            ),
            child: GlowingActionButton(
              color: AppColors.accent,
              icon: Icons.send_rounded,
              onPressed: (){},
             // onPressed: _sendMessage,
            ),
          ),
        ],
      ),
    );
  }
}