enum EnvType{
  prod,
  test
}

abstract class IEnv{
  String get baseUrl;
  String get localDatabase;
  EnvType get getEnvType;
}