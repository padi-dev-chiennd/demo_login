import 'package:demologin/Coin/bit_coin.dart';
import 'package:demologin/home/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Navigate extends StatefulWidget {
  const Navigate({super.key});

  @override
  State<Navigate> createState() => _NavigateState();
}

class _NavigateState extends State<Navigate> {
  final NavigationController navigationController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            arrowColor: Colors.blueAccent,
            accountName: Text("architect"),
            accountEmail: const Text("chiennd@padietch.com"),
            currentAccountPicture: CircleAvatar(
                child: ClipOval(child: Image.asset('images/img1.png'))),
          ),
          ListTile(
            leading: const Icon(Icons.image,color: Colors.blue),
            title: const Text('API'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>   BitCoin()));
              // Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.abc_outlined),
            title: const Text('Item 2'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
