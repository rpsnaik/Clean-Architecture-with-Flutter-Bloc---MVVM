import 'package:dio/dio.dart';
import 'package:zomato_clone/core/env/i_env.dart';
import 'package:zomato_clone/core/handlers/network_response_handler.dart';
import 'package:zomato_clone/core/network_service/i_network_service.dart';

class NetworkService extends INetworkService {
  late Dio dio;

  NetworkService({required IEnv env}) {
    dio = Dio(BaseOptions(baseUrl: env.baseUrl));
  }

  @override
  Future<IApiResponse> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    Response response;
    try {
      response = await dio.get(path, queryParameters: queryParameters);
      return ApiResponseSuccess(
          data: response.data, statusCode: response.statusCode);
    } on DioException catch (e) {
      return ApiResponseError(
          errorMessage: e.message, statusCode: e.response?.statusCode);
    }
  }
}
