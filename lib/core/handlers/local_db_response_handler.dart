abstract class ILocalDatabaseResponse {
  dynamic data;
  bool get hasError => errorMessage != null;
  String? errorMessage;

  ILocalDatabaseResponse({this.data, this.errorMessage});
}

class DbResponseSuccess extends ILocalDatabaseResponse {
  DbResponseSuccess({required super.data});
}

class DbResponseError extends ILocalDatabaseResponse {
  DbResponseError({required super.errorMessage});
}
