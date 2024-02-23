import 'package:zomato_clone/core/env/i_env.dart';

class ProdEnv extends IEnv {
  @override
  String get baseUrl => "https://raw.githubusercontent.com/";

  @override
  EnvType get getEnvType => EnvType.prod;

  @override
  String get localDatabase => "prod_db";
}
