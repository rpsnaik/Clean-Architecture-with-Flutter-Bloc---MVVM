abstract class IApiResponse {
  dynamic data;
  bool get hasError => errorMessage != null;
  String? errorMessage;
  int? statusCode;

  IApiResponse({this.data, this.errorMessage, this.statusCode});
}

class ApiResponseSuccess extends IApiResponse {
  ApiResponseSuccess({required super.data, required super.statusCode});
}

class ApiResponseError extends IApiResponse {
  ApiResponseError({required super.errorMessage, required super.statusCode});
}
