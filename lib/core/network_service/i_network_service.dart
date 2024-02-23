import 'package:zomato_clone/core/handlers/network_response_handler.dart';

abstract class INetworkService {
  Future<IApiResponse> get(String path, {Map<String, dynamic>? queryParameters});
}