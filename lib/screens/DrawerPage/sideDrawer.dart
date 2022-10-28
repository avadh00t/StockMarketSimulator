import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xffff533048),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Center(
                child: Icon(
                  Icons.account_circle_rounded,
                  size: 80,
                ),
              ),
            ),
            accountName: Text('hello worlds'),
            accountEmail: Text('hello worlds'),
            decoration: BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                  image: AssetImage(
                    'assets/images/profileBackgroundImage.bmp',
                  ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.person,
              color: Colors.white,
            ),
            title: Text(
              'User Profile',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(
              Icons.bookmark,
              color: Colors.white,
            ),
            title: Text(
              'Watchlist',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(
              Icons.shopping_bag_rounded,
              color: Colors.white,
            ),
            title: Text(
              'Portfolio',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(
              Icons.save,
              color: Colors.white,
            ),
            title: Text(
              'Transactions',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: (){},
          ),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.3,
            ),
            child: ListTile(
              leading: Icon(
                Icons.logout_rounded,
                color: Colors.white,
              ),
              title: Text(
                'Sign out',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: (){},
            ),
          )
        ],
      ),
    );
  }
}
