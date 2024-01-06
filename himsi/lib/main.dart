import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/mahasiswa_list.dart';
import 'screens/add_mahasiswa.dart';
import 'api_manager.dart';
import 'user_manager.dart';
import 'screens/update_mahasiswa.dart';
import 'screens/mahasiswa_detail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ApiManager apiManager = ApiManager(baseUrl: 'http://192.168.114.104:8000/api');

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserManager()),
        Provider.value(value: apiManager),
      ],
      child: MaterialApp(
        title: 'HIMSI',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
          '/mahasiswalist': (context) => MahasiswaList(),
          '/addmahasiswa': (context) => AddMahasiswaScreen(),
          // '/updatemahasiswa': (context) => UpdateMahasiswaScreen(),
          // '/detailmahasiswa': (context) => MahasiswaDetail(),
        },
      ),
    );
  }
}