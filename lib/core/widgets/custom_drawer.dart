import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final Function(int) onTabSelected;
  const CustomDrawer({super.key, required this.onTabSelected});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 46, horizontal: 32),
        children: [
          drawerPageItem(context, Icons.info_outline, "About", '/AboutView'),
          drawerPageItem(
            context,
            Icons.email_outlined,
            "Contact Us",
            '/ContactUsView',
          ),
          drawerPageItem(context, Icons.article_outlined, "Blog", '/BlogView'),
          drawerPageItem(
            context,
            Icons.settings_outlined,
            "Settings",
            '/SettingsView',
          ),
        ],
      ),
    );
  }

  Widget drawerTabItem(
    BuildContext context,
    IconData icon,
    String title,
    int index,
  ) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueGrey[700]),
      title: Text(title, style: TextStyle(color: Colors.blueGrey[700])),
      onTap: () {
        Navigator.pop(context);
        onTabSelected(index);
      },
    );
  }

  Widget drawerPageItem(
    BuildContext context,
    IconData icon,
    String title,
    String route,
  ) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueGrey[700]),
      title: Text(title, style: TextStyle(color: Colors.blueGrey[700])),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, route);
      },
    );
  }
}
