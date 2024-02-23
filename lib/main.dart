import 'package:flutter/material.dart';
import 'package:zomato_clone/core/env/i_env.dart';
import 'package:zomato_clone/core/env/prod_env.dart';
import 'package:zomato_clone/core/service_locators/service_locators.dart';
import 'package:zomato_clone/features/restarunts/presentation/pages/restarunts_screen.dart';

void main() {
  IEnv env = ProdEnv();
  ServiceLocators(env: env).initServices();
  runApp(const MaterialApp(
    home: BaseApp(),
  ));
}

class BaseApp extends StatefulWidget {
  const BaseApp({super.key});

  @override
  State<BaseApp> createState() => _BaseAppState();
}

class _BaseAppState extends State<BaseApp> {
  @override
  Widget build(BuildContext context) {
    return RestaruntsScreen();
  }
}
