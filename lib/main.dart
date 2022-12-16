import 'package:flutter/material.dart';

import 'routes/routes.dart';

void main() => runApp(Myapp());


class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
      initialRoute: 'login',
      routes: appRoutes,
    );
  }
}
