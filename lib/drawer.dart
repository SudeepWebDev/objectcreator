import 'package:flutter/material.dart';
import 'package:objectcreator/documentation.dart';

class ObjDrawer extends StatelessWidget {
  const ObjDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
                // color: Colors.blue,
                ),
            child: Center(child: Text('Timetable Object Creator')),
          ),
          ListTile(
            title: const Text('Documentation'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DocumentationScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
