import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
    required this.themeService,
    required this.notificationService,
    required this.userName,
    required this.userEmail,
    required this.userImageUrl,
  });

  final dynamic themeService;
  final dynamic notificationService;
  final String userName;
  final String userEmail;
  final String userImageUrl;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: const [
          DrawerHeader(child: Text("Pegasus")),
          ListTile(title: Text("Dashboard"), leading: Icon(Icons.dashboard)),
        ],
      ),
    );
  }
}
