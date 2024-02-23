import 'package:zomato_clone/core/env/i_env.dart';

class TestEnv extends IEnv {
  @override
  String get baseUrl => "https://raw.githubusercontent.com/";

  @override
  EnvType get getEnvType => EnvType.test;

  @override
  String get localDatabase => "test_db";
}
