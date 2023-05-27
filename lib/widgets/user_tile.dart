import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shop/screens/user_detail_screen.dart';

class UserTile extends StatelessWidget {
  final String userName;
  final String subtitle;
  const UserTile({super.key, required this.userName, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(25)),
      ),
      title: Text(userName),
      subtitle: Text(subtitle),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: ((context) => UserDetailScreen(
                  name: userName,
                  mail: subtitle,
                )),
          ),
        );
      },
    );
  }
}
