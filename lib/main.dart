import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import '/pages/widgets/register.dart';
void main() {
  runApp(const MyApp());
}
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   cameras = await availableCameras();
//  }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        'register' :(context) => Register_Page(),
        'login' :(context) => LoginPage(),
      },
      home: LoginPage(),
    );
  }
}


