import 'package:chat_project/colors.dart';
import 'package:chat_project/pages/calls_screen.dart';
import 'package:chat_project/pages/contact_screen.dart';
import 'package:chat_project/pages/messages_screen.dart';
import 'package:chat_project/pages/notification_screen.dart';
import 'package:chat_project/widgets/glowing_button.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helper.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ValueNotifier<int> pageindex = ValueNotifier(0);
  final ValueNotifier<String> titleindex = ValueNotifier('Messages');
  final Page = [MessageScreen(), NotificationScreen(), Cal(), ContactScreen()];
  final title = [
    'Messages',
    'Notification',
    'Calls',
    'Contacts',
  ];
  void _onNavigationitemSelected(value) {
    pageindex.value = value;
    titleindex.value = title[value];
    print(value);
  }

  @override
  Widget build(BuildContext context) {
    pageindex.addListener(() {});
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leadingWidth: 54,
        leading: Align(
          alignment: Alignment.centerRight,
          child: IconBackground(
              icon: Icons.search,
              onTap: () {
                print('todo search');
              }),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Avatar.small(
              url: Helpers.randomPictureUrl(),
            ),
          )
        ],
        title: ValueListenableBuilder(
          valueListenable: titleindex,
          builder: (context, value, _) {
            return Text(
              value,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            );
          },
        ),
        backgroundColor: Colors.transparent,
      ),
      body: ValueListenableBuilder(
        valueListenable: pageindex,
        builder: (context, value, _) {
          return Page[value];
        },
      ),
      bottomNavigationBar: _BottomNavigationBar(
        selectedvalue: _onNavigationitemSelected,
      ),
    );
  }
}

class _BottomNavigationBar extends StatefulWidget {
  final ValueChanged<int> selectedvalue;
  const _BottomNavigationBar({super.key, required this.selectedvalue});

  @override
  State<_BottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<_BottomNavigationBar> {
  var selectdindex = 0;
  handelitemSelected(int index) {
    setState(() {
      selectdindex = index;
    });
    widget.selectedvalue(index);
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Card(
      color: (brightness == Brightness.light) ? Colors.transparent : null,
      elevation: 0,
      margin: EdgeInsets.all(0),
      child: SafeArea(
          top: false,
          bottom: false,
          child: Padding(
            padding:
                const EdgeInsets.only(bottom: 20, top: 16, left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                NavigationBarItem(
                  isSelected: (selectdindex == 0),
                  onTap: handelitemSelected,
                  index: 0,
                  text: 'Message',
                  icon: CupertinoIcons.bubble_left_bubble_right_fill,
                ),
                NavigationBarItem(
                  isSelected: (selectdindex == 1),
                  onTap: handelitemSelected,
                  index: 1,
                  text: 'Notification',
                  icon: CupertinoIcons.bell_solid,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GlowingActionButton(
                    color: AppColors.secondary,
                    icon: Icons.add,
                    onPressed: () {},
                  ),
                ),
                NavigationBarItem(
                  isSelected: (selectdindex == 2),
                  onTap: handelitemSelected,
                  index: 2,
                  text: 'Calls',
                  icon: CupertinoIcons.phone_fill,
                ),
                NavigationBarItem(
                  isSelected: (selectdindex == 3),
                  onTap: handelitemSelected,
                  index: 3,
                  text: 'Contact',
                  icon: CupertinoIcons.person_2_fill,
                ),
              ],
            ),
          )),
    );
  }
}

class NavigationBarItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final int index;
  final bool isSelected;
  ValueChanged<int> onTap;
  NavigationBarItem({
    super.key,
    required this.text,
    required this.icon,
    required this.index,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap(index);
      },
      child: SizedBox(
        width:65,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? AppColors.secondary : null,
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              '${text}',
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? AppColors.secondary : null,
                fontWeight: isSelected ? FontWeight.bold : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
