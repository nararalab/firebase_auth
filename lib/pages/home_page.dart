import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'profile_page.dart';
import '../providers/auth/auth_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String routeName = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('홈'),
          actions: [
            IconButton(
              onPressed: () {
                context.read<AuthProvider>().signout();
              },
              icon: const Icon(Icons.exit_to_app),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const ProfilePage();
                  }),
                );
              },
              icon: const Icon(Icons.account_circle),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/flutter_favorite.png',
                    width: 100,
                  ),
                  const SizedBox(width: 20.0),
                  const Text(
                    '환영합니다',
                    style: TextStyle(fontSize: 42.0),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              const Text(
                '로그인된 홈화면입니다.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
