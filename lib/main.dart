import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo/presentation/components/routes.dart';
import 'package:riverpod_demo/presentation/features/home/HomeScreen.dart';
import 'package:riverpod_demo/utils/appColors.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Riverpod Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: AppColors.primary,
          ),
          textTheme: const TextTheme(
            headline2: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
            headline3: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w400),
            bodyText1: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400),
          )),
      home: const HomeScreen(),
      onGenerateRoute: AppRouter().onGenerateRoute,
    );
  }
}
