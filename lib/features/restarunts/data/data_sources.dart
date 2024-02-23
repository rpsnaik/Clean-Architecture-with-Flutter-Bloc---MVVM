import 'package:get_it/get_it.dart';
import 'package:zomato_clone/core/handlers/network_response_handler.dart';
import 'package:zomato_clone/core/network_service/i_network_service.dart';

abstract class IRestaruntsApiService {
  Future<IApiResponse> fetchRestaruntsData();
}

class RestaruntsApiService extends IRestaruntsApiService {
  late INetworkService networkService;

  RestaruntsApiService({INetworkService? service})
      : networkService = service ?? GetIt.I.get<INetworkService>();

  @override
  Future<IApiResponse> fetchRestaruntsData() {
    return networkService.get("/rpsnaik/Hello-Angular/master/food_items.json");
  }
}
