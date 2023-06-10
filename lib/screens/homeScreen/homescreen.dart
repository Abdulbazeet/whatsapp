// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:whatsapp/const/app_const.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp/screens/homeScreen/contacts/contacts.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../sharedPreference/sharedPreference.dart';
import 'chatScreen/chatScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String? newUid;
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    // tabController = TabController(length: 3, vsync: this);
  }

  Future<void> askPermission() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const Contacts(),
        ),
      );
    } else {
      _handleInvalidPermissions(permissionStatus);
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      final snackBar = SnackBar(
        content: Text(
          'Access to contact data denied',
          style: TextStyle(
              color: Colors.white, fontSize: 8.sp, fontStyle: FontStyle.italic),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      final snackBar = SnackBar(
        content: Text(
          'Contact data not available on device',
          style: TextStyle(
              color: Colors.white, fontSize: 8.sp, fontStyle: FontStyle.italic),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final user = firebaseAuth.currentUser;
    String? uid = user!.uid;
    setState(() {
      newUid = uid;
    });
    sharedPrefence().onSignIn(newUid!);
    print(newUid);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 8, 10, 10),
      body: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  title: Text(
                    'WhatsApp',
                    style: TextStyle(color: Colors.grey, fontSize: 10.sp),
                  ),
                  backgroundColor: const Color.fromARGB(255, 22, 63, 59),
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.grey,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.more_vert_outlined,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _SliverAppDelegate(
                    const TabBar(
                      labelColor: mainColor,
                      unselectedLabelColor: Colors.white,
                      indicatorColor: mainColor,
                      tabs: [
                        Tab(
                          text: 'Chats',
                        ),
                        Tab(
                          text: 'Status',
                        ),
                        Tab(
                          text: 'Call',
                        ),
                      ],
                    ),
                  ),
                )
              ];
            },
            body: const TabBarView(
              children: [
                ChatScreen(),
                Center(
                  child: Text('data'),
                ),
                Center(
                  child: Text('data'),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: 6.h,
        child: FloatingActionButton(
          onPressed: () {
            askPermission();
          },
          backgroundColor: mainColor,
          child: const Icon(
            Icons.message,
          ),
        ),
      ),
    );
  }
}

class _SliverAppDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppDelegate(this.tabBar);
  final TabBar tabBar;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: const Color.fromARGB(255, 22, 63, 59),
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
